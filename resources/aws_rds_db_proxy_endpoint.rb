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
         description: <<~'DESCRIPTION'
           The identifier for the DB proxy endpoint. This name must be unique for all DB proxy endpoints owned by your AWS account in the specified AWS Region.
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

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An optional set of key-value pairs to associate arbitrary data of your choosing with the DB proxy endpoint.
         DESCRIPTION

property :vpc_security_group_ids, Array,
         callbacks: {
           "vpc_security_group_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           VPC security group IDs to associate with the new DB proxy endpoint.
         DESCRIPTION

property :vpc_subnet_ids, Array,
         required: true,
         callbacks: {
           "vpc_subnet_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           VPC subnet IDs to associate with the new DB proxy endpoint.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::RDS::DBProxyEndpoint"
rest_api_document "/AWS::RDS::DBProxyEndpoint"

rest_property_map({
  db_proxy_endpoint_name: "DBProxyEndpointName",
  db_proxy_name:          "DBProxyName",
  tags:                   "Tags",
  vpc_security_group_ids: "VpcSecurityGroupIds",
  vpc_subnet_ids:         "VpcSubnetIds",
})

rest_post_only_properties %i{
  db_proxy_endpoint_name db_proxy_name vpc_subnet_ids
}
