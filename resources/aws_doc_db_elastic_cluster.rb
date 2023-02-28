# Import API specifics
use "awscc_base"

resource_name :aws_doc_db_elastic_cluster
provides :aws_doc_db_elastic_cluster, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::DocDBElastic::Cluster Amazon DocumentDB (with MongoDB compatibility) Elastic Scale resource describes a Cluster
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :admin_user_name, String,
         required: true,
         callbacks: {
           "admin_user_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :admin_user_password, String,
         callbacks: {
           "admin_user_password is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :auth_type, String,
         required: true,
         callbacks: {
           "auth_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :cluster_name, String,
         required: true,
         callbacks: {
           "cluster_name is not a String" => lambda { |v| v.is_a? String },
           "cluster_name needs to be 1..50 characters" => lambda { |v| v.length >= 1 && v.length <= 50 },
           "cluster_name must match pattern [a-zA-z][a-zA-Z0-9]*(-[a-zA-Z0-9]+)*" => lambda { |v| v =~ Regexp.new("/[a-zA-z][a-zA-Z0-9]*(-[a-zA-Z0-9]+)*/") },
         },
         description: ""

property :kms_key_id, String,
         callbacks: {
           "kms_key_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :preferred_maintenance_window, String,
         callbacks: {
           "preferred_maintenance_window is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :shard_capacity, Integer,
         required: true,
         callbacks: {
           "shard_capacity is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :shard_count, Integer,
         required: true,
         callbacks: {
           "shard_count is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :subnet_ids, Array,
         callbacks: {
           "subnet_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :vpc_security_group_ids, Array,
         callbacks: {
           "vpc_security_group_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::DocDBElastic::Cluster"
rest_api_document "/AWS::DocDBElastic::Cluster"

rest_property_map({
  admin_user_name:              "AdminUserName",
  admin_user_password:          "AdminUserPassword",
  auth_type:                    "AuthType",
  cluster_name:                 "ClusterName",
  kms_key_id:                   "KmsKeyId",
  preferred_maintenance_window: "PreferredMaintenanceWindow",
  shard_capacity:               "ShardCapacity",
  shard_count:                  "ShardCount",
  subnet_ids:                   "SubnetIds",
  tags:                         "Tags",
  vpc_security_group_ids:       "VpcSecurityGroupIds",
})

rest_post_only_properties %i{
  admin_user_name auth_type cluster_name kms_key_id
}
