# Import API specifics
use "awscc_base"

resource_name :aws_elasticache_user
provides :aws_elasticache_user, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ElastiCache::User
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :access_string, String,
         callbacks: {
           "access_string is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Access permissions string used for this user account.
         DESCRIPTION

property :authentication_mode, Hash,
         callbacks: {
           "Subproperty `Type` is not a String" => lambda { |v| v[:Type].is_a? String },
           "Subproperty `Type`is not one of `password`, `no-password-required`, `iam`" => lambda { |v| %w{password no-password-required iam}.include? v[:Type] },
           "Subproperty `Passwords` is not a Array" => lambda { |v| v[:Passwords].is_a? Array },
         },
         description: ""

property :engine, String,
         required: true,
         callbacks: {
           "engine is not a String" => lambda { |v| v.is_a? String },
           "engineis not one of `redis`" => lambda { |v| %w{redis}.include? v },
         },
         description: <<~'DESCRIPTION'
           Must be redis.
         DESCRIPTION

property :no_password_required, [TrueClass, FalseClass],
         callbacks: {
           "no_password_required is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Indicates a password is not required for this user account.
         DESCRIPTION

property :passwords, Array,
         callbacks: {
           "passwords is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Passwords used for this user account. You can create up to two passwords for each user.
         DESCRIPTION

property :user_id, String,
         required: true,
         callbacks: {
           "user_id is not a String" => lambda { |v| v.is_a? String },
           "user_id must match pattern [a-z][a-z0-9\\-]*" => lambda { |v| v =~ Regexp.new("/[a-z][a-z0-9\\-]*/") },
         },
         description: <<~'DESCRIPTION'
           The ID of the user.
         DESCRIPTION

property :user_name, String,
         required: true,
         callbacks: {
           "user_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The username of the user.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ElastiCache::User"
rest_api_document "/AWS::ElastiCache::User"

rest_property_map({
  access_string:        "AccessString",
  authentication_mode:  "AuthenticationMode",
  engine:               "Engine",
  no_password_required: "NoPasswordRequired",
  passwords:            "Passwords",
  user_id:              "UserId",
  user_name:            "UserName",
})

rest_post_only_properties %i{
  engine user_id user_name
}
