# Import API specifics
use "awscc_base"

resource_name :aws_sns_topic_policy
provides :aws_sns_topic_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Schema for AWS::SNS::TopicPolicy
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

property :topics, Array,
         required: true,
         callbacks: {
           "topics is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Names (ARN) of the topics to which you want to add the policy. You can use the [Ref](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference-ref.html)` function to specify an [AWS::SNS::Topic](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-sns-topic.html) resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SNS::TopicPolicy"
rest_api_document "/AWS::SNS::TopicPolicy"

rest_property_map({
  policy_document: "PolicyDocument",
  topics:          "Topics",
})

