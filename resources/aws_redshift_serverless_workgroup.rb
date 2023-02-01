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

property :workgroup, Hash,
         callbacks: {
           "Subproperty `WorkgroupId` is not a String" => lambda { |v| v[:WorkgroupId].is_a? String },
           "Subproperty `WorkgroupArn` is not a String" => lambda { |v| v[:WorkgroupArn].is_a? String },
           "Subproperty `WorkgroupArn`is not a valid ARN" => lambda { |v| v[:WorkgroupArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `WorkgroupName` is not a String" => lambda { |v| v[:WorkgroupName].is_a? String },
           "Subproperty `WorkgroupName` needs to be 3..64 characters" => lambda { |v| v[:WorkgroupName].length >= 3 && v[:WorkgroupName].length <= 64 },
           "Subproperty `WorkgroupName` must match pattern ^[a-z0-9-]*$" => lambda { |v| v[:WorkgroupName] =~ Regexp.new("/^[a-z0-9-]*$/") },
           "Subproperty `NamespaceName` is not a String" => lambda { |v| v[:NamespaceName].is_a? String },
           "Subproperty `NamespaceName` needs to be 3..64 characters" => lambda { |v| v[:NamespaceName].length >= 3 && v[:NamespaceName].length <= 64 },
           "Subproperty `NamespaceName` must match pattern ^[a-z0-9-]+$" => lambda { |v| v[:NamespaceName] =~ Regexp.new("/^[a-z0-9-]+$/") },
           "Subproperty `BaseCapacity` is not a Integer" => lambda { |v| v[:BaseCapacity].is_a? Integer },
           "Subproperty `EnhancedVpcRouting` is not a Boolean" => lambda { |v| v[:EnhancedVpcRouting].is_a? Boolean },
           "Subproperty `ConfigParameters` is not a Array" => lambda { |v| v[:ConfigParameters].is_a? Array },
           "Subproperty `SecurityGroupIds` is not a Array" => lambda { |v| v[:SecurityGroupIds].is_a? Array },
           "Subproperty `SubnetIds` is not a Array" => lambda { |v| v[:SubnetIds].is_a? Array },
           "Subproperty `PubliclyAccessible` is not a Boolean" => lambda { |v| v[:PubliclyAccessible].is_a? Boolean },
           "Subproperty `CreationDate` is not a String" => lambda { |v| v[:CreationDate].is_a? String },
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
  workgroup:            "Workgroup",
  workgroup_name:       "WorkgroupName",
})

rest_post_only_properties %i{
  namespace_name workgroup_name
}
