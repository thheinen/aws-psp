# Import API specifics
use "awscc_base"

resource_name :aws_lambda_event_source_mapping
provides :aws_lambda_event_source_mapping, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Lambda::EventSourceMapping
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :amazon_managed_kafka_event_source_config, Hash,
         description: "Specific configuration settings for an MSK event source."

property :batch_size, Integer,
         callbacks: {
           "batch_size is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "The maximum number of items to retrieve in a single batch."

property :bisect_batch_on_function_error, [TrueClass, FalseClass],
         callbacks: {
           "bisect_batch_on_function_error is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: "(Streams) If the function returns an error, split the batch in two and retry."

property :destination_config, Hash,
         description: "(Streams) An Amazon SQS queue or Amazon SNS topic destination for discarded records."

property :enabled, [TrueClass, FalseClass],
         callbacks: {
           "enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: "Disables the event source mapping to pause polling and invocation."

property :event_source_arn, String,
         callbacks: {
           "event_source_arn is not a String" => lambda { |v| v.is_a? String },
           "event_source_arn needs to be 12..1024 characters" => lambda { |v| v.length >= 12 && v.length <= 1024 },
           "event_source_arn must match pattern arn:(aws[a-zA-Z0-9-]*):([a-zA-Z0-9\-])+:([a-z]{2}(-gov)?-[a-z]+-\d{1})?:(\d{12})?:(.*)" => lambda { |v| v =~ Regexp.new("/arn:(aws[a-zA-Z0-9-]*):([a-zA-Z0-9\-])+:([a-z]{2}(-gov)?-[a-z]+-\d{1})?:(\d{12})?:(.*)/") },
         },
         description: "The Amazon Resource Name (ARN) of the event source."

property :filter_criteria, Hash,
         callbacks: {
           "Subproperty `Filters` is not a Array" => lambda { |v| v[:Filters].is_a? Array },
         },
         description: "The filter criteria to control event filtering."

property :function_name, String,
         required: true,
         callbacks: {
           "function_name is not a String" => lambda { |v| v.is_a? String },
           "function_name needs to be 1..140 characters" => lambda { |v| v.length >= 1 && v.length <= 140 },
           "function_name must match pattern (arn:(aws[a-zA-Z-]*)?:lambda:)?([a-z]{2}(-gov)?-[a-z]+-\d{1}:)?(\d{12}:)?(function:)?([a-zA-Z0-9-_]+)(:(\$LATEST|[a-zA-Z0-9-_]+))?" => lambda { |v| v =~ Regexp.new("/(arn:(aws[a-zA-Z-]*)?:lambda:)?([a-z]{2}(-gov)?-[a-z]+-\d{1}:)?(\d{12}:)?(function:)?([a-zA-Z0-9-_]+)(:(\$LATEST|[a-zA-Z0-9-_]+))?/") },
         },
         description: "The name of the Lambda function."

property :function_response_types, Array,
         callbacks: {
           "function_response_types is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "(Streams) A list of response types supported by the function."

property :maximum_batching_window_in_seconds, Integer,
         callbacks: {
           "maximum_batching_window_in_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "(Streams) The maximum amount of time to gather records before invoking the function, in seconds."

property :maximum_record_age_in_seconds, Integer,
         callbacks: {
           "maximum_record_age_in_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "(Streams) The maximum age of a record that Lambda sends to a function for processing."

property :maximum_retry_attempts, Integer,
         callbacks: {
           "maximum_retry_attempts is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "(Streams) The maximum number of times to retry when the function returns an error."

property :parallelization_factor, Integer,
         callbacks: {
           "parallelization_factor is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "(Streams) The number of batches to process from each shard concurrently."

property :queues, Array,
         callbacks: {
           "queues is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "(ActiveMQ) A list of ActiveMQ queues."

property :self_managed_event_source, Hash,
         description: "Self-managed event source endpoints."

property :self_managed_kafka_event_source_config, Hash,
         description: "Specific configuration settings for a Self-Managed Apache Kafka event source."

property :source_access_configurations, Array,
         callbacks: {
           "source_access_configurations is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "A list of SourceAccessConfiguration."

property :starting_position, String,
         callbacks: {
           "starting_position is not a String" => lambda { |v| v.is_a? String },
           "starting_position needs to be 6..12 characters" => lambda { |v| v.length >= 6 && v.length <= 12 },
           "starting_position must match pattern (LATEST|TRIM_HORIZON|AT_TIMESTAMP)+" => lambda { |v| v =~ Regexp.new("/(LATEST|TRIM_HORIZON|AT_TIMESTAMP)+/") },
         },
         description: "The position in a stream from which to start reading. Required for Amazon Kinesis and Amazon DynamoDB Streams sources."

property :starting_position_timestamp, Number,
         callbacks: {
           "starting_position_timestamp is not a Number" => lambda { |v| v.is_a? Number },
         },
         description: "With StartingPosition set to AT_TIMESTAMP, the time from which to start reading, in Unix time seconds."

property :topics, Array,
         callbacks: {
           "topics is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "(Kafka) A list of Kafka topics."

property :tumbling_window_in_seconds, Integer,
         callbacks: {
           "tumbling_window_in_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "(Streams) Tumbling window (non-overlapping time window) duration to perform aggregations."

# API URLs and mappings
rest_api_collection "/AWS::Lambda::EventSourceMapping"
rest_api_document "/AWS::Lambda::EventSourceMapping"

rest_property_map({
  amazon_managed_kafka_event_source_config: "AmazonManagedKafkaEventSourceConfig",
  batch_size:                               "BatchSize",
  bisect_batch_on_function_error:           "BisectBatchOnFunctionError",
  destination_config:                       "DestinationConfig",
  enabled:                                  "Enabled",
  event_source_arn:                         "EventSourceArn",
  filter_criteria:                          "FilterCriteria",
  function_name:                            "FunctionName",
  function_response_types:                  "FunctionResponseTypes",
  maximum_batching_window_in_seconds:       "MaximumBatchingWindowInSeconds",
  maximum_record_age_in_seconds:            "MaximumRecordAgeInSeconds",
  maximum_retry_attempts:                   "MaximumRetryAttempts",
  parallelization_factor:                   "ParallelizationFactor",
  queues:                                   "Queues",
  self_managed_event_source:                "SelfManagedEventSource",
  self_managed_kafka_event_source_config:   "SelfManagedKafkaEventSourceConfig",
  source_access_configurations:             "SourceAccessConfigurations",
  starting_position:                        "StartingPosition",
  starting_position_timestamp:              "StartingPositionTimestamp",
  topics:                                   "Topics",
  tumbling_window_in_seconds:               "TumblingWindowInSeconds",
})

rest_post_only_properties %i{
  amazon_managed_kafka_event_source_config event_source_arn self_managed_event_source self_managed_kafka_event_source_config starting_position starting_position_timestamp
}
