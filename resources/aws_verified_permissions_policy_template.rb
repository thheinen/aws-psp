# Import API specifics
use "awscc_base"

resource_name :aws_verified_permissions_policy_template
provides :aws_verified_permissions_policy_template, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::VerifiedPermissions::PolicyTemplate Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..150 characters" => lambda { |v| v.length >= 0 && v.length <= 150 },
         },
         description: ""

property :policy_store_id, String,
         callbacks: {
           "policy_store_id is not a String" => lambda { |v| v.is_a? String },
           "policy_store_id needs to be 1..200 characters" => lambda { |v| v.length >= 1 && v.length <= 200 },
           "policy_store_id must match pattern ^[a-zA-Z0-9-]*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9-]*$/") },
         },
         description: ""

property :statement, String,
         required: true,
         callbacks: {
           "statement is not a String" => lambda { |v| v.is_a? String },
           "statement needs to be 1..10000 characters" => lambda { |v| v.length >= 1 && v.length <= 10000 },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::VerifiedPermissions::PolicyTemplate"
rest_api_document "/AWS::VerifiedPermissions::PolicyTemplate"

rest_property_map({
  description:     "Description",
  policy_store_id: "PolicyStoreId",
  statement:       "Statement",
})

rest_post_only_properties %i{
  policy_store_id
}
