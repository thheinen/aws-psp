# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_synthetics_canary
provides :aws_synthetics_canary, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Synthetics::Canary
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :artifact_config, Hash,
         description: <<~'DESCRIPTION'
           Provide artifact configuration
         DESCRIPTION

property :artifact_s3_location, String,
         required: true,
         callbacks: {
           "artifact_s3_location is not a String" => lambda { |v| v.is_a? String },
           "artifact_s3_location must match pattern ^(s3|S3)://" => lambda { |v| v =~ Regexp.new("/^(s3|S3):///") },
         },
         description: <<~'DESCRIPTION'
           Provide the s3 bucket output location for test results
         DESCRIPTION

property :code, Hash,
         required: true,
         callbacks: {
           "Subproperty `S3Bucket` is not a String" => lambda { |v| v[:S3Bucket].is_a? String },
           "Subproperty `S3Key` is not a String" => lambda { |v| v[:S3Key].is_a? String },
           "Subproperty `S3ObjectVersion` is not a String" => lambda { |v| v[:S3ObjectVersion].is_a? String },
           "Subproperty `Script` is not a String" => lambda { |v| v[:Script].is_a? String },
           "Subproperty `Handler` is not a String" => lambda { |v| v[:Handler].is_a? String },
         },
         description: <<~'DESCRIPTION'
           Provide the canary script source
         DESCRIPTION

property :delete_lambda_resources_on_canary_deletion, [TrueClass, FalseClass],
         callbacks: {
           "delete_lambda_resources_on_canary_deletion is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Deletes associated lambda resources created by Synthetics if set to True. Default is False
         DESCRIPTION

property :execution_role_arn, String,
         required: true,
         callbacks: {
           "execution_role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Lambda Execution role used to run your canaries
         DESCRIPTION

property :failure_retention_period, Integer,
         callbacks: {
           "failure_retention_period is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           Retention period of failed canary runs represented in number of days
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name must match pattern ^[0-9a-z_\-]{1,21}$" => lambda { |v| v =~ Regexp.new("/^[0-9a-z_\-]{1,21}$/") },
         },
         description: <<~'DESCRIPTION'
           Name of the canary.
         DESCRIPTION

property :run_config, Hash,
         callbacks: {
           "Subproperty `TimeoutInSeconds` is not a Integer" => lambda { |v| v[:TimeoutInSeconds].is_a? Integer },
           "Subproperty `MemoryInMB` is not a Integer" => lambda { |v| v[:MemoryInMB].is_a? Integer },
           "Subproperty `ActiveTracing` is not a Boolean" => lambda { |v| v[:ActiveTracing].is_a? Boolean },
           "Subproperty `EnvironmentVariables` is not a Object" => lambda { |v| v[:EnvironmentVariables].is_a? Object },
         },
         description: <<~'DESCRIPTION'
           Provide canary run configuration
         DESCRIPTION

property :runtime_version, String,
         required: true,
         callbacks: {
           "runtime_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Runtime version of Synthetics Library
         DESCRIPTION

property :schedule, Hash,
         required: true,
         callbacks: {
           "Subproperty `Expression` is not a String" => lambda { |v| v[:Expression].is_a? String },
           "Subproperty `DurationInSeconds` is not a String" => lambda { |v| v[:DurationInSeconds].is_a? String },
         },
         description: <<~'DESCRIPTION'
           Frequency to run your canaries
         DESCRIPTION

property :start_canary_after_creation, [TrueClass, FalseClass],
         required: true,
         callbacks: {
           "start_canary_after_creation is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Runs canary if set to True. Default is False
         DESCRIPTION

property :success_retention_period, Integer,
         callbacks: {
           "success_retention_period is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           Retention period of successful canary runs represented in number of days
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :visual_reference, Hash,
         callbacks: {
           "Subproperty `BaseCanaryRunId` is not a String" => lambda { |v| v[:BaseCanaryRunId].is_a? String },
           "Subproperty `BaseScreenshots` is not a Array" => lambda { |v| v[:BaseScreenshots].is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Visual reference configuration for visual testing
         DESCRIPTION

property :vpc_config, Hash,
         callbacks: {
           "Subproperty `VpcId` is not a String" => lambda { |v| v[:VpcId].is_a? String },
           "Subproperty `SubnetIds` is not a Array" => lambda { |v| v[:SubnetIds].is_a? Array },
           "Subproperty `SecurityGroupIds` is not a Array" => lambda { |v| v[:SecurityGroupIds].is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Provide VPC Configuration if enabled.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Synthetics::Canary"
rest_api_document "/AWS::Synthetics::Canary"

rest_property_map({
  artifact_config:                            "ArtifactConfig",
  artifact_s3_location:                       "ArtifactS3Location",
  code:                                       "Code",
  delete_lambda_resources_on_canary_deletion: "DeleteLambdaResourcesOnCanaryDeletion",
  execution_role_arn:                         "ExecutionRoleArn",
  failure_retention_period:                   "FailureRetentionPeriod",
  name:                                       "Name",
  run_config:                                 "RunConfig",
  runtime_version:                            "RuntimeVersion",
  schedule:                                   "Schedule",
  start_canary_after_creation:                "StartCanaryAfterCreation",
  success_retention_period:                   "SuccessRetentionPeriod",
  tags:                                       "Tags",
  visual_reference:                           "VisualReference",
  vpc_config:                                 "VPCConfig",
})

rest_post_only_properties %i{
  name
}
