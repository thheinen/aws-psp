# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_logs_resource_policy
provides :aws_logs_resource_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The resource schema for AWSLogs ResourcePolicy
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :policy_document, String,
         required: true,
         callbacks: {
           "policy_document is not a String" => lambda { |v| v.is_a? String },
           "policy_document needs to be 1..5120 characters" => lambda { |v| v.length >= 1 && v.length <= 5120 },
           "policy_document must match pattern [\u0009\u000A\u000D\u0020-\u00FF]+" => lambda { |v| v =~ Regexp.new("/[\u0009\u000A\u000D\u0020-\u00FF]+/") },
         },
         description: <<~'DESCRIPTION'
           The policy document
         DESCRIPTION

property :policy_name, String,
         required: true,
         callbacks: {
           "policy_name is not a String" => lambda { |v| v.is_a? String },
           "policy_name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "policy_name must match pattern ^([^:*\/]+\/?)*[^:*\/]+$" => lambda { |v| v =~ Regexp.new("/^([^:*\/]+\/?)*[^:*\/]+$/") },
         },
         description: <<~'DESCRIPTION'
           A name for resource policy
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Logs::ResourcePolicy"
rest_api_document "/AWS::Logs::ResourcePolicy"

rest_property_map({
  policy_document: "PolicyDocument",
  policy_name:     "PolicyName",
})

rest_post_only_properties %i{
  policy_name
}
