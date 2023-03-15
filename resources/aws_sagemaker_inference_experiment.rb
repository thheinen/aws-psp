# Import API specifics
use "awscc_base"

resource_name :aws_sagemaker_inference_experiment
provides :aws_sagemaker_inference_experiment, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SageMaker::InferenceExperiment
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :data_storage_config, Hash,
         callbacks: {
           "Subproperty `Destination` is not a String" => lambda { |v| v[:Destination].is_a? String },
           "Subproperty `Destination` must match pattern ^(https|s3)://([^/])/?(.*)$" => lambda { |v| v[:Destination] =~ Regexp.new("/^(https|s3)://([^/])/?(.*)$/") },
           "Subproperty `KmsKey` is not a String" => lambda { |v| v[:KmsKey].is_a? String },
           "Subproperty `KmsKey` must match pattern .*" => lambda { |v| v[:KmsKey] =~ Regexp.new("/.*/") },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
           "description must match pattern .*" => lambda { |v| v =~ Regexp.new("/.*/") },
         },
         description: <<~'DESCRIPTION'
           The description of the inference experiment.
         DESCRIPTION

property :desired_state, String,
         callbacks: {
           "desired_state is not a String" => lambda { |v| v.is_a? String },
           "desired_stateis not one of `Running`, `Completed`, `Cancelled`" => lambda { |v| %w{Running Completed Cancelled}.include? v },
         },
         description: <<~'DESCRIPTION'
           The desired state of the experiment after starting or stopping operation.
         DESCRIPTION

property :endpoint_name, Hash,
         required: true,
         callbacks: {
           "endpoint_name is not a String" => lambda { |v| v.is_a? String },
           "endpoint_name must match pattern ^[a-zA-Z0-9](-*[a-zA-Z0-9])*" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9](-*[a-zA-Z0-9])*/") },
         },
         description: ""

property :kms_key, String,
         callbacks: {
           "kms_key is not a String" => lambda { |v| v.is_a? String },
           "kms_key must match pattern .*" => lambda { |v| v =~ Regexp.new("/.*/") },
         },
         description: <<~'DESCRIPTION'
           The AWS Key Management Service (AWS KMS) key that Amazon SageMaker uses to encrypt data on the storage volume attached to the ML compute instance that hosts the endpoint.
         DESCRIPTION

property :model_variants, Array,
         required: true,
         callbacks: {
           "model_variants is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of ModelVariantConfig objects. Each ModelVariantConfig object in the array describes the infrastructure configuration for the corresponding variant.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..120 characters" => lambda { |v| v.length >= 1 && v.length <= 120 },
         },
         description: <<~'DESCRIPTION'
           The name for the inference experiment.
         DESCRIPTION

property :role_arn, String,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
           "role_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "role_arn must match pattern ^arn:aws[a-z\-]*:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+$" => lambda { |v| v =~ Regexp.new("/^arn:aws[a-z\-]*:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+$/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of an IAM role that Amazon SageMaker can assume to access model artifacts and container images, and manage Amazon SageMaker Inference endpoints for model deployment.
         DESCRIPTION

property :schedule, Hash,
         callbacks: {
           "Subproperty `StartTime` is not a String" => lambda { |v| v[:StartTime].is_a? String },
           "Subproperty `EndTime` is not a String" => lambda { |v| v[:EndTime].is_a? String },
         },
         description: ""

property :shadow_mode_config, Hash,
         callbacks: {
           "Subproperty `SourceModelVariantName` is not a String" => lambda { |v| v[:SourceModelVariantName].is_a? String },
           "Subproperty `SourceModelVariantName` must match pattern ^[a-zA-Z0-9]([\-a-zA-Z0-9]*[a-zA-Z0-9])?" => lambda { |v| v[:SourceModelVariantName] =~ Regexp.new("/^[a-zA-Z0-9]([\-a-zA-Z0-9]*[a-zA-Z0-9])?/") },
           "Subproperty `ShadowModelVariants` is not a Array" => lambda { |v| v[:ShadowModelVariants].is_a? Array },
         },
         description: ""

property :status_reason, String,
         callbacks: {
           "status_reason is not a String" => lambda { |v| v.is_a? String },
           "status_reason needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
           "status_reason must match pattern .*" => lambda { |v| v =~ Regexp.new("/.*/") },
         },
         description: <<~'DESCRIPTION'
           The error message or client-specified reason from the StopInferenceExperiment API, that explains the status of the inference experiment.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

property :type, String,
         required: true,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
           "typeis not one of `ShadowMode`" => lambda { |v| %w{ShadowMode}.include? v },
         },
         description: <<~'DESCRIPTION'
           The type of the inference experiment that you want to run.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SageMaker::InferenceExperiment"
rest_api_document "/AWS::SageMaker::InferenceExperiment"

rest_property_map({
  data_storage_config: "DataStorageConfig",
  description:         "Description",
  desired_state:       "DesiredState",
  endpoint_name:       "EndpointName",
  kms_key:             "KmsKey",
  model_variants:      "ModelVariants",
  name:                "Name",
  role_arn:            "RoleArn",
  schedule:            "Schedule",
  shadow_mode_config:  "ShadowModeConfig",
  status_reason:       "StatusReason",
  tags:                "Tags",
  type:                "Type",
})

rest_post_only_properties %i{
  endpoint_name kms_key name role_arn type
}
