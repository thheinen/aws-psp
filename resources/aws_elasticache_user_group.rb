# Import API specifics
use "awscc_base"

resource_name :aws_elasticache_user_group
provides :aws_elasticache_user_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ElastiCache::UserGroup
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :engine, String,
         required: true,
         callbacks: {
           "engine is not a String" => lambda { |v| v.is_a? String },
           "engineis not one of `redis`" => lambda { |v| %w{redis}.include? v },
         },
         description: <<~'DESCRIPTION'
           Must be redis.
         DESCRIPTION

property :user_group_id, String,
         required: true,
         callbacks: {
           "user_group_id is not a String" => lambda { |v| v.is_a? String },
           "user_group_id must match pattern [a-z][a-z0-9\\-]*" => lambda { |v| v =~ Regexp.new("/[a-z][a-z0-9\\-]*/") },
         },
         description: <<~'DESCRIPTION'
           The ID of the user group.
         DESCRIPTION

property :user_ids, Array,
         callbacks: {
           "user_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           List of users associated to this user group.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ElastiCache::UserGroup"
rest_api_document "/AWS::ElastiCache::UserGroup"

rest_property_map({
  engine:        "Engine",
  user_group_id: "UserGroupId",
  user_ids:      "UserIds",
})

rest_post_only_properties %i{
  engine user_group_id
}
