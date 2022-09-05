# Import API specifics
use "awscc_base"

resource_name :aws_rds_db_subnet_group
provides :aws_rds_db_subnet_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::RDS::DBSubnetGroup resource creates a database subnet group. Subnet groups must contain at least two subnets in two different Availability Zones in the same region.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :db_subnet_group_description, String,
         required: true,
         callbacks: {
           "db_subnet_group_description is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :db_subnet_group_name, String,
         callbacks: {
           "db_subnet_group_name is not a String" => lambda { |v| v.is_a? String },
           "db_subnet_group_name must match pattern ^(?!default$)[a-zA-Z]{1}[a-zA-Z0-9-_\.\s]{0,254}$" => lambda { |v| v =~ Regexp.new("/^(?!default$)[a-zA-Z]{1}[a-zA-Z0-9-_\.\s]{0,254}$/") },
         },
         description: ""

property :subnet_ids, Array,
         required: true,
         callbacks: {
           "subnet_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::RDS::DBSubnetGroup"
rest_api_document "/AWS::RDS::DBSubnetGroup"

rest_property_map({
  db_subnet_group_description: "DBSubnetGroupDescription",
  db_subnet_group_name:        "DBSubnetGroupName",
  subnet_ids:                  "SubnetIds",
  tags:                        "Tags",
})

rest_post_only_properties %i{
  db_subnet_group_name
}
