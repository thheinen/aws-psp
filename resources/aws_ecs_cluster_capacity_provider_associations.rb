# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_ecs_cluster_capacity_provider_associations
provides :aws_ecs_cluster_capacity_provider_associations, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Associate a set of ECS Capacity Providers with a specified ECS Cluster
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :capacity_providers, Hash,
         required: true,
         callbacks: {
           "capacity_providers is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :cluster, Hash,
         required: true,
         callbacks: {
           "cluster is not a String" => lambda { |v| v.is_a? String },
           "cluster needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
         },
         description: ""

property :default_capacity_provider_strategy, Hash,
         required: true,
         callbacks: {
           "default_capacity_provider_strategy is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::ECS::ClusterCapacityProviderAssociations"
rest_api_document "/AWS::ECS::ClusterCapacityProviderAssociations"

rest_property_map({
  capacity_providers:                 "CapacityProviders",
  cluster:                            "Cluster",
  default_capacity_provider_strategy: "DefaultCapacityProviderStrategy",
})

rest_post_only_properties %i{
  cluster
}
