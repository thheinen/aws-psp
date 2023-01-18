# Import API specifics
use "awscc_base"

resource_name :aws_elasticache_subnet_group
provides :aws_elasticache_subnet_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ElastiCache::SubnetGroup
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :cache_subnet_group_name, String,
         callbacks: {
           "cache_subnet_group_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name for the cache subnet group. This value is stored as a lowercase string.
         DESCRIPTION

property :description, String,
         required: true,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The description for the cache subnet group.
         DESCRIPTION

property :subnet_ids, Array,
         required: true,
         callbacks: {
           "subnet_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The EC2 subnet IDs for the cache subnet group.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::ElastiCache::SubnetGroup"
rest_api_document "/AWS::ElastiCache::SubnetGroup"

rest_property_map({
  cache_subnet_group_name: "CacheSubnetGroupName",
  description:             "Description",
  subnet_ids:              "SubnetIds",
  tags:                    "Tags",
})

rest_post_only_properties %i{
  cache_subnet_group_name
}
