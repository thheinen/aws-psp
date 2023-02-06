# Import API specifics
use "awscc_base"

resource_name :aws_ecs_task_set
provides :aws_ecs_task_set, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Create a task set in the specified cluster and service. This is used when a service uses the EXTERNAL deployment controller type. For more information, see https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-types.htmlin the Amazon Elastic Container Service Developer Guide.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :cluster, String,
         required: true,
         callbacks: {
           "cluster is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The short name or full Amazon Resource Name (ARN) of the cluster that hosts the service to create the task set in.
         DESCRIPTION

property :external_id, String,
         callbacks: {
           "external_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           An optional non-unique tag that identifies this task set in external systems. If the task set is associated with a service discovery registry, the tasks in this task set will have the ECS_TASK_SET_EXTERNAL_ID AWS Cloud Map attribute set to the provided value.
         DESCRIPTION

property :launch_type, String,
         callbacks: {
           "launch_type is not a String" => lambda { |v| v.is_a? String },
           "launch_typeis not one of `EC2`, `FARGATE`" => lambda { |v| %w{EC2 FARGATE}.include? v },
         },
         description: <<~'DESCRIPTION'
           The launch type that new tasks in the task set will use. For more information, see https://docs.aws.amazon.com/AmazonECS/latest/developerguide/launch_types.html in the Amazon Elastic Container Service Developer Guide.
         DESCRIPTION

property :load_balancers, Array,
         callbacks: {
           "load_balancers is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :network_configuration, Hash,
         description: ""

property :platform_version, String,
         callbacks: {
           "platform_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The platform version that the tasks in the task set should use. A platform version is specified only for tasks using the Fargate launch type. If one isn't specified, the LATEST platform version is used by default.
         DESCRIPTION

property :scale, Hash,
         callbacks: {
           "Subproperty `Unit` is not a String" => lambda { |v| v[:Unit].is_a? String },
           "Subproperty `Unit`is not one of `PERCENT`" => lambda { |v| %w{PERCENT}.include? v[:Unit] },
           "Subproperty `Value` is not a Number" => lambda { |v| v[:Value].is_a? Number },
         },
         description: <<~'DESCRIPTION'
           A floating-point percentage of the desired number of tasks to place and keep running in the task set.
         DESCRIPTION

property :service, String,
         required: true,
         callbacks: {
           "service is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The short name or full Amazon Resource Name (ARN) of the service to create the task set in.
         DESCRIPTION

property :service_registries, Array,
         callbacks: {
           "service_registries is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The details of the service discovery registries to assign to this task set. For more information, see https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-discovery.html.
         DESCRIPTION

property :task_definition, String,
         required: true,
         callbacks: {
           "task_definition is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The short name or full Amazon Resource Name (ARN) of the task definition for the tasks in the task set to use.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ECS::TaskSet"
rest_api_document "/AWS::ECS::TaskSet"

rest_property_map({
  cluster:               "Cluster",
  external_id:           "ExternalId",
  launch_type:           "LaunchType",
  load_balancers:        "LoadBalancers",
  network_configuration: "NetworkConfiguration",
  platform_version:      "PlatformVersion",
  scale:                 "Scale",
  service:               "Service",
  service_registries:    "ServiceRegistries",
  task_definition:       "TaskDefinition",
})

rest_post_only_properties %i{
  cluster external_id launch_type load_balancers network_configuration platform_version service service_registries task_definition
}
