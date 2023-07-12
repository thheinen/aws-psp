# Import API specifics
use "awscc_base"

resource_name :aws_iam_group_policy
provides :aws_iam_group_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Schema for IAM Group Policy
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :group_name, String,
         required: true,
         callbacks: {
           "group_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the group to associate the policy with.
         DESCRIPTION

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

# API URLs and mappings
rest_api_collection "/AWS::IAM::GroupPolicy"
rest_api_document "/AWS::IAM::GroupPolicy"

rest_property_map({
  group_name:      "GroupName",
  policy_document: "PolicyDocument",
  policy_name:     "PolicyName",
})

rest_post_only_properties %i{
  group_name policy_name
}
