# Import API specifics
use "awscc_base"

resource_name :aws_rds_db_proxy_target_group
provides :aws_rds_db_proxy_target_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::RDS::DBProxyTargetGroup
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :connection_pool_configuration_info, Hash,
         callbacks: {
           "Subproperty `MaxConnectionsPercent` is not a Integer" => lambda { |v| v[:MaxConnectionsPercent].is_a? Integer },
           "Subproperty `MaxIdleConnectionsPercent` is not a Integer" => lambda { |v| v[:MaxIdleConnectionsPercent].is_a? Integer },
           "Subproperty `ConnectionBorrowTimeout` is not a Integer" => lambda { |v| v[:ConnectionBorrowTimeout].is_a? Integer },
           "Subproperty `SessionPinningFilters` is not a Array" => lambda { |v| v[:SessionPinningFilters].is_a? Array },
           "Subproperty `InitQuery` is not a String" => lambda { |v| v[:InitQuery].is_a? String },
         },
         description: ""

property :db_cluster_identifiers, Array,
         callbacks: {
           "db_cluster_identifiers is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :db_instance_identifiers, Array,
         callbacks: {
           "db_instance_identifiers is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :db_proxy_name, String,
         required: true,
         callbacks: {
           "db_proxy_name is not a String" => lambda { |v| v.is_a? String },
           "db_proxy_name must match pattern [A-z][0-z]*" => lambda { |v| v =~ Regexp.new("/[A-z][0-z]*/") },
         },
         description: "The identifier for the proxy."

property :target_group_name, String,
         required: true,
         callbacks: {
           "target_group_name is not a String" => lambda { |v| v.is_a? String },
           "target_group_nameis not one of `default`" => lambda { |v| %w{default}.include? v },
         },
         description: "The identifier for the DBProxyTargetGroup"

# API URLs and mappings
rest_api_collection "/AWS::RDS::DBProxyTargetGroup"
rest_api_document "/AWS::RDS::DBProxyTargetGroup"

rest_property_map({
  connection_pool_configuration_info: "ConnectionPoolConfigurationInfo",
  db_cluster_identifiers:             "DBClusterIdentifiers",
  db_instance_identifiers:            "DBInstanceIdentifiers",
  db_proxy_name:                      "DBProxyName",
  target_group_name:                  "TargetGroupName",
})

rest_post_only_properties %i{
  db_proxy_name target_group_name
}
