# Import API specifics
use "awscc_base"

resource_name :aws_sns_topic
provides :aws_sns_topic, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SNS::Topic
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :content_based_deduplication, [TrueClass, FalseClass],
         callbacks: {
           "content_based_deduplication is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Enables content-based deduplication for FIFO topics. By default, ContentBasedDeduplication is set to false. If you create a FIFO topic and this attribute is false, you must specify a value for the MessageDeduplicationId parameter for the Publish action.
            When you set ContentBasedDeduplication to true, Amazon SNS uses a SHA-256 hash to generate the MessageDeduplicationId using the body of the message (but not the attributes of the message).
            (Optional) To override the generated value, you can specify a value for the the MessageDeduplicationId parameter for the Publish action.

         DESCRIPTION

property :data_protection_policy, Hash,
         callbacks: {
           "data_protection_policy is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           The body of the policy document you want to use for this topic.
            You can only add one policy per topic.
            The policy must be in JSON string format.
            Length Constraints: Maximum length of 30720
         DESCRIPTION

property :display_name, String,
         callbacks: {
           "display_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The display name to use for an Amazon SNS topic with SMS subscriptions.
         DESCRIPTION

property :fifo_topic, [TrueClass, FalseClass],
         callbacks: {
           "fifo_topic is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Set to true to create a FIFO topic.
         DESCRIPTION

property :kms_master_key_id, String,
         callbacks: {
           "kms_master_key_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of an AWS-managed customer master key (CMK) for Amazon SNS or a custom CMK. For more information, see Key Terms. For more examples, see KeyId in the AWS Key Management Service API Reference.
            This property applies only to [server-side-encryption](https://docs.aws.amazon.com/sns/latest/dg/sns-server-side-encryption.html).
         DESCRIPTION

property :signature_version, String,
         callbacks: {
           "signature_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Version of the Amazon SNS signature used. If the SignatureVersion is 1, Signature is a Base64-encoded SHA1withRSA signature of the Message, MessageId, Type, Timestamp, and TopicArn values. If the SignatureVersion is 2, Signature is a Base64-encoded SHA256withRSA signature of the Message, MessageId, Type, Timestamp, and TopicArn values.
         DESCRIPTION

property :subscription, Array,
         callbacks: {
           "subscription is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The SNS subscriptions (endpoints) for this topic.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :topic_name, String,
         callbacks: {
           "topic_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the topic you want to create. Topic names must include only uppercase and lowercase ASCII letters, numbers, underscores, and hyphens, and must be between 1 and 256 characters long. FIFO topic names must end with .fifo.
            If you don't specify a name, AWS CloudFormation generates a unique physical ID and uses that ID for the topic name. For more information, see Name Type.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SNS::Topic"
rest_api_document "/AWS::SNS::Topic"

rest_property_map({
  content_based_deduplication: "ContentBasedDeduplication",
  data_protection_policy:      "DataProtectionPolicy",
  display_name:                "DisplayName",
  fifo_topic:                  "FifoTopic",
  kms_master_key_id:           "KmsMasterKeyId",
  signature_version:           "SignatureVersion",
  subscription:                "Subscription",
  tags:                        "Tags",
  topic_name:                  "TopicName",
})

rest_post_only_properties %i{
  fifo_topic topic_name
}
