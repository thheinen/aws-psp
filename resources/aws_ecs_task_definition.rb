# Import API specifics
use "awscc_base"

resource_name :aws_ecs_task_definition
provides :aws_ecs_task_definition, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Schema describing various properties for ECS TaskDefinition
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :container_definitions, Array,
         callbacks: {
           "container_definitions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :cpu, String,
         callbacks: {
           "cpu is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :ephemeral_storage, Hash,
         callbacks: {
           "Subproperty `SizeInGiB` is not a Integer" => lambda { |v| v[:SizeInGiB].is_a? Integer },
         },
         description: ""

property :execution_role_arn, String,
         callbacks: {
           "execution_role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :family, String,
         callbacks: {
           "family is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :inference_accelerators, Array,
         callbacks: {
           "inference_accelerators is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :ipc_mode, String,
         callbacks: {
           "ipc_mode is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :memory, String,
         callbacks: {
           "memory is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :network_mode, String,
         callbacks: {
           "network_mode is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :pid_mode, String,
         callbacks: {
           "pid_mode is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :placement_constraints, Array,
         callbacks: {
           "placement_constraints is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :proxy_configuration, Hash,
         callbacks: {
           "Subproperty `ContainerName` is not a String" => lambda { |v| v[:ContainerName].is_a? String },
           "Subproperty `ProxyConfigurationProperties` is not a Array" => lambda { |v| v[:ProxyConfigurationProperties].is_a? Array },
           "Subproperty `Type` is not a String" => lambda { |v| v[:Type].is_a? String },
         },
         description: ""

property :requires_compatibilities, Array,
         callbacks: {
           "requires_compatibilities is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :runtime_platform, Hash,
         callbacks: {
           "Subproperty `CpuArchitecture` is not a String" => lambda { |v| v[:CpuArchitecture].is_a? String },
           "Subproperty `OperatingSystemFamily` is not a String" => lambda { |v| v[:OperatingSystemFamily].is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :task_role_arn, String,
         callbacks: {
           "task_role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :volumes, Array,
         callbacks: {
           "volumes is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::ECS::TaskDefinition"
rest_api_document "/AWS::ECS::TaskDefinition"

rest_property_map({
  container_definitions:    "ContainerDefinitions",
  cpu:                      "Cpu",
  ephemeral_storage:        "EphemeralStorage",
  execution_role_arn:       "ExecutionRoleArn",
  family:                   "Family",
  inference_accelerators:   "InferenceAccelerators",
  ipc_mode:                 "IpcMode",
  memory:                   "Memory",
  network_mode:             "NetworkMode",
  pid_mode:                 "PidMode",
  placement_constraints:    "PlacementConstraints",
  proxy_configuration:      "ProxyConfiguration",
  requires_compatibilities: "RequiresCompatibilities",
  runtime_platform:         "RuntimePlatform",
  tags:                     "Tags",
  task_role_arn:            "TaskRoleArn",
  volumes:                  "Volumes",
})

rest_post_only_properties %i{
  container_definitions cpu ephemeral_storage execution_role_arn family inference_accelerators ipc_mode memory network_mode pid_mode placement_constraints proxy_configuration requires_compatibilities runtime_platform task_role_arn volumes
}
