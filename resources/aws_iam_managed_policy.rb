# Import API specifics
use "awscc_base"

resource_name :aws_iam_managed_policy
provides :aws_iam_managed_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::IAM::ManagedPolicy
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A friendly description of the policy.
         DESCRIPTION

property :groups, Array,
         callbacks: {
           "groups is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The name (friendly name, not ARN) of the group to attach the policy to.
         DESCRIPTION

property :managed_policy_name, String,
         callbacks: {
           "managed_policy_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The friendly name of the policy.
         DESCRIPTION

property :path, String,
         callbacks: {
           "path is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The path for the policy.
         DESCRIPTION

property :policy_document, [Hash, String],
         required: true,
         description: <<~'DESCRIPTION'
           The JSON policy document that you want to use as the content for the new policy.
         DESCRIPTION

property :roles, Array,
         callbacks: {
           "roles is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The name (friendly name, not ARN) of the role to attach the policy to.
         DESCRIPTION

property :users, Array,
         callbacks: {
           "users is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The name (friendly name, not ARN) of the IAM user to attach the policy to.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IAM::ManagedPolicy"
rest_api_document "/AWS::IAM::ManagedPolicy"

rest_property_map({
  description:         "Description",
  groups:              "Groups",
  managed_policy_name: "ManagedPolicyName",
  path:                "Path",
  policy_document:     "PolicyDocument",
  roles:               "Roles",
  users:               "Users",
})

rest_post_only_properties %i{
  description managed_policy_name path
}
