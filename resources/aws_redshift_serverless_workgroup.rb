# Import API specifics
use "awscc_base"

resource_name :aws_redshift_serverless_workgroup
provides :aws_redshift_serverless_workgroup, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::RedshiftServerless::Workgroup Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :base_capacity, Integer,
         callbacks: {
           "base_capacity is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :config_parameters, Array,
         callbacks: {
           "config_parameters is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :enhanced_vpc_routing, [TrueClass, FalseClass],
         callbacks: {
           "enhanced_vpc_routing is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :namespace_name, String,
         callbacks: {
           "namespace_name is not a String" => lambda { |v| v.is_a? String },
           "namespace_name needs to be 3..64 characters" => lambda { |v| v.length >= 3 && v.length <= 64 },
           "namespace_name must match pattern ^(?=^[a-z0-9-]+$).{3,64}$" => lambda { |v| v =~ Regexp.new("/^(?=^[a-z0-9-]+$).{3,64}$/") },
         },
         description: ""

property :port, Integer,
         callbacks: {
           "port is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :publicly_accessible, [TrueClass, FalseClass],
         callbacks: {
           "publicly_accessible is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :security_group_ids, Array,
         callbacks: {
           "security_group_ids is not a Array" => lambda { |v| v.is_a? Array },
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

property :workgroup_name, String,
         required: true,
         callbacks: {
           "workgroup_name is not a String" => lambda { |v| v.is_a? String },
           "workgroup_name needs to be 3..64 characters" => lambda { |v| v.length >= 3 && v.length <= 64 },
           "workgroup_name must match pattern ^(?=^[a-z0-9-]+$).{3,64}$" => lambda { |v| v =~ Regexp.new("/^(?=^[a-z0-9-]+$).{3,64}$/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::RedshiftServerless::Workgroup"
rest_api_document "/AWS::RedshiftServerless::Workgroup"

rest_property_map({
  base_capacity:        "BaseCapacity",
  config_parameters:    "ConfigParameters",
  enhanced_vpc_routing: "EnhancedVpcRouting",
  namespace_name:       "NamespaceName",
  port:                 "Port",
  publicly_accessible:  "PubliclyAccessible",
  security_group_ids:   "SecurityGroupIds",
  subnet_ids:           "SubnetIds",
  tags:                 "Tags",
  workgroup_name:       "WorkgroupName",
})

rest_post_only_properties %i{
  namespace_name workgroup_name
}
