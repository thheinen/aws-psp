# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_elasticache_global_replication_group
provides :aws_elasticache_global_replication_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::ElastiCache::GlobalReplicationGroup resource creates an Amazon ElastiCache Global Replication Group.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :automatic_failover_enabled, [TrueClass, FalseClass],
         callbacks: {
           "automatic_failover_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           AutomaticFailoverEnabled
         DESCRIPTION

property :cache_node_type, String,
         callbacks: {
           "cache_node_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The cache node type of the Global Datastore
         DESCRIPTION

property :cache_parameter_group_name, String,
         callbacks: {
           "cache_parameter_group_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Cache parameter group name to use for the new engine version. This parameter cannot be modified independently.
         DESCRIPTION

property :engine_version, String,
         callbacks: {
           "engine_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The engine version of the Global Datastore.
         DESCRIPTION

property :global_node_group_count, Integer,
         callbacks: {
           "global_node_group_count is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           Indicates the number of node groups in the Global Datastore.
         DESCRIPTION

property :global_replication_group_description, String,
         callbacks: {
           "global_replication_group_description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The optional description of the Global Datastore
         DESCRIPTION

property :global_replication_group_id_suffix, String,
         callbacks: {
           "global_replication_group_id_suffix is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The suffix name of a Global Datastore. Amazon ElastiCache automatically applies a prefix to the Global Datastore ID when it is created. Each AWS Region has its own prefix.
         DESCRIPTION

property :members, Array,
         required: true,
         callbacks: {
           "members is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The replication groups that comprise the Global Datastore.
         DESCRIPTION

property :regional_configurations, Array,
         callbacks: {
           "regional_configurations is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Describes the replication group IDs, the AWS regions where they are stored and the shard configuration for each that comprise the Global Datastore
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ElastiCache::GlobalReplicationGroup"
rest_api_document "/AWS::ElastiCache::GlobalReplicationGroup"

rest_property_map({
  automatic_failover_enabled:           "AutomaticFailoverEnabled",
  cache_node_type:                      "CacheNodeType",
  cache_parameter_group_name:           "CacheParameterGroupName",
  engine_version:                       "EngineVersion",
  global_node_group_count:              "GlobalNodeGroupCount",
  global_replication_group_description: "GlobalReplicationGroupDescription",
  global_replication_group_id_suffix:   "GlobalReplicationGroupIdSuffix",
  members:                              "Members",
  regional_configurations:              "RegionalConfigurations",
})

