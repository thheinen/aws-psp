# Import API specifics
use "awscc_base"

resource_name :aws_app_config_extension_association
provides :aws_app_config_extension_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  An example resource schema demonstrating some basic constructs and validation rules.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :extension_identifier, String,
         callbacks: {
           "extension_identifier is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :extension_version_number, Integer,
         callbacks: {
           "extension_version_number is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :parameters, Hash,
         callbacks: {
           "parameters is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :resource_identifier, String,
         callbacks: {
           "resource_identifier is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::AppConfig::ExtensionAssociation"
rest_api_document "/AWS::AppConfig::ExtensionAssociation"

rest_property_map({
  extension_identifier:     "ExtensionIdentifier",
  extension_version_number: "ExtensionVersionNumber",
  parameters:               "Parameters",
  resource_identifier:      "ResourceIdentifier",
  tags:                     "Tags",
})

rest_post_only_properties %i{
  extension_identifier extension_version_number resource_identifier tags tags/*/key tags/*/value
}
