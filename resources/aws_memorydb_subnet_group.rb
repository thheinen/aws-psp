# Import API specifics
use "awscc_base"

resource_name :aws_memorydb_subnet_group
provides :aws_memorydb_subnet_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::MemoryDB::SubnetGroup resource creates an Amazon MemoryDB Subnet Group.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: "An optional description of the subnet group."

property :subnet_group_name, String,
         required: true,
         callbacks: {
           "subnet_group_name is not a String" => lambda { |v| v.is_a? String },
           "subnet_group_name must match pattern [a-z][a-z0-9\-]*" => lambda { |v| v =~ Regexp.new("/[a-z][a-z0-9\-]*/") },
         },
         description: "The name of the subnet group. This value must be unique as it also serves as the subnet group identifier."

property :subnet_ids, Array,
         required: true,
         callbacks: {
           "subnet_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "A list of VPC subnet IDs for the subnet group."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "An array of key-value pairs to apply to this subnet group."

# API URLs and mappings
rest_api_collection "/AWS::MemoryDB::SubnetGroup"
rest_api_document "/AWS::MemoryDB::SubnetGroup"

rest_property_map({
  description:       "Description",
  subnet_group_name: "SubnetGroupName",
  subnet_ids:        "SubnetIds",
  tags:              "Tags",
})

rest_post_only_properties %i{
  subnet_group_name
}
