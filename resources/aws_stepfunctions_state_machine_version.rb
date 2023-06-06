# Import API specifics
use "awscc_base"

resource_name :aws_stepfunctions_state_machine_version
provides :aws_stepfunctions_state_machine_version, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for StateMachineVersion
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
         },
         description: ""

property :state_machine_arn, String,
         required: true,
         callbacks: {
           "state_machine_arn is not a String" => lambda { |v| v.is_a? String },
           "state_machine_arn needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
         },
         description: ""

property :state_machine_revision_id, String,
         callbacks: {
           "state_machine_revision_id is not a String" => lambda { |v| v.is_a? String },
           "state_machine_revision_id needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::StepFunctions::StateMachineVersion"
rest_api_document "/AWS::StepFunctions::StateMachineVersion"

rest_property_map({
  description:               "Description",
  state_machine_arn:         "StateMachineArn",
  state_machine_revision_id: "StateMachineRevisionId",
})

rest_post_only_properties %i{
  state_machine_arn state_machine_revision_id
}
