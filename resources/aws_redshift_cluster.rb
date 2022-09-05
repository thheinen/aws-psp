# Import API specifics
use "awscc_base"

resource_name :aws_redshift_cluster
provides :aws_redshift_cluster, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  An example resource schema demonstrating some basic constructs and validation rules.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :allow_version_upgrade, [TrueClass, FalseClass],
         callbacks: {
           "allow_version_upgrade is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Major version upgrades can be applied during the maintenance window to the Amazon Redshift engine that is running on the cluster. Default value is True
         DESCRIPTION

property :aqua_configuration_status, String,
         callbacks: {
           "aqua_configuration_status is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The value represents how the cluster is configured to use AQUA (Advanced Query Accelerator) after the cluster is restored. Possible values include the following.
            enabled - Use AQUA if it is available for the current Region and Amazon Redshift node type.
      disabled - Don't use AQUA.
      auto - Amazon Redshift determines whether to use AQUA.

         DESCRIPTION

property :automated_snapshot_retention_period, Integer,
         callbacks: {
           "automated_snapshot_retention_period is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of days that automated snapshots are retained. If the value is 0, automated snapshots are disabled. Default value is 1
         DESCRIPTION

property :availability_zone, String,
         callbacks: {
           "availability_zone is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The EC2 Availability Zone (AZ) in which you want Amazon Redshift to provision the cluster. Default: A random, system-chosen Availability Zone in the region that is specified by the endpoint
         DESCRIPTION

property :availability_zone_relocation, [TrueClass, FalseClass],
         callbacks: {
           "availability_zone_relocation is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           The option to enable relocation for an Amazon Redshift cluster between Availability Zones after the cluster modification is complete.
         DESCRIPTION

property :availability_zone_relocation_status, String,
         callbacks: {
           "availability_zone_relocation_status is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The availability zone relocation status of the cluster
         DESCRIPTION

property :classic, [TrueClass, FalseClass],
         callbacks: {
           "classic is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A boolean value indicating whether the resize operation is using the classic resize process. If you don't provide this parameter or set the value to false , the resize type is elastic.
         DESCRIPTION

property :cluster_identifier, String,
         callbacks: {
           "cluster_identifier is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A unique identifier for the cluster. You use this identifier to refer to the cluster for any subsequent cluster operations such as deleting or modifying. All alphabetical characters must be lower case, no hypens at the end, no two consecutive hyphens. Cluster name should be unique for all clusters within an AWS account
         DESCRIPTION

property :cluster_parameter_group_name, String,
         callbacks: {
           "cluster_parameter_group_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the parameter group to be associated with this cluster.
         DESCRIPTION

property :cluster_security_groups, Array,
         callbacks: {
           "cluster_security_groups is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of security groups to be associated with this cluster.
         DESCRIPTION

property :cluster_subnet_group_name, String,
         callbacks: {
           "cluster_subnet_group_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of a cluster subnet group to be associated with this cluster.
         DESCRIPTION

property :cluster_type, String,
         required: true,
         callbacks: {
           "cluster_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The type of the cluster. When cluster type is specified as single-node, the NumberOfNodes parameter is not required and if multi-node, the NumberOfNodes parameter is required
         DESCRIPTION

property :cluster_version, String,
         callbacks: {
           "cluster_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The version of the Amazon Redshift engine software that you want to deploy on the cluster.The version selected runs on all the nodes in the cluster.
         DESCRIPTION

property :db_name, String,
         required: true,
         callbacks: {
           "db_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the first database to be created when the cluster is created. To create additional databases after the cluster is created, connect to the cluster with a SQL client and use SQL commands to create a database.
         DESCRIPTION

property :defer_maintenance, [TrueClass, FalseClass],
         callbacks: {
           "defer_maintenance is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A boolean indicating whether to enable the deferred maintenance window.
         DESCRIPTION

property :defer_maintenance_duration, Integer,
         callbacks: {
           "defer_maintenance_duration is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           An integer indicating the duration of the maintenance window in days. If you specify a duration, you can't specify an end time. The duration must be 45 days or less.
         DESCRIPTION

property :defer_maintenance_end_time, String,
         callbacks: {
           "defer_maintenance_end_time is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A timestamp indicating end time for the deferred maintenance window. If you specify an end time, you can't specify a duration.
         DESCRIPTION

property :defer_maintenance_start_time, String,
         callbacks: {
           "defer_maintenance_start_time is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A timestamp indicating the start time for the deferred maintenance window.
         DESCRIPTION

property :destination_region, String,
         callbacks: {
           "destination_region is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The destination AWS Region that you want to copy snapshots to. Constraints: Must be the name of a valid AWS Region. For more information, see Regions and Endpoints in the Amazon Web Services [https://docs.aws.amazon.com/general/latest/gr/rande.html#redshift_region] General Reference
         DESCRIPTION

property :elastic_ip, String,
         callbacks: {
           "elastic_ip is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Elastic IP (EIP) address for the cluster.
         DESCRIPTION

property :encrypted, [TrueClass, FalseClass],
         callbacks: {
           "encrypted is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           If true, the data in the cluster is encrypted at rest.
         DESCRIPTION

property :endpoint, Hash,
         callbacks: {
           "Subproperty `Port` is not a String" => lambda { |v| v[:Port].is_a? String },
           "Subproperty `Address` is not a String" => lambda { |v| v[:Address].is_a? String },
         },
         description: ""

property :enhanced_vpc_routing, [TrueClass, FalseClass],
         callbacks: {
           "enhanced_vpc_routing is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           An option that specifies whether to create the cluster with enhanced VPC routing enabled. To create a cluster that uses enhanced VPC routing, the cluster must be in a VPC. For more information, see Enhanced VPC Routing in the Amazon Redshift Cluster Management Guide.
            If this option is true , enhanced VPC routing is enabled.
            Default: false
         DESCRIPTION

property :hsm_client_certificate_identifier, String,
         callbacks: {
           "hsm_client_certificate_identifier is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies the name of the HSM client certificate the Amazon Redshift cluster uses to retrieve the data encryption keys stored in an HSM
         DESCRIPTION

property :hsm_configuration_identifier, String,
         callbacks: {
           "hsm_configuration_identifier is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies the name of the HSM configuration that contains the information the Amazon Redshift cluster can use to retrieve and store keys in an HSM.
         DESCRIPTION

property :iam_roles, Array,
         callbacks: {
           "iam_roles is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of AWS Identity and Access Management (IAM) roles that can be used by the cluster to access other AWS services. You must supply the IAM roles in their Amazon Resource Name (ARN) format. You can supply up to 10 IAM roles in a single request
         DESCRIPTION

property :kms_key_id, String,
         callbacks: {
           "kms_key_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The AWS Key Management Service (KMS) key ID of the encryption key that you want to use to encrypt data in the cluster.
         DESCRIPTION

property :logging_properties, Hash,
         callbacks: {
           "Subproperty `BucketName` is not a String" => lambda { |v| v[:BucketName].is_a? String },
           "Subproperty `S3KeyPrefix` is not a String" => lambda { |v| v[:S3KeyPrefix].is_a? String },
         },
         description: ""

property :maintenance_track_name, String,
         callbacks: {
           "maintenance_track_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name for the maintenance track that you want to assign for the cluster. This name change is asynchronous. The new track name stays in the PendingModifiedValues for the cluster until the next maintenance window. When the maintenance track changes, the cluster is switched to the latest cluster release available for the maintenance track. At this point, the maintenance track name is applied.
         DESCRIPTION

property :manual_snapshot_retention_period, Integer,
         callbacks: {
           "manual_snapshot_retention_period is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of days to retain newly copied snapshots in the destination AWS Region after they are copied from the source AWS Region. If the value is -1, the manual snapshot is retained indefinitely.
            The value must be either -1 or an integer between 1 and 3,653.
         DESCRIPTION

property :master_user_password, String,
         required: true,
         callbacks: {
           "master_user_password is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The password associated with the master user account for the cluster that is being created. Password must be between 8 and 64 characters in length, should have at least one uppercase letter.Must contain at least one lowercase letter.Must contain one number.Can be any printable ASCII character.
         DESCRIPTION

property :master_username, String,
         required: true,
         callbacks: {
           "master_username is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The user name associated with the master user account for the cluster that is being created. The user name can't be PUBLIC and first character must be a letter.
         DESCRIPTION

property :node_type, String,
         required: true,
         callbacks: {
           "node_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The node type to be provisioned for the cluster.Valid Values: ds2.xlarge | ds2.8xlarge | dc1.large | dc1.8xlarge | dc2.large | dc2.8xlarge | ra3.4xlarge | ra3.16xlarge
         DESCRIPTION

property :number_of_nodes, Integer,
         callbacks: {
           "number_of_nodes is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of compute nodes in the cluster. This parameter is required when the ClusterType parameter is specified as multi-node.
         DESCRIPTION

property :owner_account, String,
         callbacks: {
           "owner_account is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :port, Integer,
         callbacks: {
           "port is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The port number on which the cluster accepts incoming connections. The cluster is accessible only via the JDBC and ODBC connection strings
         DESCRIPTION

property :preferred_maintenance_window, String,
         callbacks: {
           "preferred_maintenance_window is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The weekly time range (in UTC) during which automated cluster maintenance can occur.
         DESCRIPTION

property :publicly_accessible, [TrueClass, FalseClass],
         callbacks: {
           "publicly_accessible is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           If true, the cluster can be accessed from a public network.
         DESCRIPTION

property :resource_action, String,
         callbacks: {
           "resource_action is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Redshift operation to be performed. Resource Action supports pause-cluster, resume-cluster APIs
         DESCRIPTION

property :revision_target, String,
         callbacks: {
           "revision_target is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The identifier of the database revision. You can retrieve this value from the response to the DescribeClusterDbRevisions request.
         DESCRIPTION

property :rotate_encryption_key, [TrueClass, FalseClass],
         callbacks: {
           "rotate_encryption_key is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A boolean indicating if we want to rotate Encryption Keys.
         DESCRIPTION

property :snapshot_cluster_identifier, String,
         callbacks: {
           "snapshot_cluster_identifier is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the cluster the source snapshot was created from. This parameter is required if your IAM user has a policy containing a snapshot resource element that specifies anything other than * for the cluster name.
         DESCRIPTION

property :snapshot_copy_grant_name, String,
         callbacks: {
           "snapshot_copy_grant_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the snapshot copy grant to use when snapshots of an AWS KMS-encrypted cluster are copied to the destination region.
         DESCRIPTION

property :snapshot_copy_manual, [TrueClass, FalseClass],
         callbacks: {
           "snapshot_copy_manual is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Indicates whether to apply the snapshot retention period to newly copied manual snapshots instead of automated snapshots.
         DESCRIPTION

property :snapshot_copy_retention_period, Integer,
         callbacks: {
           "snapshot_copy_retention_period is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of days to retain automated snapshots in the destination region after they are copied from the source region.
            Default is 7.
            Constraints: Must be at least 1 and no more than 35.
         DESCRIPTION

property :snapshot_identifier, String,
         callbacks: {
           "snapshot_identifier is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the snapshot from which to create the new cluster. This parameter isn't case sensitive.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The list of tags for the cluster parameter group.
         DESCRIPTION

property :vpc_security_group_ids, Array,
         callbacks: {
           "vpc_security_group_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of Virtual Private Cloud (VPC) security groups to be associated with the cluster.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Redshift::Cluster"
rest_api_document "/AWS::Redshift::Cluster"

rest_property_map({
  allow_version_upgrade:               "AllowVersionUpgrade",
  aqua_configuration_status:           "AquaConfigurationStatus",
  automated_snapshot_retention_period: "AutomatedSnapshotRetentionPeriod",
  availability_zone:                   "AvailabilityZone",
  availability_zone_relocation:        "AvailabilityZoneRelocation",
  availability_zone_relocation_status: "AvailabilityZoneRelocationStatus",
  classic:                             "Classic",
  cluster_identifier:                  "ClusterIdentifier",
  cluster_parameter_group_name:        "ClusterParameterGroupName",
  cluster_security_groups:             "ClusterSecurityGroups",
  cluster_subnet_group_name:           "ClusterSubnetGroupName",
  cluster_type:                        "ClusterType",
  cluster_version:                     "ClusterVersion",
  db_name:                             "DBName",
  defer_maintenance:                   "DeferMaintenance",
  defer_maintenance_duration:          "DeferMaintenanceDuration",
  defer_maintenance_end_time:          "DeferMaintenanceEndTime",
  defer_maintenance_start_time:        "DeferMaintenanceStartTime",
  destination_region:                  "DestinationRegion",
  elastic_ip:                          "ElasticIp",
  encrypted:                           "Encrypted",
  endpoint:                            "Endpoint",
  enhanced_vpc_routing:                "EnhancedVpcRouting",
  hsm_client_certificate_identifier:   "HsmClientCertificateIdentifier",
  hsm_configuration_identifier:        "HsmConfigurationIdentifier",
  iam_roles:                           "IamRoles",
  kms_key_id:                          "KmsKeyId",
  logging_properties:                  "LoggingProperties",
  maintenance_track_name:              "MaintenanceTrackName",
  manual_snapshot_retention_period:    "ManualSnapshotRetentionPeriod",
  master_user_password:                "MasterUserPassword",
  master_username:                     "MasterUsername",
  node_type:                           "NodeType",
  number_of_nodes:                     "NumberOfNodes",
  owner_account:                       "OwnerAccount",
  port:                                "Port",
  preferred_maintenance_window:        "PreferredMaintenanceWindow",
  publicly_accessible:                 "PubliclyAccessible",
  resource_action:                     "ResourceAction",
  revision_target:                     "RevisionTarget",
  rotate_encryption_key:               "RotateEncryptionKey",
  snapshot_cluster_identifier:         "SnapshotClusterIdentifier",
  snapshot_copy_grant_name:            "SnapshotCopyGrantName",
  snapshot_copy_manual:                "SnapshotCopyManual",
  snapshot_copy_retention_period:      "SnapshotCopyRetentionPeriod",
  snapshot_identifier:                 "SnapshotIdentifier",
  tags:                                "Tags",
  vpc_security_group_ids:              "VpcSecurityGroupIds",
})

rest_post_only_properties %i{
  cluster_identifier cluster_subnet_group_name db_name master_username owner_account snapshot_cluster_identifier snapshot_identifier
}
