# Import API specifics
use "awscc_base"

resource_name :aws_cassandra_table
provides :aws_cassandra_table, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::Cassandra::Table
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :billing_mode, Hash,
         description: ""

property :client_side_timestamps_enabled, [TrueClass, FalseClass],
         callbacks: {
           "client_side_timestamps_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Indicates whether client side timestamps are enabled (true) or disabled (false) on the table. False by default, once it is enabled it cannot be disabled again.
         DESCRIPTION

property :clustering_key_columns, Array,
         callbacks: {
           "clustering_key_columns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Clustering key columns of the table
         DESCRIPTION

property :default_time_to_live, Integer,
         callbacks: {
           "default_time_to_live is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           Default TTL (Time To Live) in seconds, where zero is disabled. If the value is greater than zero, TTL is enabled for the entire table and an expiration timestamp is added to each column.
         DESCRIPTION

property :encryption_specification, Hash,
         description: ""

property :keyspace_name, String,
         required: true,
         callbacks: {
           "keyspace_name is not a String" => lambda { |v| v.is_a? String },
           "keyspace_name must match pattern ^[a-zA-Z0-9][a-zA-Z0-9_]{1,47}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9][a-zA-Z0-9_]{1,47}$/") },
         },
         description: <<~'DESCRIPTION'
           Name for Cassandra keyspace
         DESCRIPTION

property :partition_key_columns, Array,
         required: true,
         callbacks: {
           "partition_key_columns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Partition key columns of the table
         DESCRIPTION

property :point_in_time_recovery_enabled, [TrueClass, FalseClass],
         callbacks: {
           "point_in_time_recovery_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Indicates whether point in time recovery is enabled (true) or disabled (false) on the table
         DESCRIPTION

property :regular_columns, Array,
         callbacks: {
           "regular_columns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Non-key columns of the table
         DESCRIPTION

property :table_name, String,
         callbacks: {
           "table_name is not a String" => lambda { |v| v.is_a? String },
           "table_name must match pattern ^[a-zA-Z0-9][a-zA-Z0-9_]{1,47}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9][a-zA-Z0-9_]{1,47}$/") },
         },
         description: <<~'DESCRIPTION'
           Name for Cassandra table
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Cassandra::Table"
rest_api_document "/AWS::Cassandra::Table"

rest_property_map({
  billing_mode:                   "BillingMode",
  client_side_timestamps_enabled: "ClientSideTimestampsEnabled",
  clustering_key_columns:         "ClusteringKeyColumns",
  default_time_to_live:           "DefaultTimeToLive",
  encryption_specification:       "EncryptionSpecification",
  keyspace_name:                  "KeyspaceName",
  partition_key_columns:          "PartitionKeyColumns",
  point_in_time_recovery_enabled: "PointInTimeRecoveryEnabled",
  regular_columns:                "RegularColumns",
  table_name:                     "TableName",
  tags:                           "Tags",
})

rest_post_only_properties %i{
  client_side_timestamps_enabled clustering_key_columns keyspace_name partition_key_columns table_name
}
