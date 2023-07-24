# Import API specifics
use "awscc_base"

resource_name :aws_config_config_rule
provides :aws_config_config_rule, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Schema for AWS Config ConfigRule
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :compliance, Hash,
         callbacks: {
           "Subproperty `Type` is not a String" => lambda { |v| v[:Type].is_a? String },
         },
         description: <<~'DESCRIPTION'
           Compliance details of the Config rule
         DESCRIPTION

property :config_rule_name, String,
         callbacks: {
           "config_rule_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Name for the AWS Config rule
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Description provided for the AWS Config rule
         DESCRIPTION

property :evaluation_modes, Array,
         callbacks: {
           "evaluation_modes is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           List of EvaluationModeConfiguration objects
         DESCRIPTION

property :input_parameters, [String, Hash],
         description: <<~'DESCRIPTION'
           JSON string passed the Lambda function
         DESCRIPTION

property :maximum_execution_frequency, String,
         callbacks: {
           "maximum_execution_frequency is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Maximum frequency at which the rule has to be evaluated
         DESCRIPTION

property :scope, Hash,
         callbacks: {
           "Subproperty `TagKey` is not a String" => lambda { |v| v[:TagKey].is_a? String },
           "Subproperty `ComplianceResourceTypes` is not a Array" => lambda { |v| v[:ComplianceResourceTypes].is_a? Array },
           "Subproperty `TagValue` is not a String" => lambda { |v| v[:TagValue].is_a? String },
           "Subproperty `ComplianceResourceId` is not a String" => lambda { |v| v[:ComplianceResourceId].is_a? String },
         },
         description: <<~'DESCRIPTION'
           Scope to constrain which resources can trigger the AWS Config rule
         DESCRIPTION

property :source, Hash,
         required: true,
         callbacks: {
           "Subproperty `SourceIdentifier` is not a String" => lambda { |v| v[:SourceIdentifier].is_a? String },
           "Subproperty `Owner` is not a String" => lambda { |v| v[:Owner].is_a? String },
           "Subproperty `SourceDetails` is not a Array" => lambda { |v| v[:SourceDetails].is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Source of events for the AWS Config rule
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Config::ConfigRule"
rest_api_document "/AWS::Config::ConfigRule"

rest_property_map({
  compliance:                  "Compliance",
  config_rule_name:            "ConfigRuleName",
  description:                 "Description",
  evaluation_modes:            "EvaluationModes",
  input_parameters:            "InputParameters",
  maximum_execution_frequency: "MaximumExecutionFrequency",
  scope:                       "Scope",
  source:                      "Source",
})

rest_post_only_properties %i{
  config_rule_name
}
