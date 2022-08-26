# Import API specifics
use "awscc_base"

resource_name :aws_ecs_primary_task_set
provides :aws_ecs_primary_task_set, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  A pseudo-resource that manages which of your ECS task sets is primary.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :cluster, String,
         required: true,
         callbacks: {
           "cluster is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The short name or full Amazon Resource Name (ARN) of the cluster that hosts the service to create the task set in."

property :service, String,
         required: true,
         callbacks: {
           "service is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The short name or full Amazon Resource Name (ARN) of the service to create the task set in."

property :task_set_id, String,
         required: true,
         callbacks: {
           "task_set_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The ID or full Amazon Resource Name (ARN) of the task set."

# API URLs and mappings
rest_api_collection "/AWS::ECS::PrimaryTaskSet"
rest_api_document "/AWS::ECS::PrimaryTaskSet"

rest_property_map({
  cluster:     "Cluster",
  service:     "Service",
  task_set_id: "TaskSetId",
})

rest_post_only_properties %i{
  cluster service
}
