# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_identity_store_group
provides :aws_identity_store_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::IdentityStore::Group
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
           "description must match pattern ^[\p{L}\p{M}\p{S}\p{N}\p{P}\t\n\r  　]+$" => lambda { |v| v =~ Regexp.new("/^[\p{L}\p{M}\p{S}\p{N}\p{P}\t\n\r  　]+$/") },
         },
         description: <<~'DESCRIPTION'
           A string containing the description of the group.
         DESCRIPTION

property :display_name, String,
         required: true,
         callbacks: {
           "display_name is not a String" => lambda { |v| v.is_a? String },
           "display_name needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
           "display_name must match pattern ^[\p{L}\p{M}\p{S}\p{N}\p{P}\t\n\r  ]+$" => lambda { |v| v =~ Regexp.new("/^[\p{L}\p{M}\p{S}\p{N}\p{P}\t\n\r  ]+$/") },
         },
         description: <<~'DESCRIPTION'
           A string containing the name of the group. This value is commonly displayed when the group is referenced.
         DESCRIPTION

property :identity_store_id, String,
         required: true,
         callbacks: {
           "identity_store_id is not a String" => lambda { |v| v.is_a? String },
           "identity_store_id needs to be 1..36 characters" => lambda { |v| v.length >= 1 && v.length <= 36 },
           "identity_store_id must match pattern ^d-[0-9a-f]{10}$|^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$" => lambda { |v| v =~ Regexp.new("/^d-[0-9a-f]{10}$|^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/") },
         },
         description: <<~'DESCRIPTION'
           The globally unique identifier for the identity store.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IdentityStore::Group"
rest_api_document "/AWS::IdentityStore::Group"

rest_property_map({
  description:       "Description",
  display_name:      "DisplayName",
  identity_store_id: "IdentityStoreId",
})

rest_post_only_properties %i{
  identity_store_id
}
