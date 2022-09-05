# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_memorydb_user
provides :aws_memorydb_user, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::MemoryDB::User
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :access_string, String,
         required: true,
         callbacks: {
           "access_string is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Access permissions string used for this user account.
         DESCRIPTION

property :authentication_mode, Hash,
         required: true,
         callbacks: {
           "Subproperty `Type` is not a String" => lambda { |v| v[:Type].is_a? String },
           "Subproperty `Type`is not one of `password`" => lambda { |v| %w{password}.include? v[:Type] },
           "Subproperty `Passwords` is not a Array" => lambda { |v| v[:Passwords].is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this user.
         DESCRIPTION

property :user_name, String,
         required: true,
         callbacks: {
           "user_name is not a String" => lambda { |v| v.is_a? String },
           "user_name must match pattern [a-z][a-z0-9\\-]*" => lambda { |v| v =~ Regexp.new("/[a-z][a-z0-9\\-]*/") },
         },
         description: <<~'DESCRIPTION'
           The name of the user.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::MemoryDB::User"
rest_api_document "/AWS::MemoryDB::User"

rest_property_map({
  access_string:       "AccessString",
  authentication_mode: "AuthenticationMode",
  tags:                "Tags",
  user_name:           "UserName",
})

rest_post_only_properties %i{
  user_name
}
