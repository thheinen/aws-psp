# Import API specifics
use "awscc_base"

resource_name :aws_iot_policy
provides :aws_iot_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::IoT::Policy
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :policy_document, Hash,
         required: true,
         callbacks: {
           "policy_document is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :policy_name, String,
         callbacks: {
           "policy_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::IoT::Policy"
rest_api_document "/AWS::IoT::Policy"

rest_property_map({
  policy_document: "PolicyDocument",
  policy_name:     "PolicyName",
})

rest_post_only_properties %i{
  policy_name
}
