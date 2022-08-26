# Import API specifics
use "awscc_base"

resource_name :aws_sagemaker_pipeline
provides :aws_sagemaker_pipeline, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SageMaker::Pipeline
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :parallelism_configuration, Hash,
         callbacks: {
           "Subproperty `MaxParallelExecutionSteps` is not a Integer" => lambda { |v| v[:MaxParallelExecutionSteps].is_a? Integer },
         },
         description: ""

property :pipeline_definition, Hash,
         required: true,
         description: ""

property :pipeline_description, String,
         callbacks: {
           "pipeline_description is not a String" => lambda { |v| v.is_a? String },
           "pipeline_description needs to be 0..3072 characters" => lambda { |v| v.length >= 0 && v.length <= 3072 },
         },
         description: "The description of the Pipeline."

property :pipeline_display_name, String,
         callbacks: {
           "pipeline_display_name is not a String" => lambda { |v| v.is_a? String },
           "pipeline_display_name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "pipeline_display_name must match pattern ^[a-zA-Z0-9](-*[a-zA-Z0-9])*" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9](-*[a-zA-Z0-9])*/") },
         },
         description: "The display name of the Pipeline."

property :pipeline_name, String,
         required: true,
         callbacks: {
           "pipeline_name is not a String" => lambda { |v| v.is_a? String },
           "pipeline_name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "pipeline_name must match pattern ^[a-zA-Z0-9](-*[a-zA-Z0-9])*" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9](-*[a-zA-Z0-9])*/") },
         },
         description: "The name of the Pipeline."

property :role_arn, String,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
           "role_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "role_arn must match pattern ^arn:aws[a-z\-]*:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+$" => lambda { |v| v =~ Regexp.new("/^arn:aws[a-z\-]*:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+$/") },
         },
         description: "Role Arn"

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::SageMaker::Pipeline"
rest_api_document "/AWS::SageMaker::Pipeline"

rest_property_map({
  parallelism_configuration: "ParallelismConfiguration",
  pipeline_definition:       "PipelineDefinition",
  pipeline_description:      "PipelineDescription",
  pipeline_display_name:     "PipelineDisplayName",
  pipeline_name:             "PipelineName",
  role_arn:                  "RoleArn",
  tags:                      "Tags",
})

rest_post_only_properties %i{
  pipeline_name
}
