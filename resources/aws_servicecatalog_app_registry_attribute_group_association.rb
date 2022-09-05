# Import API specifics
use "awscc_base"

resource_name :aws_servicecatalog_app_registry_attribute_group_association
provides :aws_servicecatalog_app_registry_attribute_group_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Schema for AWS::ServiceCatalogAppRegistry::AttributeGroupAssociation.
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

property :attribute_group, String,
         required: true,
         callbacks: {
           "attribute_group is not a String" => lambda { |v| v.is_a? String },
           "attribute_group needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "attribute_group must match pattern \w+|[a-z0-9]{12}" => lambda { |v| v =~ Regexp.new("/\w+|[a-z0-9]{12}/") },
         },
         description: <<~'DESCRIPTION'
           The name or the Id of the AttributeGroup.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ServiceCatalogAppRegistry::AttributeGroupAssociation"
rest_api_document "/AWS::ServiceCatalogAppRegistry::AttributeGroupAssociation"

rest_property_map({
  application:     "Application",
  attribute_group: "AttributeGroup",
})

