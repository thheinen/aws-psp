# Import API specifics
use "awscc_base"

resource_name :aws_servicecatalog_app_registry_attribute_group
provides :aws_servicecatalog_app_registry_attribute_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Schema for AWS::ServiceCatalogAppRegistry::AttributeGroup.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :attributes, Hash,
         required: true,
         callbacks: {
           "attributes is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The description of the attribute group.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "name must match pattern \w+" => lambda { |v| v =~ Regexp.new("/\w+/") },
         },
         description: <<~'DESCRIPTION'
           The name of the attribute group.
         DESCRIPTION

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::ServiceCatalogAppRegistry::AttributeGroup"
rest_api_document "/AWS::ServiceCatalogAppRegistry::AttributeGroup"

rest_property_map({
  attributes:  "Attributes",
  description: "Description",
  name:        "Name",
  tags:        "Tags",
})

