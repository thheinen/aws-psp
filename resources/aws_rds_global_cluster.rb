# Import API specifics
use "awscc_base"

resource_name :aws_rds_global_cluster
provides :aws_rds_global_cluster, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::RDS::GlobalCluster
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :deletion_protection, [TrueClass, FalseClass],
         callbacks: {
           "deletion_protection is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: "The deletion protection setting for the new global database. The global database can't be deleted when deletion protection is enabled."

property :engine, String,
         callbacks: {
           "engine is not a String" => lambda { |v| v.is_a? String },
           "engineis not one of `aurora`, `aurora-mysql`, `aurora-postgresql`" => lambda { |v| %w{aurora aurora-mysql aurora-postgresql}.include? v },
         },
         description: <<~'DESCRIPTION'
           The name of the database engine to be used for this DB cluster. Valid Values: aurora (for MySQL 5.6-compatible Aurora), aurora-mysql (for MySQL 5.7-compatible Aurora).
      If you specify the SourceDBClusterIdentifier property, don't specify this property. The value is inherited from the cluster.
         DESCRIPTION

property :engine_version, String,
         callbacks: {
           "engine_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The version number of the database engine to use. If you specify the SourceDBClusterIdentifier property, don't specify this property. The value is inherited from the cluster."

property :global_cluster_identifier, String,
         callbacks: {
           "global_cluster_identifier is not a String" => lambda { |v| v.is_a? String },
           "global_cluster_identifier must match pattern ^[a-zA-Z]{1}(?:-?[a-zA-Z0-9]){0,62}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z]{1}(?:-?[a-zA-Z0-9]){0,62}$/") },
         },
         description: "The cluster identifier of the new global database cluster. This parameter is stored as a lowercase string."

property :source_db_cluster_identifier, String,
         description: "The Amazon Resource Name (ARN) to use as the primary cluster of the global database. This parameter is optional. This parameter is stored as a lowercase string."

property :storage_encrypted, [TrueClass, FalseClass],
         callbacks: {
           "storage_encrypted is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           The storage encryption setting for the new global database cluster.
      If you specify the SourceDBClusterIdentifier property, don't specify this property. The value is inherited from the cluster.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::RDS::GlobalCluster"
rest_api_document "/AWS::RDS::GlobalCluster"

rest_property_map({
  deletion_protection:          "DeletionProtection",
  engine:                       "Engine",
  engine_version:               "EngineVersion",
  global_cluster_identifier:    "GlobalClusterIdentifier",
  source_db_cluster_identifier: "SourceDBClusterIdentifier",
  storage_encrypted:            "StorageEncrypted",
})

rest_post_only_properties %i{
  engine engine_version global_cluster_identifier source_db_cluster_identifier storage_encrypted
}
