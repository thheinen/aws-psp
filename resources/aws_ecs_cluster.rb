# Import API specifics
use "awscc_base"

resource_name :aws_ecs_cluster
provides :aws_ecs_cluster, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Create an Elastic Container Service (ECS) cluster.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :capacity_providers, Array,
         callbacks: {
           "capacity_providers is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :cluster_name, String,
         callbacks: {
           "cluster_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A user-generated string that you use to identify your cluster. If you don't specify a name, AWS CloudFormation generates a unique physical ID for the name.
         DESCRIPTION

property :cluster_settings, Array,
         callbacks: {
           "cluster_settings is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :configuration, Hash,
         description: ""

property :default_capacity_provider_strategy, Array,
         callbacks: {
           "default_capacity_provider_strategy is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::ECS::Cluster"
rest_api_document "/AWS::ECS::Cluster"

rest_property_map({
  capacity_providers:                 "CapacityProviders",
  cluster_name:                       "ClusterName",
  cluster_settings:                   "ClusterSettings",
  configuration:                      "Configuration",
  default_capacity_provider_strategy: "DefaultCapacityProviderStrategy",
  tags:                               "Tags",
})

rest_post_only_properties %i{
  cluster_name
}
