# Import API specifics
use "awscc_base"

resource_name :aws_sns_topic_inline_policy
provides :aws_sns_topic_inline_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Schema for AWS::SNS::TopicInlinePolicy
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :policy_document, Hash,
         required: true,
         callbacks: {
           "policy_document is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           A policy document that contains permissions to add to the specified SNS topics.
         DESCRIPTION

property :topic_arn, String,
         required: true,
         callbacks: {
           "topic_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the topic to which you want to add the policy.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SNS::TopicInlinePolicy"
rest_api_document "/AWS::SNS::TopicInlinePolicy"

rest_property_map({
  policy_document: "PolicyDocument",
  topic_arn:       "TopicArn",
})

rest_post_only_properties %i{
  topic_arn
}
