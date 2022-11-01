# Import API specifics
use "awscc_base"

resource_name :aws_memorydb_cluster
provides :aws_memorydb_cluster, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::MemoryDB::Cluster resource creates an Amazon MemoryDB Cluster.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :acl_name, String,
         required: true,
         callbacks: {
           "acl_name is not a String" => lambda { |v| v.is_a? String },
           "acl_name must match pattern [a-zA-Z][a-zA-Z0-9\-]*" => lambda { |v| v =~ Regexp.new("/[a-zA-Z][a-zA-Z0-9\-]*/") },
         },
         description: <<~'DESCRIPTION'
           The name of the Access Control List to associate with the cluster.
         DESCRIPTION

property :auto_minor_version_upgrade, [TrueClass, FalseClass],
         callbacks: {
           "auto_minor_version_upgrade is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A flag that enables automatic minor version upgrade when set to true.
            You cannot modify the value of AutoMinorVersionUpgrade after the cluster is created. To enable AutoMinorVersionUpgrade on a cluster you must set AutoMinorVersionUpgrade to true when you create a cluster.
         DESCRIPTION

property :cluster_endpoint, Hash,
         callbacks: {
           "Subproperty `Address` is not a String" => lambda { |v| v[:Address].is_a? String },
           "Subproperty `Port` is not a Integer" => lambda { |v| v[:Port].is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The cluster endpoint.
         DESCRIPTION

property :cluster_name, String,
         required: true,
         callbacks: {
           "cluster_name is not a String" => lambda { |v| v.is_a? String },
           "cluster_name must match pattern [a-z][a-z0-9\-]*" => lambda { |v| v =~ Regexp.new("/[a-z][a-z0-9\-]*/") },
         },
         description: <<~'DESCRIPTION'
           The name of the cluster. This value must be unique as it also serves as the cluster identifier.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           An optional description of the cluster.
         DESCRIPTION

property :engine_version, String,
         callbacks: {
           "engine_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Redis engine version used by the cluster.
         DESCRIPTION

property :final_snapshot_name, String,
         callbacks: {
           "final_snapshot_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The user-supplied name of a final cluster snapshot. This is the unique name that identifies the snapshot. MemoryDB creates the snapshot, and then deletes the cluster immediately afterward.
         DESCRIPTION

property :kms_key_id, String,
         callbacks: {
           "kms_key_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the KMS key used to encrypt the cluster.
         DESCRIPTION

property :maintenance_window, String,
         callbacks: {
           "maintenance_window is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies the weekly time range during which maintenance on the cluster is performed. It is specified as a range in the format ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period.
         DESCRIPTION

property :node_type, String,
         required: true,
         callbacks: {
           "node_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The compute and memory capacity of the nodes in the cluster.
         DESCRIPTION

property :num_replicas_per_shard, Integer,
         callbacks: {
           "num_replicas_per_shard is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of replicas to apply to each shard. The limit is 5.
         DESCRIPTION

property :num_shards, Integer,
         callbacks: {
           "num_shards is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of shards the cluster will contain.
         DESCRIPTION

property :parameter_group_name, String,
         callbacks: {
           "parameter_group_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the parameter group associated with the cluster.
         DESCRIPTION

property :port, Integer,
         callbacks: {
           "port is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The port number on which each member of the cluster accepts connections.
         DESCRIPTION

property :security_group_ids, Array,
         callbacks: {
           "security_group_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           One or more Amazon VPC security groups associated with this cluster.
         DESCRIPTION

property :snapshot_arns, Array,
         callbacks: {
           "snapshot_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of Amazon Resource Names (ARN) that uniquely identify the RDB snapshot files stored in Amazon S3. The snapshot files are used to populate the new cluster. The Amazon S3 object name in the ARN cannot contain any commas.
         DESCRIPTION

property :snapshot_name, String,
         callbacks: {
           "snapshot_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of a snapshot from which to restore data into the new cluster. The snapshot status changes to restoring while the new cluster is being created.
         DESCRIPTION

property :snapshot_retention_limit, Integer,
         callbacks: {
           "snapshot_retention_limit is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of days for which MemoryDB retains automatic snapshots before deleting them. For example, if you set SnapshotRetentionLimit to 5, a snapshot that was taken today is retained for 5 days before being deleted.
         DESCRIPTION

property :snapshot_window, String,
         callbacks: {
           "snapshot_window is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The daily time range (in UTC) during which MemoryDB begins taking a daily snapshot of your cluster.
         DESCRIPTION

property :sns_topic_arn, String,
         callbacks: {
           "sns_topic_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the Amazon Simple Notification Service (SNS) topic to which notifications are sent.
         DESCRIPTION

property :sns_topic_status, String,
         callbacks: {
           "sns_topic_status is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The status of the Amazon SNS notification topic. Notifications are sent only if the status is enabled.
         DESCRIPTION

property :subnet_group_name, String,
         callbacks: {
           "subnet_group_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the subnet group to be used for the cluster.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this cluster.
         DESCRIPTION

property :tls_enabled, [TrueClass, FalseClass],
         callbacks: {
           "tls_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A flag that enables in-transit encryption when set to true.
            You cannot modify the value of TransitEncryptionEnabled after the cluster is created. To enable in-transit encryption on a cluster you must set TransitEncryptionEnabled to true when you create a cluster.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::MemoryDB::Cluster"
rest_api_document "/AWS::MemoryDB::Cluster"

rest_property_map({
  acl_name:                   "ACLName",
  auto_minor_version_upgrade: "AutoMinorVersionUpgrade",
  cluster_endpoint:           "ClusterEndpoint",
  cluster_name:               "ClusterName",
  description:                "Description",
  engine_version:             "EngineVersion",
  final_snapshot_name:        "FinalSnapshotName",
  kms_key_id:                 "KmsKeyId",
  maintenance_window:         "MaintenanceWindow",
  node_type:                  "NodeType",
  num_replicas_per_shard:     "NumReplicasPerShard",
  num_shards:                 "NumShards",
  parameter_group_name:       "ParameterGroupName",
  port:                       "Port",
  security_group_ids:         "SecurityGroupIds",
  snapshot_arns:              "SnapshotArns",
  snapshot_name:              "SnapshotName",
  snapshot_retention_limit:   "SnapshotRetentionLimit",
  snapshot_window:            "SnapshotWindow",
  sns_topic_arn:              "SnsTopicArn",
  sns_topic_status:           "SnsTopicStatus",
  subnet_group_name:          "SubnetGroupName",
  tags:                       "Tags",
  tls_enabled:                "TLSEnabled",
})

rest_post_only_properties %i{
  cluster_name kms_key_id port snapshot_arns snapshot_name tls_enabled
}
