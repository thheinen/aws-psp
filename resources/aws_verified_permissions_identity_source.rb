# Import API specifics
use "awscc_base"

resource_name :aws_verified_permissions_identity_source
provides :aws_verified_permissions_identity_source, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::VerifiedPermissions::IdentitySource Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :configuration, Hash,
         required: true,
         description: ""

property :policy_store_id, String,
         callbacks: {
           "policy_store_id is not a String" => lambda { |v| v.is_a? String },
           "policy_store_id needs to be 1..200 characters" => lambda { |v| v.length >= 1 && v.length <= 200 },
           "policy_store_id must match pattern ^[a-zA-Z0-9-]*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9-]*$/") },
         },
         description: ""

property :principal_entity_type, String,
         callbacks: {
           "principal_entity_type is not a String" => lambda { |v| v.is_a? String },
           "principal_entity_type needs to be 1..200 characters" => lambda { |v| v.length >= 1 && v.length <= 200 },
           "principal_entity_type must match pattern ^.*$" => lambda { |v| v =~ Regexp.new("/^.*$/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::VerifiedPermissions::IdentitySource"
rest_api_document "/AWS::VerifiedPermissions::IdentitySource"

rest_property_map({
  configuration:         "Configuration",
  policy_store_id:       "PolicyStoreId",
  principal_entity_type: "PrincipalEntityType",
})

rest_post_only_properties %i{
  policy_store_id
}
