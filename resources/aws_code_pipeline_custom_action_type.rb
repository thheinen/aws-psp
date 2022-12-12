# Import API specifics
use "awscc_base"

resource_name :aws_code_pipeline_custom_action_type
provides :aws_code_pipeline_custom_action_type, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::CodePipeline::CustomActionType resource creates a custom action for activities that aren't included in the CodePipeline default actions, such as running an internally developed build process or a test suite. You can use these custom actions in the stage of a pipeline.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :category, String,
         required: true,
         callbacks: {
           "category is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The category of the custom action, such as a build action or a test action.
         DESCRIPTION

property :configuration_properties, Array,
         callbacks: {
           "configuration_properties is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The configuration properties for the custom action.
         DESCRIPTION

property :input_artifact_details, Hash,
         required: true,
         callbacks: {
           "Subproperty `MaximumCount` is not a Integer" => lambda { |v| v[:MaximumCount].is_a? Integer },
           "Subproperty `MinimumCount` is not a Integer" => lambda { |v| v[:MinimumCount].is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The details of the input artifact for the action, such as its commit ID.
         DESCRIPTION

property :output_artifact_details, Hash,
         required: true,
         callbacks: {
           "Subproperty `MaximumCount` is not a Integer" => lambda { |v| v[:MaximumCount].is_a? Integer },
           "Subproperty `MinimumCount` is not a Integer" => lambda { |v| v[:MinimumCount].is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The details of the output artifact of the action, such as its commit ID.
         DESCRIPTION

property :provider, String,
         required: true,
         callbacks: {
           "provider is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The provider of the service used in the custom action, such as AWS CodeDeploy.
         DESCRIPTION

property :settings, Hash,
         callbacks: {
           "Subproperty `EntityUrlTemplate` is not a String" => lambda { |v| v[:EntityUrlTemplate].is_a? String },
           "Subproperty `ExecutionUrlTemplate` is not a String" => lambda { |v| v[:ExecutionUrlTemplate].is_a? String },
           "Subproperty `RevisionUrlTemplate` is not a String" => lambda { |v| v[:RevisionUrlTemplate].is_a? String },
           "Subproperty `ThirdPartyConfigurationUrl` is not a String" => lambda { |v| v[:ThirdPartyConfigurationUrl].is_a? String },
         },
         description: <<~'DESCRIPTION'
           URLs that provide users information about this custom action.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Any tags assigned to the custom action.
         DESCRIPTION

property :version, String,
         required: true,
         callbacks: {
           "version is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The version identifier of the custom action.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::CodePipeline::CustomActionType"
rest_api_document "/AWS::CodePipeline::CustomActionType"

rest_property_map({
  category:                 "Category",
  configuration_properties: "ConfigurationProperties",
  input_artifact_details:   "InputArtifactDetails",
  output_artifact_details:  "OutputArtifactDetails",
  provider:                 "Provider",
  settings:                 "Settings",
  tags:                     "Tags",
  version:                  "Version",
})

rest_post_only_properties %i{
  category configuration_properties input_artifact_details output_artifact_details provider settings version
}
