# Import API specifics
use "awscc_base"

resource_name :aws_logs_account_policy
provides :aws_logs_account_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::Logs::AccountPolicy resource specifies a CloudWatch Logs AccountPolicy.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :policy_document, String,
         required: true,
         callbacks: {
           "policy_document is not a String" => lambda { |v| v.is_a? String },
           "policy_document needs to be 1..30720 characters" => lambda { |v| v.length >= 1 && v.length <= 30720 },
         },
         description: <<~'DESCRIPTION'
           The body of the policy document you want to use for this topic.
            You can only add one policy per PolicyType.
            The policy must be in JSON string format.
            Length Constraints: Maximum length of 30720
         DESCRIPTION

property :policy_name, String,
         required: true,
         callbacks: {
           "policy_name is not a String" => lambda { |v| v.is_a? String },
           "policy_name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "policy_name must match pattern ^[^:*]{1,256}$" => lambda { |v| v =~ Regexp.new("/^[^:*]{1,256}$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the account policy
         DESCRIPTION

property :policy_type, String,
         required: true,
         callbacks: {
           "policy_type is not a String" => lambda { |v| v.is_a? String },
           "policy_typeis not one of `DATA_PROTECTION_POLICY`" => lambda { |v| %w{DATA_PROTECTION_POLICY}.include? v },
         },
         description: <<~'DESCRIPTION'
           Type of the policy.
         DESCRIPTION

property :scope, String,
         callbacks: {
           "scope is not a String" => lambda { |v| v.is_a? String },
           "scopeis not one of `ALL`" => lambda { |v| %w{ALL}.include? v },
         },
         description: <<~'DESCRIPTION'
           Scope for policy application
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Logs::AccountPolicy"
rest_api_document "/AWS::Logs::AccountPolicy"

rest_property_map({
  policy_document: "PolicyDocument",
  policy_name:     "PolicyName",
  policy_type:     "PolicyType",
  scope:           "Scope",
})

rest_post_only_properties %i{
  policy_name policy_type
}
