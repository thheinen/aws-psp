# Import API specifics
use "awscc_base"

resource_name :aws_iam_role_policy
provides :aws_iam_role_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Schema for IAM Role Policy
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :policy_document, Hash,
         callbacks: {
           "policy_document is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           The policy document.
         DESCRIPTION

property :policy_name, String,
         required: true,
         callbacks: {
           "policy_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The friendly name (not ARN) identifying the policy.
         DESCRIPTION

property :role_name, String,
         required: true,
         callbacks: {
           "role_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the policy document.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IAM::RolePolicy"
rest_api_document "/AWS::IAM::RolePolicy"

rest_property_map({
  policy_document: "PolicyDocument",
  policy_name:     "PolicyName",
  role_name:       "RoleName",
})

rest_post_only_properties %i{
  policy_name role_name
}
