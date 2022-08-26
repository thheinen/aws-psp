# Import API specifics
use "awscc_base"

resource_name :aws_rds_db_proxy_endpoint
provides :aws_rds_db_proxy_endpoint, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::RDS::DBProxyEndpoint.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :db_proxy_endpoint_name, String,
         required: true,
         callbacks: {
           "db_proxy_endpoint_name is not a String" => lambda { |v| v.is_a? String },
           "db_proxy_endpoint_name must match pattern [0-z]*" => lambda { |v| v =~ Regexp.new("/[0-z]*/") },
         },
         description: "The identifier for the DB proxy endpoint. This name must be unique for all DB proxy endpoints owned by your AWS account in the specified AWS Region."

property :db_proxy_name, String,
         required: true,
         callbacks: {
           "db_proxy_name is not a String" => lambda { |v| v.is_a? String },
           "db_proxy_name must match pattern [0-z]*" => lambda { |v| v =~ Regexp.new("/[0-z]*/") },
         },
         description: "The identifier for the proxy. This name must be unique for all proxies owned by your AWS account in the specified AWS Region."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "An optional set of key-value pairs to associate arbitrary data of your choosing with the DB proxy endpoint."

property :target_role, String,
         callbacks: {
           "target_role is not a String" => lambda { |v| v.is_a? String },
           "target_roleis not one of `READ_WRITE`, `READ_ONLY`" => lambda { |v| %w{READ_WRITE READ_ONLY}.include? v },
         },
         description: "A value that indicates whether the DB proxy endpoint can be used for read/write or read-only operations."

property :vpc_security_group_ids, Array,
         callbacks: {
           "vpc_security_group_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "VPC security group IDs to associate with the new DB proxy endpoint."

property :vpc_subnet_ids, Array,
         required: true,
         callbacks: {
           "vpc_subnet_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "VPC subnet IDs to associate with the new DB proxy endpoint."

# API URLs and mappings
rest_api_collection "/AWS::RDS::DBProxyEndpoint"
rest_api_document "/AWS::RDS::DBProxyEndpoint"

rest_property_map({
  db_proxy_endpoint_name: "DBProxyEndpointName",
  db_proxy_name:          "DBProxyName",
  tags:                   "Tags",
  target_role:            "TargetRole",
  vpc_security_group_ids: "VpcSecurityGroupIds",
  vpc_subnet_ids:         "VpcSubnetIds",
})

rest_post_only_properties %i{
  db_proxy_endpoint_name db_proxy_name target_role vpc_subnet_ids
}
