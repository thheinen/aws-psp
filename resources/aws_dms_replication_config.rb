# Import API specifics
use "awscc_base"

resource_name :aws_dms_replication_config
provides :aws_dms_replication_config, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  A replication configuration that you later provide to configure and start a AWS DMS Serverless replication
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :compute_config, Hash,
         callbacks: {
           "Subproperty `AvailabilityZone` is not a String" => lambda { |v| v[:AvailabilityZone].is_a? String },
           "Subproperty `DnsNameServers` is not a String" => lambda { |v| v[:DnsNameServers].is_a? String },
           "Subproperty `KmsKeyId` is not a String" => lambda { |v| v[:KmsKeyId].is_a? String },
           "Subproperty `MaxCapacityUnits` is not a Integer" => lambda { |v| v[:MaxCapacityUnits].is_a? Integer },
           "Subproperty `MinCapacityUnits` is not a Integer" => lambda { |v| v[:MinCapacityUnits].is_a? Integer },
           "Subproperty `MultiAZ` is not a Boolean" => lambda { |v| v[:MultiAZ].is_a? Boolean },
           "Subproperty `PreferredMaintenanceWindow` is not a String" => lambda { |v| v[:PreferredMaintenanceWindow].is_a? String },
           "Subproperty `ReplicationSubnetGroupId` is not a String" => lambda { |v| v[:ReplicationSubnetGroupId].is_a? String },
           "Subproperty `VpcSecurityGroupIds` is not a Array" => lambda { |v| v[:VpcSecurityGroupIds].is_a? Array },
         },
         description: ""

property :replication_config_arn, String,
         callbacks: {
           "replication_config_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the Replication Config
         DESCRIPTION

property :replication_config_identifier, String,
         callbacks: {
           "replication_config_identifier is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A unique identifier of replication configuration
         DESCRIPTION

property :replication_settings, Hash,
         callbacks: {
           "replication_settings is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           JSON settings for Servereless replications that are provisioned using this replication configuration
         DESCRIPTION

property :replication_type, String,
         callbacks: {
           "replication_type is not a String" => lambda { |v| v.is_a? String },
           "replication_typeis not one of `full-load`, `full-load-and-cdc`, `cdc`" => lambda { |v| %w{full-load full-load-and-cdc cdc}.include? v },
         },
         description: <<~'DESCRIPTION'
           The type of AWS DMS Serverless replication to provision using this replication configuration
         DESCRIPTION

property :resource_identifier, String,
         callbacks: {
           "resource_identifier is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A unique value or name that you get set for a given resource that can be used to construct an Amazon Resource Name (ARN) for that resource
         DESCRIPTION

property :source_endpoint_arn, String,
         callbacks: {
           "source_endpoint_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the source endpoint for this AWS DMS Serverless replication configuration
         DESCRIPTION

property :supplemental_settings, Hash,
         callbacks: {
           "supplemental_settings is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           JSON settings for specifying supplemental data
         DESCRIPTION

property :table_mappings, Hash,
         callbacks: {
           "table_mappings is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           JSON table mappings for AWS DMS Serverless replications that are provisioned using this replication configuration
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           <p>Contains a map of the key-value pairs for the resource tag or tags assigned to the dataset.</p>
         DESCRIPTION

property :target_endpoint_arn, String,
         callbacks: {
           "target_endpoint_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the target endpoint for this AWS DMS Serverless replication configuration
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::DMS::ReplicationConfig"
rest_api_document "/AWS::DMS::ReplicationConfig"

rest_property_map({
  compute_config:                "ComputeConfig",
  replication_config_arn:        "ReplicationConfigArn",
  replication_config_identifier: "ReplicationConfigIdentifier",
  replication_settings:          "ReplicationSettings",
  replication_type:              "ReplicationType",
  resource_identifier:           "ResourceIdentifier",
  source_endpoint_arn:           "SourceEndpointArn",
  supplemental_settings:         "SupplementalSettings",
  table_mappings:                "TableMappings",
  tags:                          "Tags",
  target_endpoint_arn:           "TargetEndpointArn",
})

