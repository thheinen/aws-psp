# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_rds_db_proxy
provides :aws_rds_db_proxy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::RDS::DBProxy
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :auth, Array,
         required: true,
         callbacks: {
           "auth is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The authorization mechanism that the proxy uses.
         DESCRIPTION

property :db_proxy_name, String,
         required: true,
         callbacks: {
           "db_proxy_name is not a String" => lambda { |v| v.is_a? String },
           "db_proxy_name must match pattern [0-z]*" => lambda { |v| v =~ Regexp.new("/[0-z]*/") },
         },
         description: <<~'DESCRIPTION'
           The identifier for the proxy. This name must be unique for all proxies owned by your AWS account in the specified AWS Region.
         DESCRIPTION

property :debug_logging, [TrueClass, FalseClass],
         callbacks: {
           "debug_logging is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Whether the proxy includes detailed information about SQL statements in its logs.
         DESCRIPTION

property :engine_family, String,
         required: true,
         callbacks: {
           "engine_family is not a String" => lambda { |v| v.is_a? String },
           "engine_familyis not one of `MYSQL`, `POSTGRESQL`" => lambda { |v| %w{MYSQL POSTGRESQL}.include? v },
         },
         description: <<~'DESCRIPTION'
           The kinds of databases that the proxy can connect to.
         DESCRIPTION

property :idle_client_timeout, Integer,
         callbacks: {
           "idle_client_timeout is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of seconds that a connection to the proxy can be inactive before the proxy disconnects it.
         DESCRIPTION

property :require_tls, [TrueClass, FalseClass],
         callbacks: {
           "require_tls is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A Boolean parameter that specifies whether Transport Layer Security (TLS) encryption is required for connections to the proxy.
         DESCRIPTION

property :role_arn, String,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the IAM role that the proxy uses to access secrets in AWS Secrets Manager.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An optional set of key-value pairs to associate arbitrary data of your choosing with the proxy.
         DESCRIPTION

property :vpc_security_group_ids, Array,
         callbacks: {
           "vpc_security_group_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           VPC security group IDs to associate with the new proxy.
         DESCRIPTION

property :vpc_subnet_ids, Array,
         required: true,
         callbacks: {
           "vpc_subnet_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           VPC subnet IDs to associate with the new proxy.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::RDS::DBProxy"
rest_api_document "/AWS::RDS::DBProxy"

rest_property_map({
  auth:                   "Auth",
  db_proxy_name:          "DBProxyName",
  debug_logging:          "DebugLogging",
  engine_family:          "EngineFamily",
  idle_client_timeout:    "IdleClientTimeout",
  require_tls:            "RequireTLS",
  role_arn:               "RoleArn",
  tags:                   "Tags",
  vpc_security_group_ids: "VpcSecurityGroupIds",
  vpc_subnet_ids:         "VpcSubnetIds",
})

rest_post_only_properties %i{
  db_proxy_name engine_family vpc_subnet_ids
}
