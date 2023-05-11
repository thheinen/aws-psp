# Import API specifics
use "awscc_base"

resource_name :aws_neptune_db_cluster
provides :aws_neptune_db_cluster, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::Neptune::DBCluster resource creates an Amazon Neptune DB cluster.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :associated_roles, Array,
         callbacks: {
           "associated_roles is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Provides a list of the AWS Identity and Access Management (IAM) roles that are associated with the DB cluster. IAM roles that are associated with a DB cluster grant permission for the DB cluster to access other AWS services on your behalf.
         DESCRIPTION

property :availability_zones, Array,
         callbacks: {
           "availability_zones is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Provides the list of EC2 Availability Zones that instances in the DB cluster can be created in.
         DESCRIPTION

property :backup_retention_period, Integer,
         callbacks: {
           "backup_retention_period is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           Specifies the number of days for which automatic DB snapshots are retained.
         DESCRIPTION

property :copy_tags_to_snapshot, [TrueClass, FalseClass],
         callbacks: {
           "copy_tags_to_snapshot is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A value that indicates whether to copy all tags from the DB cluster to snapshots of the DB cluster. The default behaviour is not to copy them.
         DESCRIPTION

property :db_cluster_identifier, String,
         callbacks: {
           "db_cluster_identifier is not a String" => lambda { |v| v.is_a? String },
           "db_cluster_identifier needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
           "db_cluster_identifier must match pattern ^[a-zA-Z]{1}(?:-?[a-zA-Z0-9]){0,62}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z]{1}(?:-?[a-zA-Z0-9]){0,62}$/") },
         },
         description: <<~'DESCRIPTION'
           The DB cluster identifier. Contains a user-supplied DB cluster identifier. This identifier is the unique key that identifies a DB cluster stored as a lowercase string.
         DESCRIPTION

property :db_cluster_parameter_group_name, String,
         callbacks: {
           "db_cluster_parameter_group_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Provides the name of the DB cluster parameter group.
         DESCRIPTION

property :db_instance_parameter_group_name, String,
         callbacks: {
           "db_instance_parameter_group_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the DB parameter group to apply to all instances of the DB cluster. Used only in case of a major EngineVersion upgrade request.
         DESCRIPTION

property :db_subnet_group_name, String,
         callbacks: {
           "db_subnet_group_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies information on the subnet group associated with the DB cluster, including the name, description, and subnets in the subnet group.
         DESCRIPTION

property :deletion_protection, [TrueClass, FalseClass],
         callbacks: {
           "deletion_protection is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Indicates whether or not the DB cluster has deletion protection enabled. The database can't be deleted when deletion protection is enabled.
         DESCRIPTION

property :enable_cloudwatch_logs_exports, Array,
         callbacks: {
           "enable_cloudwatch_logs_exports is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Specifies a list of log types that are enabled for export to CloudWatch Logs.
         DESCRIPTION

property :engine_version, String,
         callbacks: {
           "engine_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Indicates the database engine version.
         DESCRIPTION

property :iam_auth_enabled, [TrueClass, FalseClass],
         callbacks: {
           "iam_auth_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           True if mapping of Amazon Identity and Access Management (IAM) accounts to database accounts is enabled, and otherwise false.
         DESCRIPTION

property :kms_key_id, String,
         callbacks: {
           "kms_key_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           If `StorageEncrypted` is true, the Amazon KMS key identifier for the encrypted DB cluster.
         DESCRIPTION

property :preferred_backup_window, String,
         callbacks: {
           "preferred_backup_window is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies the daily time range during which automated backups are created if automated backups are enabled, as determined by the BackupRetentionPeriod.
         DESCRIPTION

property :preferred_maintenance_window, String,
         callbacks: {
           "preferred_maintenance_window is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies the weekly time range during which system maintenance can occur, in Universal Coordinated Time (UTC).
         DESCRIPTION

property :restore_to_time, String,
         callbacks: {
           "restore_to_time is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Creates a new DB cluster from a DB snapshot or DB cluster snapshot.
            If a DB snapshot is specified, the target DB cluster is created from the source DB snapshot with a default configuration and default security group.
            If a DB cluster snapshot is specified, the target DB cluster is created from the source DB cluster restore point with the same configuration as the original source DB cluster, except that the new DB cluster is created with the default security group.
         DESCRIPTION

property :restore_type, String,
         callbacks: {
           "restore_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Creates a new DB cluster from a DB snapshot or DB cluster snapshot.
            If a DB snapshot is specified, the target DB cluster is created from the source DB snapshot with a default configuration and default security group.
            If a DB cluster snapshot is specified, the target DB cluster is created from the source DB cluster restore point with the same configuration as the original source DB cluster, except that the new DB cluster is created with the default security group.
         DESCRIPTION

property :serverless_scaling_configuration, Hash,
         callbacks: {
           "Subproperty `MinCapacity` is not a Number" => lambda { |v| v[:MinCapacity].is_a? Number },
           "Subproperty `MaxCapacity` is not a Number" => lambda { |v| v[:MaxCapacity].is_a? Number },
         },
         description: <<~'DESCRIPTION'
           Contains the scaling configuration used by the Neptune Serverless Instances within this DB cluster.
         DESCRIPTION

property :snapshot_identifier, String,
         callbacks: {
           "snapshot_identifier is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies the identifier for a DB cluster snapshot. Must match the identifier of an existing snapshot.
            After you restore a DB cluster using a SnapshotIdentifier, you must specify the same SnapshotIdentifier for any future updates to the DB cluster. When you specify this property for an update, the DB cluster is not restored from the snapshot again, and the data in the database is not changed.
            However, if you don't specify the SnapshotIdentifier, an empty DB cluster is created, and the original DB cluster is deleted. If you specify a property that is different from the previous snapshot restore property, the DB cluster is restored from the snapshot specified by the SnapshotIdentifier, and the original DB cluster is deleted.
         DESCRIPTION

property :source_db_cluster_identifier, String,
         callbacks: {
           "source_db_cluster_identifier is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Creates a new DB cluster from a DB snapshot or DB cluster snapshot.
            If a DB snapshot is specified, the target DB cluster is created from the source DB snapshot with a default configuration and default security group.
            If a DB cluster snapshot is specified, the target DB cluster is created from the source DB cluster restore point with the same configuration as the original source DB cluster, except that the new DB cluster is created with the default security group.
         DESCRIPTION

property :storage_encrypted, [TrueClass, FalseClass],
         callbacks: {
           "storage_encrypted is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Indicates whether the DB cluster is encrypted.
            If you specify the `DBClusterIdentifier`, `DBSnapshotIdentifier`, or `SourceDBInstanceIdentifier` property, don't specify this property. The value is inherited from the cluster, snapshot, or source DB instance. If you specify the KmsKeyId property, you must enable encryption.
            If you specify the KmsKeyId, you must enable encryption by setting StorageEncrypted to true.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags assigned to this cluster.
         DESCRIPTION

property :use_latest_restorable_time, [TrueClass, FalseClass],
         callbacks: {
           "use_latest_restorable_time is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Creates a new DB cluster from a DB snapshot or DB cluster snapshot.
            If a DB snapshot is specified, the target DB cluster is created from the source DB snapshot with a default configuration and default security group.
            If a DB cluster snapshot is specified, the target DB cluster is created from the source DB cluster restore point with the same configuration as the original source DB cluster, except that the new DB cluster is created with the default security group.
         DESCRIPTION

property :vpc_security_group_ids, Array,
         callbacks: {
           "vpc_security_group_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Provides a list of VPC security groups that the DB cluster belongs to.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Neptune::DBCluster"
rest_api_document "/AWS::Neptune::DBCluster"

rest_property_map({
  associated_roles:                 "AssociatedRoles",
  availability_zones:               "AvailabilityZones",
  backup_retention_period:          "BackupRetentionPeriod",
  copy_tags_to_snapshot:            "CopyTagsToSnapshot",
  db_cluster_identifier:            "DBClusterIdentifier",
  db_cluster_parameter_group_name:  "DBClusterParameterGroupName",
  db_instance_parameter_group_name: "DBInstanceParameterGroupName",
  db_subnet_group_name:             "DBSubnetGroupName",
  deletion_protection:              "DeletionProtection",
  enable_cloudwatch_logs_exports:   "EnableCloudwatchLogsExports",
  engine_version:                   "EngineVersion",
  iam_auth_enabled:                 "IamAuthEnabled",
  kms_key_id:                       "KmsKeyId",
  preferred_backup_window:          "PreferredBackupWindow",
  preferred_maintenance_window:     "PreferredMaintenanceWindow",
  restore_to_time:                  "RestoreToTime",
  restore_type:                     "RestoreType",
  serverless_scaling_configuration: "ServerlessScalingConfiguration",
  snapshot_identifier:              "SnapshotIdentifier",
  source_db_cluster_identifier:     "SourceDBClusterIdentifier",
  storage_encrypted:                "StorageEncrypted",
  tags:                             "Tags",
  use_latest_restorable_time:       "UseLatestRestorableTime",
  vpc_security_group_ids:           "VpcSecurityGroupIds",
})

rest_post_only_properties %i{
  availability_zones db_cluster_identifier db_subnet_group_name kms_key_id restore_to_time restore_type snapshot_identifier source_db_cluster_identifier storage_encrypted use_latest_restorable_time
}
