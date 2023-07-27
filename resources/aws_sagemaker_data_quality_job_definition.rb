# Import API specifics
use "awscc_base"

resource_name :aws_sagemaker_data_quality_job_definition
provides :aws_sagemaker_data_quality_job_definition, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SageMaker::DataQualityJobDefinition
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :data_quality_app_specification, Hash,
         required: true,
         callbacks: {
           "Subproperty `ContainerArguments` is not a Array" => lambda { |v| v[:ContainerArguments].is_a? Array },
           "Subproperty `ContainerEntrypoint` is not a Array" => lambda { |v| v[:ContainerEntrypoint].is_a? Array },
           "Subproperty `ImageUri` is not a String" => lambda { |v| v[:ImageUri].is_a? String },
           "Subproperty `ImageUri` must match pattern .*" => lambda { |v| v[:ImageUri] =~ Regexp.new("/.*/") },
           "Subproperty `Environment` is not a Object" => lambda { |v| v[:Environment].is_a? Object },
         },
         description: ""

property :data_quality_baseline_config, Hash,
         description: ""

property :data_quality_job_input, Hash,
         required: true,
         description: ""

property :data_quality_job_output_config, Hash,
         required: true,
         callbacks: {
           "Subproperty `KmsKeyId` is not a String" => lambda { |v| v[:KmsKeyId].is_a? String },
           "Subproperty `KmsKeyId` must match pattern .*" => lambda { |v| v[:KmsKeyId] =~ Regexp.new("/.*/") },
           "Subproperty `MonitoringOutputs` is not a Array" => lambda { |v| v[:MonitoringOutputs].is_a? Array },
         },
         description: ""

property :endpoint_name, Hash,
         callbacks: {
           "endpoint_name is not a String" => lambda { |v| v.is_a? String },
           "endpoint_name must match pattern ^[a-zA-Z0-9](-*[a-zA-Z0-9])*" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9](-*[a-zA-Z0-9])*/") },
         },
         description: ""

property :job_definition_name, Hash,
         callbacks: {
           "job_definition_name is not a String" => lambda { |v| v.is_a? String },
           "job_definition_name must match pattern ^[a-zA-Z0-9](-*[a-zA-Z0-9])*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9](-*[a-zA-Z0-9])*$/") },
         },
         description: ""

property :job_resources, Hash,
         required: true,
         description: ""

property :network_config, Hash,
         callbacks: {
           "Subproperty `EnableInterContainerTrafficEncryption` is not a Boolean" => lambda { |v| v[:EnableInterContainerTrafficEncryption].is_a? Boolean },
           "Subproperty `EnableNetworkIsolation` is not a Boolean" => lambda { |v| v[:EnableNetworkIsolation].is_a? Boolean },
         },
         description: ""

property :role_arn, String,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
           "role_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "role_arn must match pattern ^arn:aws[a-z\-]*:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+$" => lambda { |v| v =~ Regexp.new("/^arn:aws[a-z\-]*:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+$/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of an IAM role that Amazon SageMaker can assume to perform tasks on your behalf.
         DESCRIPTION

property :stopping_condition, Hash,
         callbacks: {
           "Subproperty `MaxRuntimeInSeconds` is not a Integer" => lambda { |v| v[:MaxRuntimeInSeconds].is_a? Integer },
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
rest_api_collection "/AWS::SageMaker::DataQualityJobDefinition"
rest_api_document "/AWS::SageMaker::DataQualityJobDefinition"

rest_property_map({
  data_quality_app_specification: "DataQualityAppSpecification",
  data_quality_baseline_config:   "DataQualityBaselineConfig",
  data_quality_job_input:         "DataQualityJobInput",
  data_quality_job_output_config: "DataQualityJobOutputConfig",
  endpoint_name:                  "EndpointName",
  job_definition_name:            "JobDefinitionName",
  job_resources:                  "JobResources",
  network_config:                 "NetworkConfig",
  role_arn:                       "RoleArn",
  stopping_condition:             "StoppingCondition",
  tags:                           "Tags",
})

rest_post_only_properties %i{
  data_quality_app_specification data_quality_baseline_config data_quality_job_input data_quality_job_output_config endpoint_name job_definition_name job_resources network_config role_arn stopping_condition tags
}
