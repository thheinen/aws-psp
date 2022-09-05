# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_sqs_queue
provides :aws_sqs_queue, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SQS::Queue
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :content_based_deduplication, [TrueClass, FalseClass],
         callbacks: {
           "content_based_deduplication is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           For first-in-first-out (FIFO) queues, specifies whether to enable content-based deduplication. During the deduplication interval, Amazon SQS treats messages that are sent with identical content as duplicates and delivers only one copy of the message.
         DESCRIPTION

property :deduplication_scope, String,
         callbacks: {
           "deduplication_scope is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies whether message deduplication occurs at the message group or queue level. Valid values are messageGroup and queue.
         DESCRIPTION

property :delay_seconds, Integer,
         callbacks: {
           "delay_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The time in seconds for which the delivery of all messages in the queue is delayed. You can specify an integer value of 0 to 900 (15 minutes). The default value is 0.
         DESCRIPTION

property :fifo_queue, [TrueClass, FalseClass],
         callbacks: {
           "fifo_queue is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           If set to true, creates a FIFO queue. If you don't specify this property, Amazon SQS creates a standard queue.
         DESCRIPTION

property :fifo_throughput_limit, String,
         callbacks: {
           "fifo_throughput_limit is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies whether the FIFO queue throughput quota applies to the entire queue or per message group. Valid values are perQueue and perMessageGroupId. The perMessageGroupId value is allowed only when the value for DeduplicationScope is messageGroup.
         DESCRIPTION

property :kms_data_key_reuse_period_seconds, Integer,
         callbacks: {
           "kms_data_key_reuse_period_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The length of time in seconds for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. The value must be an integer between 60 (1 minute) and 86,400 (24 hours). The default is 300 (5 minutes).
         DESCRIPTION

property :kms_master_key_id, String,
         callbacks: {
           "kms_master_key_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of an AWS managed customer master key (CMK) for Amazon SQS or a custom CMK. To use the AWS managed CMK for Amazon SQS, specify the (default) alias alias/aws/sqs.
         DESCRIPTION

property :maximum_message_size, Integer,
         callbacks: {
           "maximum_message_size is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The limit of how many bytes that a message can contain before Amazon SQS rejects it. You can specify an integer value from 1,024 bytes (1 KiB) to 262,144 bytes (256 KiB). The default value is 262,144 (256 KiB).
         DESCRIPTION

property :message_retention_period, Integer,
         callbacks: {
           "message_retention_period is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of seconds that Amazon SQS retains a message. You can specify an integer value from 60 seconds (1 minute) to 1,209,600 seconds (14 days). The default value is 345,600 seconds (4 days).
         DESCRIPTION

property :queue_name, String,
         callbacks: {
           "queue_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A name for the queue. To create a FIFO queue, the name of your FIFO queue must end with the .fifo suffix.
         DESCRIPTION

property :receive_message_wait_time_seconds, Integer,
         callbacks: {
           "receive_message_wait_time_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           Specifies the duration, in seconds, that the ReceiveMessage action call waits until a message is in the queue in order to include it in the response, rather than returning an empty response if a message isn't yet available. You can specify an integer from 1 to 20. Short polling is used as the default or when you specify 0 for this property.
         DESCRIPTION

property :redrive_allow_policy, [Hash, String],
         description: <<~'DESCRIPTION'
           The string that includes the parameters for the permissions for the dead-letter queue redrive permission and which source queues can specify dead-letter queues as a JSON object.
         DESCRIPTION

property :redrive_policy, [Hash, String],
         description: <<~'DESCRIPTION'
           A string that includes the parameters for the dead-letter queue functionality (redrive policy) of the source queue.
         DESCRIPTION

property :sqs_managed_sse_enabled, [TrueClass, FalseClass],
         callbacks: {
           "sqs_managed_sse_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Enables server-side queue encryption using SQS owned encryption keys. Only one server-side encryption option is supported per queue (e.g. SSE-KMS or SSE-SQS ).
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags that you attach to this queue.
         DESCRIPTION

property :visibility_timeout, Integer,
         callbacks: {
           "visibility_timeout is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The length of time during which a message will be unavailable after a message is delivered from the queue. This blocks other components from receiving the same message and gives the initial component time to process and delete the message from the queue. Values must be from 0 to 43,200 seconds (12 hours). If you don't specify a value, AWS CloudFormation uses the default value of 30 seconds.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SQS::Queue"
rest_api_document "/AWS::SQS::Queue"

rest_property_map({
  content_based_deduplication:       "ContentBasedDeduplication",
  deduplication_scope:               "DeduplicationScope",
  delay_seconds:                     "DelaySeconds",
  fifo_queue:                        "FifoQueue",
  fifo_throughput_limit:             "FifoThroughputLimit",
  kms_data_key_reuse_period_seconds: "KmsDataKeyReusePeriodSeconds",
  kms_master_key_id:                 "KmsMasterKeyId",
  maximum_message_size:              "MaximumMessageSize",
  message_retention_period:          "MessageRetentionPeriod",
  queue_name:                        "QueueName",
  receive_message_wait_time_seconds: "ReceiveMessageWaitTimeSeconds",
  redrive_allow_policy:              "RedriveAllowPolicy",
  redrive_policy:                    "RedrivePolicy",
  sqs_managed_sse_enabled:           "SqsManagedSseEnabled",
  tags:                              "Tags",
  visibility_timeout:                "VisibilityTimeout",
})

rest_post_only_properties %i{
  fifo_queue queue_name
}
