# Import API specifics
use "awscc_base"

resource_name :aws_servicecatalog_app_registry_resource_association
provides :aws_servicecatalog_app_registry_resource_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Schema for AWS::ServiceCatalogAppRegistry::ResourceAssociation
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :application, String,
         required: true,
         callbacks: {
           "application is not a String" => lambda { |v| v.is_a? String },
           "application needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "application must match pattern \w+|[a-z0-9]{12}" => lambda { |v| v =~ Regexp.new("/\w+|[a-z0-9]{12}/") },
         },
         description: <<~'DESCRIPTION'
           The name or the Id of the Application.
         DESCRIPTION

property :resource, String,
         required: true,
         callbacks: {
           "resource is not a String" => lambda { |v| v.is_a? String },
           "resource must match pattern \w+|arn:aws[-a-z]*:cloudformation:[a-z]{2}(-gov)?-[a-z]+-\d:\d{12}:stack/[a-zA-Z][-A-Za-z0-9]{0,127}/[0-9a-f]{8}(-[0-9a-f]{4}){3}-[0-9a-f]{12}" => lambda { |v| v =~ Regexp.new("/\w+|arn:aws[-a-z]*:cloudformation:[a-z]{2}(-gov)?-[a-z]+-\d:\d{12}:stack/[a-zA-Z][-A-Za-z0-9]{0,127}/[0-9a-f]{8}(-[0-9a-f]{4}){3}-[0-9a-f]{12}/") },
         },
         description: <<~'DESCRIPTION'
           The name or the Id of the Resource.
         DESCRIPTION

property :resource_type, String,
         required: true,
         callbacks: {
           "resource_type is not a String" => lambda { |v| v.is_a? String },
           "resource_typeis not one of `CFN_STACK`" => lambda { |v| %w{CFN_STACK}.include? v },
         },
         description: <<~'DESCRIPTION'
           The type of the CFN Resource for now it's enum CFN_STACK.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ServiceCatalogAppRegistry::ResourceAssociation"
rest_api_document "/AWS::ServiceCatalogAppRegistry::ResourceAssociation"

rest_property_map({
  application:   "Application",
  resource:      "Resource",
  resource_type: "ResourceType",
})

