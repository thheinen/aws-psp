# Import API specifics
use "awscc_base"

resource_name :aws_batch_compute_environment
provides :aws_batch_compute_environment, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Batch::ComputeEnvironment
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :compute_environment_name, String,
         callbacks: {
           "compute_environment_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :compute_resources, Hash,
         callbacks: {
           "Subproperty `AllocationStrategy` is not a String" => lambda { |v| v[:AllocationStrategy].is_a? String },
           "Subproperty `BidPercentage` is not a Integer" => lambda { |v| v[:BidPercentage].is_a? Integer },
           "Subproperty `DesiredvCpus` is not a Integer" => lambda { |v| v[:DesiredvCpus].is_a? Integer },
           "Subproperty `Ec2Configuration` is not a Array" => lambda { |v| v[:Ec2Configuration].is_a? Array },
           "Subproperty `Ec2KeyPair` is not a String" => lambda { |v| v[:Ec2KeyPair].is_a? String },
           "Subproperty `ImageId` is not a String" => lambda { |v| v[:ImageId].is_a? String },
           "Subproperty `InstanceRole` is not a String" => lambda { |v| v[:InstanceRole].is_a? String },
           "Subproperty `InstanceTypes` is not a Array" => lambda { |v| v[:InstanceTypes].is_a? Array },
           "Subproperty `MaxvCpus` is not a Integer" => lambda { |v| v[:MaxvCpus].is_a? Integer },
           "Subproperty `MinvCpus` is not a Integer" => lambda { |v| v[:MinvCpus].is_a? Integer },
           "Subproperty `PlacementGroup` is not a String" => lambda { |v| v[:PlacementGroup].is_a? String },
           "Subproperty `SecurityGroupIds` is not a Array" => lambda { |v| v[:SecurityGroupIds].is_a? Array },
           "Subproperty `SpotIamFleetRole` is not a String" => lambda { |v| v[:SpotIamFleetRole].is_a? String },
           "Subproperty `Subnets` is not a Array" => lambda { |v| v[:Subnets].is_a? Array },
           "Subproperty `Tags` is not a Object" => lambda { |v| v[:Tags].is_a? Object },
           "Subproperty `Type` is not a String" => lambda { |v| v[:Type].is_a? String },
           "Subproperty `UpdateToLatestImageVersion` is not a Boolean" => lambda { |v| v[:UpdateToLatestImageVersion].is_a? Boolean },
         },
         description: ""

property :eks_configuration, Hash,
         callbacks: {
           "Subproperty `EksClusterArn` is not a String" => lambda { |v| v[:EksClusterArn].is_a? String },
           "Subproperty `EksClusterArn`is not a valid ARN" => lambda { |v| v[:EksClusterArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `KubernetesNamespace` is not a String" => lambda { |v| v[:KubernetesNamespace].is_a? String },
         },
         description: ""

property :replace_compute_environment, [TrueClass, FalseClass],
         callbacks: {
           "replace_compute_environment is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :service_role, String,
         callbacks: {
           "service_role is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :state, String,
         callbacks: {
           "state is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           A key-value pair to associate with a resource.
         DESCRIPTION

property :type, String,
         required: true,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :unmanagedv_cpus, Integer,
         callbacks: {
           "unmanagedv_cpus is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :update_policy, Hash,
         callbacks: {
           "Subproperty `TerminateJobsOnUpdate` is not a Boolean" => lambda { |v| v[:TerminateJobsOnUpdate].is_a? Boolean },
           "Subproperty `JobExecutionTimeoutMinutes` is not a Integer" => lambda { |v| v[:JobExecutionTimeoutMinutes].is_a? Integer },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Batch::ComputeEnvironment"
rest_api_document "/AWS::Batch::ComputeEnvironment"

rest_property_map({
  compute_environment_name:    "ComputeEnvironmentName",
  compute_resources:           "ComputeResources",
  eks_configuration:           "EksConfiguration",
  replace_compute_environment: "ReplaceComputeEnvironment",
  service_role:                "ServiceRole",
  state:                       "State",
  tags:                        "Tags",
  type:                        "Type",
  unmanagedv_cpus:             "UnmanagedvCpus",
  update_policy:               "UpdatePolicy",
})

rest_post_only_properties %i{
  compute_environment_name compute_resources/spot_iam_fleet_role eks_configuration tags type
}
