# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_stepfunctions_state_machine
provides :aws_stepfunctions_state_machine, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for StateMachine
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :definition, Hash,
         callbacks: {
           "definition is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :definition_s3_location, Hash,
         callbacks: {
           "Subproperty `Bucket` is not a String" => lambda { |v| v[:Bucket].is_a? String },
           "Subproperty `Key` is not a String" => lambda { |v| v[:Key].is_a? String },
           "Subproperty `Version` is not a String" => lambda { |v| v[:Version].is_a? String },
         },
         description: ""

property :definition_string, String,
         callbacks: {
           "definition_string is not a String" => lambda { |v| v.is_a? String },
           "definition_string needs to be 1..1048576 characters" => lambda { |v| v.length >= 1 && v.length <= 1048576 },
         },
         description: ""

property :definition_substitutions, Hash,
         callbacks: {
           "definition_substitutions is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :logging_configuration, Hash,
         callbacks: {
           "Subproperty `Level` is not a String" => lambda { |v| v[:Level].is_a? String },
           "Subproperty `Level`is not one of `ALL`, `ERROR`, `FATAL`, `OFF`" => lambda { |v| %w{ALL ERROR FATAL OFF}.include? v[:Level] },
           "Subproperty `IncludeExecutionData` is not a Boolean" => lambda { |v| v[:IncludeExecutionData].is_a? Boolean },
           "Subproperty `Destinations` is not a Array" => lambda { |v| v[:Destinations].is_a? Array },
         },
         description: ""

property :role_arn, String,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
           "role_arn needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
         },
         description: ""

property :state_machine_name, String,
         callbacks: {
           "state_machine_name is not a String" => lambda { |v| v.is_a? String },
           "state_machine_name needs to be 1..80 characters" => lambda { |v| v.length >= 1 && v.length <= 80 },
         },
         description: ""

property :state_machine_type, String,
         callbacks: {
           "state_machine_type is not a String" => lambda { |v| v.is_a? String },
           "state_machine_typeis not one of `STANDARD`, `EXPRESS`" => lambda { |v| %w{STANDARD EXPRESS}.include? v },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tracing_configuration, Hash,
         callbacks: {
           "Subproperty `Enabled` is not a Boolean" => lambda { |v| v[:Enabled].is_a? Boolean },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::StepFunctions::StateMachine"
rest_api_document "/AWS::StepFunctions::StateMachine"

rest_property_map({
  definition:               "Definition",
  definition_s3_location:   "DefinitionS3Location",
  definition_string:        "DefinitionString",
  definition_substitutions: "DefinitionSubstitutions",
  logging_configuration:    "LoggingConfiguration",
  role_arn:                 "RoleArn",
  state_machine_name:       "StateMachineName",
  state_machine_type:       "StateMachineType",
  tags:                     "Tags",
  tracing_configuration:    "TracingConfiguration",
})

rest_post_only_properties %i{
  state_machine_name state_machine_type
}
