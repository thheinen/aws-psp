# Import API specifics
use "awscc_base"

resource_name :aws_verified_permissions_policy
provides :aws_verified_permissions_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::VerifiedPermissions::Policy Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :definition, Hash,
         required: true,
         description: ""

property :policy_store_id, String,
         callbacks: {
           "policy_store_id is not a String" => lambda { |v| v.is_a? String },
           "policy_store_id needs to be 1..200 characters" => lambda { |v| v.length >= 1 && v.length <= 200 },
           "policy_store_id must match pattern ^[a-zA-Z0-9-]*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9-]*$/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::VerifiedPermissions::Policy"
rest_api_document "/AWS::VerifiedPermissions::Policy"

rest_property_map({
  definition:      "Definition",
  policy_store_id: "PolicyStoreId",
})

rest_post_only_properties %i{
  policy_store_id
}
