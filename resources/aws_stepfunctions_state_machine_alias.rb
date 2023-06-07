# Import API specifics
use "awscc_base"

resource_name :aws_stepfunctions_state_machine_alias
provides :aws_stepfunctions_state_machine_alias, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for StateMachineAlias
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :deployment_preference, Hash,
         callbacks: {
           "Subproperty `StateMachineVersionArn` is not a String" => lambda { |v| v[:StateMachineVersionArn].is_a? String },
           "Subproperty `StateMachineVersionArn` needs to be 1..2048 characters" => lambda { |v| v[:StateMachineVersionArn].length >= 1 && v[:StateMachineVersionArn].length <= 2048 },
           "Subproperty `StateMachineVersionArn`is not a valid ARN" => lambda { |v| v[:StateMachineVersionArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `Type` is not a String" => lambda { |v| v[:Type].is_a? String },
           "Subproperty `Type`is not one of `LINEAR`, `ALL_AT_ONCE`, `CANARY`" => lambda { |v| %w{LINEAR ALL_AT_ONCE CANARY}.include? v[:Type] },
           "Subproperty `Percentage` is not a Integer" => lambda { |v| v[:Percentage].is_a? Integer },
           "Subproperty `Interval` is not a Integer" => lambda { |v| v[:Interval].is_a? Integer },
           "Subproperty `Alarms` is not a Array" => lambda { |v| v[:Alarms].is_a? Array },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
         },
         description: <<~'DESCRIPTION'
           An optional description of the alias.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..80 characters" => lambda { |v| v.length >= 1 && v.length <= 80 },
         },
         description: <<~'DESCRIPTION'
           The alias name.
         DESCRIPTION

property :routing_configuration, Hash,
         callbacks: {
           "routing_configuration is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::StepFunctions::StateMachineAlias"
rest_api_document "/AWS::StepFunctions::StateMachineAlias"

rest_property_map({
  deployment_preference: "DeploymentPreference",
  description:           "Description",
  name:                  "Name",
  routing_configuration: "RoutingConfiguration",
})

rest_post_only_properties %i{
  name
}
