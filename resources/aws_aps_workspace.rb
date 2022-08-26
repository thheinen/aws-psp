# Import API specifics
use "awscc_base"

resource_name :aws_aps_workspace
provides :aws_aps_workspace, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::APS::Workspace
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :alert_manager_definition, String,
         callbacks: {
           "alert_manager_definition is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The AMP Workspace alert manager definition data"

property :alias, String,
         callbacks: {
           "alias is not a String" => lambda { |v| v.is_a? String },
           "alias needs to be 0..100 characters" => lambda { |v| v.length >= 0 && v.length <= 100 },
         },
         description: "AMP Workspace alias."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "An array of key-value pairs to apply to this resource."

# API URLs and mappings
rest_api_collection "/AWS::APS::Workspace"
rest_api_document "/AWS::APS::Workspace"

rest_property_map({
  alert_manager_definition: "AlertManagerDefinition",
  alias:                    "Alias",
  tags:                     "Tags",
})

