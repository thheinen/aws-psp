# Import API specifics
use "awscc_base"

resource_name :aws_iam_role
provides :aws_iam_role, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::IAM::Role
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :assume_role_policy_document, [Hash, String],
         required: true,
         description: "The trust policy that is associated with this role."

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: "A description of the role that you provide."

property :managed_policy_arns, Array,
         callbacks: {
           "managed_policy_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "A list of Amazon Resource Names (ARNs) of the IAM managed policies that you want to attach to the role. "

property :max_session_duration, Integer,
         callbacks: {
           "max_session_duration is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours. "

property :path, String,
         callbacks: {
           "path is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The path to the role."

property :permissions_boundary, String,
         callbacks: {
           "permissions_boundary is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The ARN of the policy used to set the permissions boundary for the role."

property :policies, Array,
         callbacks: {
           "policies is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "Adds or updates an inline policy document that is embedded in the specified IAM role. "

property :role_name, String,
         callbacks: {
           "role_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: "A name for the IAM role, up to 64 characters in length."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "A list of tags that are attached to the role."

# API URLs and mappings
rest_api_collection "/AWS::IAM::Role"
rest_api_document "/AWS::IAM::Role"

rest_property_map({
  assume_role_policy_document: "AssumeRolePolicyDocument",
  description:                 "Description",
  managed_policy_arns:         "ManagedPolicyArns",
  max_session_duration:        "MaxSessionDuration",
  path:                        "Path",
  permissions_boundary:        "PermissionsBoundary",
  policies:                    "Policies",
  role_name:                   "RoleName",
  tags:                        "Tags",
})

rest_post_only_properties %i{
  path role_name
}
