# Import API specifics
use "awscc_base"

resource_name :aws_rds_db_instance
provides :aws_rds_db_instance, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::RDS::DBInstance resource creates an Amazon RDS DB instance.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :allocated_storage, String,
         callbacks: {
           "allocated_storage is not a String" => lambda { |v| v.is_a? String },
           "allocated_storage must match pattern ^[0-9]*$" => lambda { |v| v =~ Regexp.new("/^[0-9]*$/") },
         },
         description: <<~'DESCRIPTION'
           The amount of storage (in gigabytes) to be initially allocated for the database instance.
         DESCRIPTION

property :allow_major_version_upgrade, [TrueClass, FalseClass],
         callbacks: {
           "allow_major_version_upgrade is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A value that indicates whether major version upgrades are allowed. Changing this parameter doesn't result in an outage and the change is asynchronously applied as soon as possible.
         DESCRIPTION

property :associated_roles, Array,
         callbacks: {
           "associated_roles is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The AWS Identity and Access Management (IAM) roles associated with the DB instance.
         DESCRIPTION

property :auto_minor_version_upgrade, [TrueClass, FalseClass],
         callbacks: {
           "auto_minor_version_upgrade is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A value that indicates whether minor engine upgrades are applied automatically to the DB instance during the maintenance window. By default, minor engine upgrades are applied automatically.
         DESCRIPTION

property :availability_zone, String,
         callbacks: {
           "availability_zone is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Availability Zone (AZ) where the database will be created. For information on AWS Regions and Availability Zones.
         DESCRIPTION

property :backup_retention_period, Integer,
         callbacks: {
           "backup_retention_period is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of days for which automated backups are retained. Setting this parameter to a positive number enables backups. Setting this parameter to 0 disables automated backups.
         DESCRIPTION

property :ca_certificate_identifier, String,
         callbacks: {
           "ca_certificate_identifier is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The identifier of the CA certificate for this DB instance.
         DESCRIPTION

property :character_set_name, String,
         callbacks: {
           "character_set_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           For supported engines, indicates that the DB instance should be associated with the specified character set.
         DESCRIPTION

property :copy_tags_to_snapshot, [TrueClass, FalseClass],
         callbacks: {
           "copy_tags_to_snapshot is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A value that indicates whether to copy tags from the DB instance to snapshots of the DB instance. By default, tags are not copied.
         DESCRIPTION

property :custom_iam_instance_profile, String,
         callbacks: {
           "custom_iam_instance_profile is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The instance profile associated with the underlying Amazon EC2 instance of an RDS Custom DB instance. The instance profile must meet the following requirements:
      * The profile must exist in your account.
      * The profile must have an IAM role that Amazon EC2 has permissions to assume.
      * The instance profile name and the associated IAM role name must start with the prefix AWSRDSCustom .
      For the list of permissions required for the IAM role, see Configure IAM and your VPC in the Amazon RDS User Guide .
            This setting is required for RDS Custom.
         DESCRIPTION

property :db_cluster_identifier, String,
         callbacks: {
           "db_cluster_identifier is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The identifier of the DB cluster that the instance will belong to.
         DESCRIPTION

property :db_instance_class, String,
         callbacks: {
           "db_instance_class is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The compute and memory capacity of the DB instance, for example, db.m4.large. Not all DB instance classes are available in all AWS Regions, or for all database engines.
         DESCRIPTION

property :db_instance_identifier, String,
         callbacks: {
           "db_instance_identifier is not a String" => lambda { |v| v.is_a? String },
           "db_instance_identifier needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
           "db_instance_identifier must match pattern ^$|^[a-zA-Z]{1}(?:-?[a-zA-Z0-9]){0,62}$" => lambda { |v| v =~ Regexp.new("/^$|^[a-zA-Z]{1}(?:-?[a-zA-Z0-9]){0,62}$/") },
         },
         description: <<~'DESCRIPTION'
           A name for the DB instance. If you specify a name, AWS CloudFormation converts it to lowercase. If you don't specify a name, AWS CloudFormation generates a unique physical ID and uses that ID for the DB instance.
         DESCRIPTION

property :db_name, String,
         callbacks: {
           "db_name is not a String" => lambda { |v| v.is_a? String },
           "db_name must match pattern ^$|^[_a-zA-Z][a-zA-Z0-9_]{0,63}$" => lambda { |v| v =~ Regexp.new("/^$|^[_a-zA-Z][a-zA-Z0-9_]{0,63}$/") },
         },
         description: <<~'DESCRIPTION'
           The meaning of this parameter differs according to the database engine you use.
         DESCRIPTION

property :db_parameter_group_name, String,
         callbacks: {
           "db_parameter_group_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of an existing DB parameter group or a reference to an AWS::RDS::DBParameterGroup resource created in the template.
         DESCRIPTION

property :db_security_groups, Array,
         callbacks: {
           "db_security_groups is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of the DB security groups to assign to the DB instance. The list can include both the name of existing DB security groups or references to AWS::RDS::DBSecurityGroup resources created in the template.
         DESCRIPTION

property :db_snapshot_identifier, String,
         callbacks: {
           "db_snapshot_identifier is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name or Amazon Resource Name (ARN) of the DB snapshot that's used to restore the DB instance. If you're restoring from a shared manual DB snapshot, you must specify the ARN of the snapshot.
         DESCRIPTION

property :db_subnet_group_name, String,
         callbacks: {
           "db_subnet_group_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A DB subnet group to associate with the DB instance. If you update this value, the new subnet group must be a subnet group in a new VPC.
         DESCRIPTION

property :delete_automated_backups, [TrueClass, FalseClass],
         callbacks: {
           "delete_automated_backups is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A value that indicates whether to remove automated backups immediately after the DB instance is deleted. This parameter isn't case-sensitive. The default is to remove automated backups immediately after the DB instance is deleted.
         DESCRIPTION

property :deletion_protection, [TrueClass, FalseClass],
         callbacks: {
           "deletion_protection is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A value that indicates whether the DB instance has deletion protection enabled. The database can't be deleted when deletion protection is enabled. By default, deletion protection is disabled.
         DESCRIPTION

property :domain, String,
         callbacks: {
           "domain is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Active Directory directory ID to create the DB instance in. Currently, only MySQL, Microsoft SQL Server, Oracle, and PostgreSQL DB instances can be created in an Active Directory Domain.
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
           The list of log types that need to be enabled for exporting to CloudWatch Logs. The values in the list depend on the DB engine being used.
         DESCRIPTION

property :enable_iam_database_authentication, [TrueClass, FalseClass],
         callbacks: {
           "enable_iam_database_authentication is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A value that indicates whether to enable mapping of AWS Identity and Access Management (IAM) accounts to database accounts. By default, mapping is disabled.
         DESCRIPTION

property :enable_performance_insights, [TrueClass, FalseClass],
         callbacks: {
           "enable_performance_insights is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A value that indicates whether to enable Performance Insights for the DB instance.
         DESCRIPTION

property :endpoint, Hash,
         callbacks: {
           "Subproperty `Address` is not a String" => lambda { |v| v[:Address].is_a? String },
           "Subproperty `Port` is not a String" => lambda { |v| v[:Port].is_a? String },
           "Subproperty `HostedZoneId` is not a String" => lambda { |v| v[:HostedZoneId].is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies the connection endpoint.
         DESCRIPTION

property :engine, String,
         callbacks: {
           "engine is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the database engine that you want to use for this DB instance.
         DESCRIPTION

property :engine_version, String,
         callbacks: {
           "engine_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The version number of the database engine to use.
         DESCRIPTION

property :iops, Integer,
         callbacks: {
           "iops is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of I/O operations per second (IOPS) that the database provisions.
         DESCRIPTION

property :kms_key_id, String,
         callbacks: {
           "kms_key_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ARN of the AWS Key Management Service (AWS KMS) master key that's used to encrypt the DB instance.
         DESCRIPTION

property :license_model, String,
         callbacks: {
           "license_model is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           License model information for this DB instance.
         DESCRIPTION

property :master_user_password, String,
         callbacks: {
           "master_user_password is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The password for the master user.
         DESCRIPTION

property :master_username, String,
         callbacks: {
           "master_username is not a String" => lambda { |v| v.is_a? String },
           "master_username needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "master_username must match pattern ^[a-zA-Z][a-zA-Z0-9_]{0,127}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z][a-zA-Z0-9_]{0,127}$/") },
         },
         description: <<~'DESCRIPTION'
           The master user name for the DB instance.
         DESCRIPTION

property :max_allocated_storage, Integer,
         callbacks: {
           "max_allocated_storage is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The upper limit to which Amazon RDS can automatically scale the storage of the DB instance.
         DESCRIPTION

property :monitoring_interval, Integer,
         callbacks: {
           "monitoring_interval is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0.
         DESCRIPTION

property :monitoring_role_arn, String,
         callbacks: {
           "monitoring_role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to Amazon CloudWatch Logs.
         DESCRIPTION

property :multi_az, [TrueClass, FalseClass],
         callbacks: {
           "multi_az is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Specifies whether the database instance is a multiple Availability Zone deployment.
         DESCRIPTION

property :nchar_character_set_name, String,
         callbacks: {
           "nchar_character_set_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the NCHAR character set for the Oracle DB instance. This parameter doesn't apply to RDS Custom.
         DESCRIPTION

property :network_type, String,
         callbacks: {
           "network_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The network type of the DB cluster.
         DESCRIPTION

property :option_group_name, String,
         callbacks: {
           "option_group_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Indicates that the DB instance should be associated with the specified option group.
         DESCRIPTION

property :performance_insights_kms_key_id, String,
         callbacks: {
           "performance_insights_kms_key_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The AWS KMS key identifier for encryption of Performance Insights data. The KMS key ID is the Amazon Resource Name (ARN), KMS key identifier, or the KMS key alias for the KMS encryption key.
         DESCRIPTION

property :performance_insights_retention_period, Integer,
         callbacks: {
           "performance_insights_retention_period is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The amount of time, in days, to retain Performance Insights data. Valid values are 7 or 731 (2 years).
         DESCRIPTION

property :port, String,
         callbacks: {
           "port is not a String" => lambda { |v| v.is_a? String },
           "port must match pattern ^\d*$" => lambda { |v| v =~ Regexp.new("/^\d*$/") },
         },
         description: <<~'DESCRIPTION'
           The port number on which the database accepts connections.
         DESCRIPTION

property :preferred_backup_window, String,
         callbacks: {
           "preferred_backup_window is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The daily time range during which automated backups are created if automated backups are enabled, using the BackupRetentionPeriod parameter.
         DESCRIPTION

property :preferred_maintenance_window, String,
         callbacks: {
           "preferred_maintenance_window is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           he weekly time range during which system maintenance can occur, in Universal Coordinated Time (UTC).
         DESCRIPTION

property :processor_features, Array,
         callbacks: {
           "processor_features is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The number of CPU cores and the number of threads per core for the DB instance class of the DB instance.
         DESCRIPTION

property :promotion_tier, Integer,
         callbacks: {
           "promotion_tier is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           A value that specifies the order in which an Aurora Replica is promoted to the primary instance after a failure of the existing primary instance.
         DESCRIPTION

property :publicly_accessible, [TrueClass, FalseClass],
         callbacks: {
           "publicly_accessible is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Indicates whether the DB instance is an internet-facing instance. If you specify true, AWS CloudFormation creates an instance with a publicly resolvable DNS name, which resolves to a public IP address. If you specify false, AWS CloudFormation creates an internal instance with a DNS name that resolves to a private IP address.
         DESCRIPTION

property :replica_mode, String,
         callbacks: {
           "replica_mode is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The open mode of an Oracle read replica. The default is open-read-only.
         DESCRIPTION

property :source_db_instance_identifier, String,
         callbacks: {
           "source_db_instance_identifier is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           If you want to create a Read Replica DB instance, specify the ID of the source DB instance. Each DB instance can have a limited number of Read Replicas.
         DESCRIPTION

property :source_region, String,
         callbacks: {
           "source_region is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the region that contains the source DB instance for the Read Replica.
         DESCRIPTION

property :storage_encrypted, [TrueClass, FalseClass],
         callbacks: {
           "storage_encrypted is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A value that indicates whether the DB instance is encrypted. By default, it isn't encrypted.
         DESCRIPTION

property :storage_throughput, Integer,
         callbacks: {
           "storage_throughput is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           Specifies the storage throughput for the DB instance.
         DESCRIPTION

property :storage_type, String,
         callbacks: {
           "storage_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies the storage type to be associated with the DB instance.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Tags to assign to the DB instance.
         DESCRIPTION

property :tde_credential_arn, String,
         callbacks: {
           "tde_credential_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ARN from the key store with which to associate the instance for TDE encryption.
         DESCRIPTION

property :tde_credential_password, String,
         callbacks: {
           "tde_credential_password is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The password for the given ARN from the key store in order to access the device.
         DESCRIPTION

property :timezone, String,
         callbacks: {
           "timezone is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The time zone of the DB instance. The time zone parameter is currently supported only by Microsoft SQL Server.
         DESCRIPTION

property :use_default_processor_features, [TrueClass, FalseClass],
         callbacks: {
           "use_default_processor_features is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A value that indicates whether the DB instance class of the DB instance uses its default processor features.
         DESCRIPTION

property :vpc_security_groups, Array,
         callbacks: {
           "vpc_security_groups is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of the VPC security group IDs to assign to the DB instance. The list can include both the physical IDs of existing VPC security groups and references to AWS::EC2::SecurityGroup resources created in the template.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::RDS::DBInstance"
rest_api_document "/AWS::RDS::DBInstance"

rest_property_map({
  allocated_storage:                     "AllocatedStorage",
  allow_major_version_upgrade:           "AllowMajorVersionUpgrade",
  associated_roles:                      "AssociatedRoles",
  auto_minor_version_upgrade:            "AutoMinorVersionUpgrade",
  availability_zone:                     "AvailabilityZone",
  backup_retention_period:               "BackupRetentionPeriod",
  ca_certificate_identifier:             "CACertificateIdentifier",
  character_set_name:                    "CharacterSetName",
  copy_tags_to_snapshot:                 "CopyTagsToSnapshot",
  custom_iam_instance_profile:           "CustomIAMInstanceProfile",
  db_cluster_identifier:                 "DBClusterIdentifier",
  db_instance_class:                     "DBInstanceClass",
  db_instance_identifier:                "DBInstanceIdentifier",
  db_name:                               "DBName",
  db_parameter_group_name:               "DBParameterGroupName",
  db_security_groups:                    "DBSecurityGroups",
  db_snapshot_identifier:                "DBSnapshotIdentifier",
  db_subnet_group_name:                  "DBSubnetGroupName",
  delete_automated_backups:              "DeleteAutomatedBackups",
  deletion_protection:                   "DeletionProtection",
  domain:                                "Domain",
  domain_iam_role_name:                  "DomainIAMRoleName",
  enable_cloudwatch_logs_exports:        "EnableCloudwatchLogsExports",
  enable_iam_database_authentication:    "EnableIAMDatabaseAuthentication",
  enable_performance_insights:           "EnablePerformanceInsights",
  endpoint:                              "Endpoint",
  engine:                                "Engine",
  engine_version:                        "EngineVersion",
  iops:                                  "Iops",
  kms_key_id:                            "KmsKeyId",
  license_model:                         "LicenseModel",
  master_user_password:                  "MasterUserPassword",
  master_username:                       "MasterUsername",
  max_allocated_storage:                 "MaxAllocatedStorage",
  monitoring_interval:                   "MonitoringInterval",
  monitoring_role_arn:                   "MonitoringRoleArn",
  multi_az:                              "MultiAZ",
  nchar_character_set_name:              "NcharCharacterSetName",
  network_type:                          "NetworkType",
  option_group_name:                     "OptionGroupName",
  performance_insights_kms_key_id:       "PerformanceInsightsKMSKeyId",
  performance_insights_retention_period: "PerformanceInsightsRetentionPeriod",
  port:                                  "Port",
  preferred_backup_window:               "PreferredBackupWindow",
  preferred_maintenance_window:          "PreferredMaintenanceWindow",
  processor_features:                    "ProcessorFeatures",
  promotion_tier:                        "PromotionTier",
  publicly_accessible:                   "PubliclyAccessible",
  replica_mode:                          "ReplicaMode",
  source_db_instance_identifier:         "SourceDBInstanceIdentifier",
  source_region:                         "SourceRegion",
  storage_encrypted:                     "StorageEncrypted",
  storage_throughput:                    "StorageThroughput",
  storage_type:                          "StorageType",
  tags:                                  "Tags",
  tde_credential_arn:                    "TdeCredentialArn",
  tde_credential_password:               "TdeCredentialPassword",
  timezone:                              "Timezone",
  use_default_processor_features:        "UseDefaultProcessorFeatures",
  vpc_security_groups:                   "VPCSecurityGroups",
})

rest_post_only_properties %i{
  character_set_name custom_iam_instance_profile db_cluster_identifier db_instance_identifier db_name db_subnet_group_name kms_key_id master_username nchar_character_set_name port source_region storage_encrypted timezone
}
