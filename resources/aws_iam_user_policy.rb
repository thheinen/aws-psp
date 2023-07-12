# Import API specifics
use "awscc_base"

resource_name :aws_iam_user_policy
provides :aws_iam_user_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Schema for IAM User Policy
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
           The name of the policy document.
         DESCRIPTION

property :user_name, String,
         required: true,
         callbacks: {
           "user_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the user to associate the policy with.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IAM::UserPolicy"
rest_api_document "/AWS::IAM::UserPolicy"

rest_property_map({
  policy_document: "PolicyDocument",
  policy_name:     "PolicyName",
  user_name:       "UserName",
})

rest_post_only_properties %i{
  policy_name user_name
}
