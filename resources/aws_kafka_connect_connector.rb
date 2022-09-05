# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_kafka_connect_connector
provides :aws_kafka_connect_connector, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::KafkaConnect::Connector
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :capacity, Hash,
         required: true,
         description: ""

property :connector_configuration, Hash,
         required: true,
         callbacks: {
           "connector_configuration is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           The configuration for the connector.
         DESCRIPTION

property :connector_description, String,
         callbacks: {
           "connector_description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A summary description of the connector.
         DESCRIPTION

property :connector_name, String,
         required: true,
         callbacks: {
           "connector_name is not a String" => lambda { |v| v.is_a? String },
           "connector_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
         },
         description: <<~'DESCRIPTION'
           The name of the connector.
         DESCRIPTION

property :kafka_cluster, Hash,
         required: true,
         description: ""

property :kafka_cluster_client_authentication, Hash,
         required: true,
         description: ""

property :kafka_cluster_encryption_in_transit, Hash,
         required: true,
         description: ""

property :kafka_connect_version, String,
         required: true,
         callbacks: {
           "kafka_connect_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The version of Kafka Connect. It has to be compatible with both the Kafka cluster's version and the plugins.
         DESCRIPTION

property :log_delivery, Hash,
         description: ""

property :plugins, Array,
         required: true,
         callbacks: {
           "plugins is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           List of plugins to use with the connector.
         DESCRIPTION

property :service_execution_role_arn, String,
         required: true,
         callbacks: {
           "service_execution_role_arn is not a String" => lambda { |v| v.is_a? String },
           "service_execution_role_arn must match pattern arn:(aws|aws-us-gov|aws-cn):iam:.*" => lambda { |v| v =~ Regexp.new("/arn:(aws|aws-us-gov|aws-cn):iam:.*/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the IAM role used by the connector to access Amazon S3 objects and other external resources.
         DESCRIPTION

property :worker_configuration, Hash,
         callbacks: {
           "Subproperty `Revision` is not a Integer" => lambda { |v| v[:Revision].is_a? Integer },
           "Subproperty `WorkerConfigurationArn` is not a String" => lambda { |v| v[:WorkerConfigurationArn].is_a? String },
           "Subproperty `WorkerConfigurationArn` must match pattern arn:(aws|aws-us-gov|aws-cn):kafkaconnect:.*" => lambda { |v| v[:WorkerConfigurationArn] =~ Regexp.new("/arn:(aws|aws-us-gov|aws-cn):kafkaconnect:.*/") },
           "Subproperty `WorkerConfigurationArn`is not a valid ARN" => lambda { |v| v[:WorkerConfigurationArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::KafkaConnect::Connector"
rest_api_document "/AWS::KafkaConnect::Connector"

rest_property_map({
  capacity:                            "Capacity",
  connector_configuration:             "ConnectorConfiguration",
  connector_description:               "ConnectorDescription",
  connector_name:                      "ConnectorName",
  kafka_cluster:                       "KafkaCluster",
  kafka_cluster_client_authentication: "KafkaClusterClientAuthentication",
  kafka_cluster_encryption_in_transit: "KafkaClusterEncryptionInTransit",
  kafka_connect_version:               "KafkaConnectVersion",
  log_delivery:                        "LogDelivery",
  plugins:                             "Plugins",
  service_execution_role_arn:          "ServiceExecutionRoleArn",
  worker_configuration:                "WorkerConfiguration",
})

rest_post_only_properties %i{
  connector_configuration connector_description connector_name kafka_cluster kafka_cluster_client_authentication kafka_cluster_encryption_in_transit kafka_connect_version log_delivery plugins service_execution_role_arn worker_configuration
}
