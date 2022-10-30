# Import API specifics
use "awscc_base"

resource_name :aws_msk_cluster
provides :aws_msk_cluster, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::MSK::Cluster
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :broker_node_group_info, Hash,
         required: true,
         callbacks: {
           "Subproperty `SecurityGroups` is not a Array" => lambda { |v| v[:SecurityGroups].is_a? Array },
           "Subproperty `BrokerAZDistribution` is not a String" => lambda { |v| v[:BrokerAZDistribution].is_a? String },
           "Subproperty `BrokerAZDistribution` needs to be 6..9 characters" => lambda { |v| v[:BrokerAZDistribution].length >= 6 && v[:BrokerAZDistribution].length <= 9 },
           "Subproperty `ClientSubnets` is not a Array" => lambda { |v| v[:ClientSubnets].is_a? Array },
           "Subproperty `InstanceType` is not a String" => lambda { |v| v[:InstanceType].is_a? String },
           "Subproperty `InstanceType` needs to be 5..32 characters" => lambda { |v| v[:InstanceType].length >= 5 && v[:InstanceType].length <= 32 },
         },
         description: ""

property :client_authentication, Hash,
         description: ""

property :cluster_name, String,
         required: true,
         callbacks: {
           "cluster_name is not a String" => lambda { |v| v.is_a? String },
           "cluster_name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
         },
         description: ""

property :configuration_info, Hash,
         callbacks: {
           "Subproperty `Revision` is not a Integer" => lambda { |v| v[:Revision].is_a? Integer },
           "Subproperty `Arn` is not a String" => lambda { |v| v[:Arn].is_a? String },
           "Subproperty `Arn`is not a valid ARN" => lambda { |v| v[:Arn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: ""

property :current_version, String,
         callbacks: {
           "current_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The current version of the MSK cluster
         DESCRIPTION

property :encryption_info, Hash,
         description: ""

property :enhanced_monitoring, String,
         callbacks: {
           "enhanced_monitoring is not a String" => lambda { |v| v.is_a? String },
           "enhanced_monitoring needs to be 7..23 characters" => lambda { |v| v.length >= 7 && v.length <= 23 },
           "enhanced_monitoringis not one of `DEFAULT`, `PER_BROKER`, `PER_TOPIC_PER_BROKER`, `PER_TOPIC_PER_PARTITION`" => lambda { |v| %w{DEFAULT PER_BROKER PER_TOPIC_PER_BROKER PER_TOPIC_PER_PARTITION}.include? v },
         },
         description: ""

property :kafka_version, String,
         required: true,
         callbacks: {
           "kafka_version is not a String" => lambda { |v| v.is_a? String },
           "kafka_version needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
         },
         description: ""

property :logging_info, Hash,
         description: ""

property :number_of_broker_nodes, Integer,
         required: true,
         callbacks: {
           "number_of_broker_nodes is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :open_monitoring, Hash,
         description: ""

property :storage_mode, String,
         callbacks: {
           "storage_mode is not a String" => lambda { |v| v.is_a? String },
           "storage_mode needs to be 5..6 characters" => lambda { |v| v.length >= 5 && v.length <= 6 },
           "storage_modeis not one of `LOCAL`, `TIERED`" => lambda { |v| %w{LOCAL TIERED}.include? v },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           A key-value pair to associate with a resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::MSK::Cluster"
rest_api_document "/AWS::MSK::Cluster"

rest_property_map({
  broker_node_group_info: "BrokerNodeGroupInfo",
  client_authentication:  "ClientAuthentication",
  cluster_name:           "ClusterName",
  configuration_info:     "ConfigurationInfo",
  current_version:        "CurrentVersion",
  encryption_info:        "EncryptionInfo",
  enhanced_monitoring:    "EnhancedMonitoring",
  kafka_version:          "KafkaVersion",
  logging_info:           "LoggingInfo",
  number_of_broker_nodes: "NumberOfBrokerNodes",
  open_monitoring:        "OpenMonitoring",
  storage_mode:           "StorageMode",
  tags:                   "Tags",
})

rest_post_only_properties %i{
  broker_node_group_info/broker_az_distribution broker_node_group_info/client_subnets broker_node_group_info/security_groups cluster_name encryption_info/encryption_at_rest encryption_info/encryption_in_transit/in_cluster tags
}
