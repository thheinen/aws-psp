# Import API specifics
use "awscc_base"

resource_name :aws_xray_resource_policy
provides :aws_xray_resource_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  This schema provides construct and validation rules for AWS-XRay Resource Policy resource parameters.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :bypass_policy_lockout_check, [TrueClass, FalseClass],
         callbacks: {
           "bypass_policy_lockout_check is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A flag to indicate whether to bypass the resource policy lockout safety check
         DESCRIPTION

property :policy_document, String,
         required: true,
         callbacks: {
           "policy_document is not a String" => lambda { |v| v.is_a? String },
           "policy_document needs to be 1..5120 characters" => lambda { |v| v.length >= 1 && v.length <= 5120 },
         },
         description: <<~'DESCRIPTION'
           The resource policy document, which can be up to 5kb in size.
         DESCRIPTION

property :policy_name, String,
         required: true,
         callbacks: {
           "policy_name is not a String" => lambda { |v| v.is_a? String },
           "policy_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "policy_name must match pattern [\w+=,.@-]+" => lambda { |v| v =~ Regexp.new("/[\w+=,.@-]+/") },
         },
         description: <<~'DESCRIPTION'
           The name of the resource policy. Must be unique within a specific AWS account.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::XRay::ResourcePolicy"
rest_api_document "/AWS::XRay::ResourcePolicy"

rest_property_map({
  bypass_policy_lockout_check: "BypassPolicyLockoutCheck",
  policy_document:             "PolicyDocument",
  policy_name:                 "PolicyName",
})

rest_post_only_properties %i{
  policy_name
}
