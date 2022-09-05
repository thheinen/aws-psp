# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_ecs_service
provides :aws_ecs_service, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ECS::Service
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :capacity_provider_strategy, Array,
         callbacks: {
           "capacity_provider_strategy is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :cluster, String,
         callbacks: {
           "cluster is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :deployment_configuration, Hash,
         callbacks: {
           "Subproperty `MaximumPercent` is not a Integer" => lambda { |v| v[:MaximumPercent].is_a? Integer },
           "Subproperty `MinimumHealthyPercent` is not a Integer" => lambda { |v| v[:MinimumHealthyPercent].is_a? Integer },
         },
         description: ""

property :deployment_controller, Hash,
         callbacks: {
           "Subproperty `Type` is not a String" => lambda { |v| v[:Type].is_a? String },
           "Subproperty `Type`is not one of `CODE_DEPLOY`, `ECS`, `EXTERNAL`" => lambda { |v| %w{CODE_DEPLOY ECS EXTERNAL}.include? v[:Type] },
         },
         description: ""

property :desired_count, Integer,
         callbacks: {
           "desired_count is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :enable_ecs_managed_tags, [TrueClass, FalseClass],
         callbacks: {
           "enable_ecs_managed_tags is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :enable_execute_command, [TrueClass, FalseClass],
         callbacks: {
           "enable_execute_command is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :health_check_grace_period_seconds, Integer,
         callbacks: {
           "health_check_grace_period_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :launch_type, String,
         callbacks: {
           "launch_type is not a String" => lambda { |v| v.is_a? String },
           "launch_typeis not one of `EC2`, `FARGATE`, `EXTERNAL`" => lambda { |v| %w{EC2 FARGATE EXTERNAL}.include? v },
         },
         description: ""

property :load_balancers, Array,
         callbacks: {
           "load_balancers is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :network_configuration, Hash,
         description: ""

property :placement_constraints, Array,
         callbacks: {
           "placement_constraints is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :placement_strategies, Array,
         callbacks: {
           "placement_strategies is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :platform_version, String,
         callbacks: {
           "platform_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :propagate_tags, String,
         callbacks: {
           "propagate_tags is not a String" => lambda { |v| v.is_a? String },
           "propagate_tagsis not one of `SERVICE`, `TASK_DEFINITION`" => lambda { |v| %w{SERVICE TASK_DEFINITION}.include? v },
         },
         description: ""

property :role, String,
         callbacks: {
           "role is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :scheduling_strategy, String,
         callbacks: {
           "scheduling_strategy is not a String" => lambda { |v| v.is_a? String },
           "scheduling_strategyis not one of `DAEMON`, `REPLICA`" => lambda { |v| %w{DAEMON REPLICA}.include? v },
         },
         description: ""

property :service_name, String,
         callbacks: {
           "service_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :service_registries, Array,
         callbacks: {
           "service_registries is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :task_definition, String,
         callbacks: {
           "task_definition is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::ECS::Service"
rest_api_document "/AWS::ECS::Service"

rest_property_map({
  capacity_provider_strategy:        "CapacityProviderStrategy",
  cluster:                           "Cluster",
  deployment_configuration:          "DeploymentConfiguration",
  deployment_controller:             "DeploymentController",
  desired_count:                     "DesiredCount",
  enable_ecs_managed_tags:           "EnableECSManagedTags",
  enable_execute_command:            "EnableExecuteCommand",
  health_check_grace_period_seconds: "HealthCheckGracePeriodSeconds",
  launch_type:                       "LaunchType",
  load_balancers:                    "LoadBalancers",
  network_configuration:             "NetworkConfiguration",
  placement_constraints:             "PlacementConstraints",
  placement_strategies:              "PlacementStrategies",
  platform_version:                  "PlatformVersion",
  propagate_tags:                    "PropagateTags",
  role:                              "Role",
  scheduling_strategy:               "SchedulingStrategy",
  service_name:                      "ServiceName",
  service_registries:                "ServiceRegistries",
  tags:                              "Tags",
  task_definition:                   "TaskDefinition",
})

rest_post_only_properties %i{
  cluster deployment_controller launch_type role scheduling_strategy service_name
}
