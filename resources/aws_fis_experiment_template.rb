# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_fis_experiment_template
provides :aws_fis_experiment_template, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::FIS::ExperimentTemplate
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :actions, Hash,
         callbacks: {
           "actions is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :description, Hash,
         required: true,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :log_configuration, Hash,
         callbacks: {
           "Subproperty `CloudWatchLogsConfiguration` is not a Object" => lambda { |v| v[:CloudWatchLogsConfiguration].is_a? Object },
           "Subproperty `S3Configuration` is not a Object" => lambda { |v| v[:S3Configuration].is_a? Object },
           "Subproperty `LogSchemaVersion` is not a Integer" => lambda { |v| v[:LogSchemaVersion].is_a? Integer },
         },
         description: ""

property :role_arn, Hash,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :stop_conditions, Hash,
         required: true,
         callbacks: {
           "stop_conditions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Hash,
         required: true,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :targets, Hash,
         required: true,
         callbacks: {
           "targets is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::FIS::ExperimentTemplate"
rest_api_document "/AWS::FIS::ExperimentTemplate"

rest_property_map({
  actions:           "Actions",
  description:       "Description",
  log_configuration: "LogConfiguration",
  role_arn:          "RoleArn",
  stop_conditions:   "StopConditions",
  tags:              "Tags",
  targets:           "Targets",
})

rest_post_only_properties %i{
  tags
}
