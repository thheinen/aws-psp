# Import API specifics
use "awscc_base"

unified_mode true
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
         description: <<~'DESCRIPTION'
           The AMP Workspace alert manager definition data
         DESCRIPTION

property :alias, String,
         callbacks: {
           "alias is not a String" => lambda { |v| v.is_a? String },
           "alias needs to be 0..100 characters" => lambda { |v| v.length >= 0 && v.length <= 100 },
         },
         description: <<~'DESCRIPTION'
           AMP Workspace alias.
         DESCRIPTION

property :logging_configuration, Hash,
         callbacks: {
           "Subproperty `LogGroupArn` is not a String" => lambda { |v| v[:LogGroupArn].is_a? String },
           "Subproperty `LogGroupArn` needs to be 0..512 characters" => lambda { |v| v[:LogGroupArn].length >= 0 && v[:LogGroupArn].length <= 512 },
           "Subproperty `LogGroupArn`is not a valid ARN" => lambda { |v| v[:LogGroupArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
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
rest_api_collection "/AWS::APS::Workspace"
rest_api_document "/AWS::APS::Workspace"

rest_property_map({
  alert_manager_definition: "AlertManagerDefinition",
  alias:                    "Alias",
  logging_configuration:    "LoggingConfiguration",
  tags:                     "Tags",
})

