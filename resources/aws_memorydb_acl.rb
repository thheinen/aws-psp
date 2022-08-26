# Import API specifics
use "awscc_base"

resource_name :aws_memorydb_acl
provides :aws_memorydb_acl, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::MemoryDB::ACL
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :acl_name, String,
         required: true,
         callbacks: {
           "acl_name is not a String" => lambda { |v| v.is_a? String },
           "acl_name must match pattern [a-z][a-z0-9\\-]*" => lambda { |v| v =~ Regexp.new("/[a-z][a-z0-9\\-]*/") },
         },
         description: "The name of the acl."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "An array of key-value pairs to apply to this cluster."

property :user_names, Array,
         callbacks: {
           "user_names is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "List of users associated to this acl."

# API URLs and mappings
rest_api_collection "/AWS::MemoryDB::ACL"
rest_api_document "/AWS::MemoryDB::ACL"

rest_property_map({
  acl_name:   "ACLName",
  tags:       "Tags",
  user_names: "UserNames",
})

rest_post_only_properties %i{
  acl_name
}
