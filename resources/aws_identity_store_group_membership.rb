# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_identity_store_group_membership
provides :aws_identity_store_group_membership, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type Definition for AWS:IdentityStore::GroupMembership
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :group_id, String,
         required: true,
         callbacks: {
           "group_id is not a String" => lambda { |v| v.is_a? String },
           "group_id needs to be 1..47 characters" => lambda { |v| v.length >= 1 && v.length <= 47 },
           "group_id must match pattern ^([0-9a-f]{10}-|)[A-Fa-f0-9]{8}-[A-Fa-f0-9]{4}-[A-Fa-f0-9]{4}-[A-Fa-f0-9]{4}-[A-Fa-f0-9]{12}$" => lambda { |v| v =~ Regexp.new("/^([0-9a-f]{10}-|)[A-Fa-f0-9]{8}-[A-Fa-f0-9]{4}-[A-Fa-f0-9]{4}-[A-Fa-f0-9]{4}-[A-Fa-f0-9]{12}$/") },
         },
         description: <<~'DESCRIPTION'
           The unique identifier for a group in the identity store.
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

property :member_id, Hash,
         required: true,
         description: <<~'DESCRIPTION'
           An object containing the identifier of a group member.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IdentityStore::GroupMembership"
rest_api_document "/AWS::IdentityStore::GroupMembership"

rest_property_map({
  group_id:          "GroupId",
  identity_store_id: "IdentityStoreId",
  member_id:         "MemberId",
})

rest_post_only_properties %i{
  identity_store_id
}
