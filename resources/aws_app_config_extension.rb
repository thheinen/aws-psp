# Import API specifics
use "awscc_base"

resource_name :aws_app_config_extension
provides :aws_app_config_extension, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::AppConfig::Extension
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :actions, Hash,
         required: true,
         callbacks: {
           "actions is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Description of the extension.
         DESCRIPTION

property :latest_version_number, Integer,
         callbacks: {
           "latest_version_number is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Name of the extension.
         DESCRIPTION

property :parameters, Hash,
         callbacks: {
           "parameters is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value tags to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::AppConfig::Extension"
rest_api_document "/AWS::AppConfig::Extension"

rest_property_map({
  actions:               "Actions",
  description:           "Description",
  latest_version_number: "LatestVersionNumber",
  name:                  "Name",
  parameters:            "Parameters",
  tags:                  "Tags",
})

rest_post_only_properties %i{
  name tags tags/*/key tags/*/value
}
