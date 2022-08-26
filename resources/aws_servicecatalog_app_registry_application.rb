# Import API specifics
use "awscc_base"

resource_name :aws_servicecatalog_app_registry_application
provides :aws_servicecatalog_app_registry_application, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Schema for AWS::ServiceCatalogAppRegistry::Application
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The description of the application. "

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "name must match pattern \w+" => lambda { |v| v =~ Regexp.new("/\w+/") },
         },
         description: "The name of the application. "

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::ServiceCatalogAppRegistry::Application"
rest_api_document "/AWS::ServiceCatalogAppRegistry::Application"

rest_property_map({
  description: "Description",
  name:        "Name",
  tags:        "Tags",
})

