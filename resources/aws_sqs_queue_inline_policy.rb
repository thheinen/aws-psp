# Import API specifics
use "awscc_base"

resource_name :aws_sqs_queue_inline_policy
provides :aws_sqs_queue_inline_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Schema for SQS QueueInlinePolicy
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
           A policy document that contains permissions to add to the specified SQS queue
         DESCRIPTION

property :queue, String,
         required: true,
         callbacks: {
           "queue is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The URL of the SQS queue.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SQS::QueueInlinePolicy"
rest_api_document "/AWS::SQS::QueueInlinePolicy"

rest_property_map({
  policy_document: "PolicyDocument",
  queue:           "Queue",
})

rest_post_only_properties %i{
  queue
}
