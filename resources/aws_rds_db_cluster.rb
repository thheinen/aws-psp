# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_rds_db_cluster
provides :aws_rds_db_cluster, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::RDS::DBCluster resource creates an Amazon Aurora DB cluster.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :allocated_storage, Integer,
         callbacks: {
           "allocated_storage is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The amount of storage in gibibytes (GiB) to allocate to each DB instance in the Multi-AZ DB cluster.
         DESCRIPTION

property :associated_roles, Array,
         callbacks: {
           "associated_roles is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Provides a list of the AWS Identity and Access Management (IAM) roles that are associated with the DB cluster. IAM roles that are associated with a DB cluster grant permission for the DB cluster to access other AWS services on your behalf.
         DESCRIPTION

property :auto_minor_version_upgrade, [TrueClass, FalseClass],
         callbacks: {
           "auto_minor_version_upgrade is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A value that indicates whether minor engine upgrades are applied automatically to the DB cluster during the maintenance window. By default, minor engine upgrades are applied automatically.
         DESCRIPTION

property :availability_zones, Array,
         callbacks: {
           "availability_zones is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of Availability Zones (AZs) where instances in the DB cluster can be created. For information on AWS Regions and Availability Zones, see Choosing the Regions and Availability Zones in the Amazon Aurora User Guide.
         DESCRIPTION

property :backtrack_window, Integer,
         callbacks: {
           "backtrack_window is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The target backtrack window, in seconds. To disable backtracking, set this value to 0.
         DESCRIPTION

property :backup_retention_period, Integer,
         callbacks: {
           "backup_retention_period is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of days for which automated backups are retained.
         DESCRIPTION

property :copy_tags_to_snapshot, [TrueClass, FalseClass],
         callbacks: {
           "copy_tags_to_snapshot is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A value that indicates whether to copy all tags from the DB cluster to snapshots of the DB cluster. The default is not to copy them.
         DESCRIPTION

property :database_name, String,
         callbacks: {
           "database_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of your database. If you don't provide a name, then Amazon RDS won't create a database in this DB cluster. For naming constraints, see Naming Constraints in the Amazon RDS User Guide.
         DESCRIPTION

property :db_cluster_identifier, String,
         callbacks: {
           "db_cluster_identifier is not a String" => lambda { |v| v.is_a? String },
           "db_cluster_identifier needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
           "db_cluster_identifier must match pattern ^[a-zA-Z]{1}(?:-?[a-zA-Z0-9]){0,62}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z]{1}(?:-?[a-zA-Z0-9]){0,62}$/") },
         },
         description: <<~'DESCRIPTION'
           The DB cluster identifier. This parameter is stored as a lowercase string.
         DESCRIPTION

property :db_cluster_instance_class, String,
         callbacks: {
           "db_cluster_instance_class is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The compute and memory capacity of each DB instance in the Multi-AZ DB cluster, for example db.m6g.xlarge.
         DESCRIPTION

property :db_cluster_parameter_group_name, String,
         callbacks: {
           "db_cluster_parameter_group_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the DB cluster parameter group to associate with this DB cluster.
         DESCRIPTION

property :db_instance_parameter_group_name, String,
         callbacks: {
           "db_instance_parameter_group_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the DB parameter group to apply to all instances of the DB cluster.
         DESCRIPTION

property :db_subnet_group_name, String,
         callbacks: {
           "db_subnet_group_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A DB subnet group that you want to associate with this DB cluster.
         DESCRIPTION

property :deletion_protection, [TrueClass, FalseClass],
         callbacks: {
           "deletion_protection is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A value that indicates whether the DB cluster has deletion protection enabled. The database can't be deleted when deletion protection is enabled. By default, deletion protection is disabled.
         DESCRIPTION

property :domain, String,
         callbacks: {
           "domain is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Active Directory directory ID to create the DB cluster in.
         DESCRIPTION

property :domain_iam_role_name, String,
         callbacks: {
           "domain_iam_role_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specify the name of the IAM role to be used when making API calls to the Directory Service.
         DESCRIPTION

property :enable_cloudwatch_logs_exports, Array,
         callbacks: {
           "enable_cloudwatch_logs_exports is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The list of log types that need to be enabled for exporting to CloudWatch Logs. The values in the list depend on the DB engine being used. For more information, see Publishing Database Logs to Amazon CloudWatch Logs in the Amazon Aurora User Guide.
         DESCRIPTION

property :enable_http_endpoint, [TrueClass, FalseClass],
         callbacks: {
           "enable_http_endpoint is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A value that indicates whether to enable the HTTP endpoint for an Aurora Serverless DB cluster. By default, the HTTP endpoint is disabled.
         DESCRIPTION

property :enable_iam_database_authentication, [TrueClass, FalseClass],
         callbacks: {
           "enable_iam_database_authentication is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A value that indicates whether to enable mapping of AWS Identity and Access Management (IAM) accounts to database accounts. By default, mapping is disabled.
         DESCRIPTION

property :engine, String,
         callbacks: {
           "engine is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the database engine to be used for this DB cluster. Valid Values: aurora (for MySQL 5.6-compatible Aurora), aurora-mysql (for MySQL 5.7-compatible Aurora), and aurora-postgresql
         DESCRIPTION

property :engine_mode, String,
         callbacks: {
           "engine_mode is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The DB engine mode of the DB cluster, either provisioned, serverless, parallelquery, global, or multimaster.
         DESCRIPTION

property :engine_version, String,
         callbacks: {
           "engine_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The version number of the database engine to use.
         DESCRIPTION

property :global_cluster_identifier, String,
         callbacks: {
           "global_cluster_identifier is not a String" => lambda { |v| v.is_a? String },
           "global_cluster_identifier needs to be 0..63 characters" => lambda { |v| v.length >= 0 && v.length <= 63 },
           "global_cluster_identifier must match pattern ^$|^[a-zA-Z]{1}(?:-?[a-zA-Z0-9]){0,62}$" => lambda { |v| v =~ Regexp.new("/^$|^[a-zA-Z]{1}(?:-?[a-zA-Z0-9]){0,62}$/") },
         },
         description: <<~'DESCRIPTION'
           If you are configuring an Aurora global database cluster and want your Aurora DB cluster to be a secondary member in the global database cluster, specify the global cluster ID of the global database cluster. To define the primary database cluster of the global cluster, use the AWS::RDS::GlobalCluster resource.
            If you aren't configuring a global database cluster, don't specify this property.
         DESCRIPTION

property :iops, Integer,
         callbacks: {
           "iops is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The amount of Provisioned IOPS (input/output operations per second) to be initially allocated for each DB instance in the Multi-AZ DB cluster.
         DESCRIPTION

property :kms_key_id, String,
         callbacks: {
           "kms_key_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the AWS Key Management Service master key that is used to encrypt the database instances in the DB cluster, such as arn:aws:kms:us-east-1:012345678910:key/abcd1234-a123-456a-a12b-a123b4cd56ef. If you enable the StorageEncrypted property but don't specify this property, the default master key is used. If you specify this property, you must set the StorageEncrypted property to true.
         DESCRIPTION

property :master_user_password, String,
         callbacks: {
           "master_user_password is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The master password for the DB instance.
         DESCRIPTION

property :master_username, String,
         callbacks: {
           "master_username is not a String" => lambda { |v| v.is_a? String },
           "master_username must match pattern ^[a-zA-Z]{1}[a-zA-Z0-9_]*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z]{1}[a-zA-Z0-9_]*$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the master user for the DB cluster. You must specify MasterUsername, unless you specify SnapshotIdentifier. In that case, don't specify MasterUsername.
         DESCRIPTION

property :monitoring_interval, Integer,
         callbacks: {
           "monitoring_interval is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB cluster. To turn off collecting Enhanced Monitoring metrics, specify 0. The default is 0.
         DESCRIPTION

property :monitoring_role_arn, String,
         callbacks: {
           "monitoring_role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) for the IAM role that permits RDS to send Enhanced Monitoring metrics to Amazon CloudWatch Logs.
         DESCRIPTION

property :network_type, String,
         callbacks: {
           "network_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The network type of the DB cluster.
         DESCRIPTION

property :performance_insights_enabled, [TrueClass, FalseClass],
         callbacks: {
           "performance_insights_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A value that indicates whether to turn on Performance Insights for the DB cluster.
         DESCRIPTION

property :performance_insights_kms_key_id, String,
         callbacks: {
           "performance_insights_kms_key_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Web Services KMS key identifier for encryption of Performance Insights data.
         DESCRIPTION

property :performance_insights_retention_period, Integer,
         callbacks: {
           "performance_insights_retention_period is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The amount of time, in days, to retain Performance Insights data.
         DESCRIPTION

property :port, Integer,
         callbacks: {
           "port is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The port number on which the instances in the DB cluster accept connections. Default: 3306 if engine is set as aurora or 5432 if set to aurora-postgresql.
         DESCRIPTION

property :preferred_backup_window, String,
         callbacks: {
           "preferred_backup_window is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter. The default is a 30-minute window selected at random from an 8-hour block of time for each AWS Region. To see the time blocks available, see Adjusting the Preferred DB Cluster Maintenance Window in the Amazon Aurora User Guide.
         DESCRIPTION

property :preferred_maintenance_window, String,
         callbacks: {
           "preferred_maintenance_window is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The weekly time range during which system maintenance can occur, in Universal Coordinated Time (UTC). The default is a 30-minute window selected at random from an 8-hour block of time for each AWS Region, occurring on a random day of the week. To see the time blocks available, see Adjusting the Preferred DB Cluster Maintenance Window in the Amazon Aurora User Guide.
         DESCRIPTION

property :publicly_accessible, [TrueClass, FalseClass],
         callbacks: {
           "publicly_accessible is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A value that indicates whether the DB cluster is publicly accessible.
         DESCRIPTION

property :read_endpoint, Hash,
         callbacks: {
           "Subproperty `Address` is not a String" => lambda { |v| v[:Address].is_a? String },
         },
         description: ""

property :replication_source_identifier, String,
         callbacks: {
           "replication_source_identifier is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the source DB instance or DB cluster if this DB cluster is created as a Read Replica.
         DESCRIPTION

property :restore_type, String,
         callbacks: {
           "restore_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The type of restore to be performed. You can specify one of the following values:
      full-copy - The new DB cluster is restored as a full copy of the source DB cluster.
      copy-on-write - The new DB cluster is restored as a clone of the source DB cluster.
         DESCRIPTION

property :scaling_configuration, Hash,
         callbacks: {
           "Subproperty `AutoPause` is not a Boolean" => lambda { |v| v[:AutoPause].is_a? Boolean },
           "Subproperty `MaxCapacity` is not a Integer" => lambda { |v| v[:MaxCapacity].is_a? Integer },
           "Subproperty `MinCapacity` is not a Integer" => lambda { |v| v[:MinCapacity].is_a? Integer },
           "Subproperty `SecondsUntilAutoPause` is not a Integer" => lambda { |v| v[:SecondsUntilAutoPause].is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The ScalingConfiguration property type specifies the scaling configuration of an Aurora Serverless DB cluster.
         DESCRIPTION

property :serverless_v2_scaling_configuration, Hash,
         callbacks: {
           "Subproperty `MinCapacity` is not a Number" => lambda { |v| v[:MinCapacity].is_a? Number },
           "Subproperty `MaxCapacity` is not a Number" => lambda { |v| v[:MaxCapacity].is_a? Number },
         },
         description: <<~'DESCRIPTION'
           Contains the scaling configuration of an Aurora Serverless v2 DB cluster.
         DESCRIPTION

property :snapshot_identifier, String,
         callbacks: {
           "snapshot_identifier is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The identifier for the DB snapshot or DB cluster snapshot to restore from.
      You can use either the name or the Amazon Resource Name (ARN) to specify a DB cluster snapshot. However, you can use only the ARN to specify a DB snapshot.
      After you restore a DB cluster with a SnapshotIdentifier property, you must specify the same SnapshotIdentifier property for any future updates to the DB cluster. When you specify this property for an update, the DB cluster is not restored from the snapshot again, and the data in the database is not changed. However, if you don't specify the SnapshotIdentifier property, an empty DB cluster is created, and the original DB cluster is deleted. If you specify a property that is different from the previous snapshot restore property, the DB cluster is restored from the specified SnapshotIdentifier property, and the original DB cluster is deleted.
         DESCRIPTION

property :source_db_cluster_identifier, String,
         callbacks: {
           "source_db_cluster_identifier is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The identifier of the source DB cluster from which to restore.
         DESCRIPTION

property :source_region, String,
         callbacks: {
           "source_region is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The AWS Region which contains the source DB cluster when replicating a DB cluster. For example, us-east-1.
         DESCRIPTION

property :storage_encrypted, [TrueClass, FalseClass],
         callbacks: {
           "storage_encrypted is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Indicates whether the DB instance is encrypted.
      If you specify the DBClusterIdentifier, SnapshotIdentifier, or SourceDBInstanceIdentifier property, don't specify this property. The value is inherited from the cluster, snapshot, or source DB instance.
         DESCRIPTION

property :storage_type, String,
         callbacks: {
           "storage_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies the storage type to be associated with the DB cluster.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

property :use_latest_restorable_time, [TrueClass, FalseClass],
         callbacks: {
           "use_latest_restorable_time is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A value that indicates whether to restore the DB cluster to the latest restorable backup time. By default, the DB cluster is not restored to the latest restorable backup time.
         DESCRIPTION

property :vpc_security_group_ids, Array,
         callbacks: {
           "vpc_security_group_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of EC2 VPC security groups to associate with this DB cluster.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::RDS::DBCluster"
rest_api_document "/AWS::RDS::DBCluster"

rest_property_map({
  allocated_storage:                     "AllocatedStorage",
  associated_roles:                      "AssociatedRoles",
  auto_minor_version_upgrade:            "AutoMinorVersionUpgrade",
  availability_zones:                    "AvailabilityZones",
  backtrack_window:                      "BacktrackWindow",
  backup_retention_period:               "BackupRetentionPeriod",
  copy_tags_to_snapshot:                 "CopyTagsToSnapshot",
  database_name:                         "DatabaseName",
  db_cluster_identifier:                 "DBClusterIdentifier",
  db_cluster_instance_class:             "DBClusterInstanceClass",
  db_cluster_parameter_group_name:       "DBClusterParameterGroupName",
  db_instance_parameter_group_name:      "DBInstanceParameterGroupName",
  db_subnet_group_name:                  "DBSubnetGroupName",
  deletion_protection:                   "DeletionProtection",
  domain:                                "Domain",
  domain_iam_role_name:                  "DomainIAMRoleName",
  enable_cloudwatch_logs_exports:        "EnableCloudwatchLogsExports",
  enable_http_endpoint:                  "EnableHttpEndpoint",
  enable_iam_database_authentication:    "EnableIAMDatabaseAuthentication",
  engine:                                "Engine",
  engine_mode:                           "EngineMode",
  engine_version:                        "EngineVersion",
  global_cluster_identifier:             "GlobalClusterIdentifier",
  iops:                                  "Iops",
  kms_key_id:                            "KmsKeyId",
  master_user_password:                  "MasterUserPassword",
  master_username:                       "MasterUsername",
  monitoring_interval:                   "MonitoringInterval",
  monitoring_role_arn:                   "MonitoringRoleArn",
  network_type:                          "NetworkType",
  performance_insights_enabled:          "PerformanceInsightsEnabled",
  performance_insights_kms_key_id:       "PerformanceInsightsKmsKeyId",
  performance_insights_retention_period: "PerformanceInsightsRetentionPeriod",
  port:                                  "Port",
  preferred_backup_window:               "PreferredBackupWindow",
  preferred_maintenance_window:          "PreferredMaintenanceWindow",
  publicly_accessible:                   "PubliclyAccessible",
  read_endpoint:                         "ReadEndpoint",
  replication_source_identifier:         "ReplicationSourceIdentifier",
  restore_type:                          "RestoreType",
  scaling_configuration:                 "ScalingConfiguration",
  serverless_v2_scaling_configuration:   "ServerlessV2ScalingConfiguration",
  snapshot_identifier:                   "SnapshotIdentifier",
  source_db_cluster_identifier:          "SourceDBClusterIdentifier",
  source_region:                         "SourceRegion",
  storage_encrypted:                     "StorageEncrypted",
  storage_type:                          "StorageType",
  tags:                                  "Tags",
  use_latest_restorable_time:            "UseLatestRestorableTime",
  vpc_security_group_ids:                "VpcSecurityGroupIds",
})

rest_post_only_properties %i{
  availability_zones database_name db_cluster_identifier db_subnet_group_name engine_mode kms_key_id publicly_accessible restore_type snapshot_identifier source_db_cluster_identifier source_region storage_encrypted use_latest_restorable_time
}
