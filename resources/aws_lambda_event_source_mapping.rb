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
         description: <<~'DESCRIPTION'
           Specific configuration settings for an MSK event source.
         DESCRIPTION

property :batch_size, Integer,
         callbacks: {
           "batch_size is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The maximum number of items to retrieve in a single batch.
         DESCRIPTION

property :bisect_batch_on_function_error, [TrueClass, FalseClass],
         callbacks: {
           "bisect_batch_on_function_error is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           (Streams) If the function returns an error, split the batch in two and retry.
         DESCRIPTION

property :destination_config, Hash,
         description: <<~'DESCRIPTION'
           (Streams) An Amazon SQS queue or Amazon SNS topic destination for discarded records.
         DESCRIPTION

property :document_db_event_source_config, Hash,
         callbacks: {
           "Subproperty `DatabaseName` is not a String" => lambda { |v| v[:DatabaseName].is_a? String },
           "Subproperty `DatabaseName` needs to be 1..63 characters" => lambda { |v| v[:DatabaseName].length >= 1 && v[:DatabaseName].length <= 63 },
           "Subproperty `CollectionName` is not a String" => lambda { |v| v[:CollectionName].is_a? String },
           "Subproperty `CollectionName` needs to be 1..57 characters" => lambda { |v| v[:CollectionName].length >= 1 && v[:CollectionName].length <= 57 },
           "Subproperty `FullDocument` is not a String" => lambda { |v| v[:FullDocument].is_a? String },
           "Subproperty `FullDocument`is not one of `UpdateLookup`, `Default`" => lambda { |v| %w{UpdateLookup Default}.include? v[:FullDocument] },
         },
         description: <<~'DESCRIPTION'
           Document db event source config.
         DESCRIPTION

property :enabled, [TrueClass, FalseClass],
         callbacks: {
           "enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Disables the event source mapping to pause polling and invocation.
         DESCRIPTION

property :event_source_arn, String,
         callbacks: {
           "event_source_arn is not a String" => lambda { |v| v.is_a? String },
           "event_source_arn needs to be 12..1024 characters" => lambda { |v| v.length >= 12 && v.length <= 1024 },
           "event_source_arn must match pattern arn:(aws[a-zA-Z0-9-]*):([a-zA-Z0-9\-])+:([a-z]{2}(-gov)?-[a-z]+-\d{1})?:(\d{12})?:(.*)" => lambda { |v| v =~ Regexp.new("/arn:(aws[a-zA-Z0-9-]*):([a-zA-Z0-9\-])+:([a-z]{2}(-gov)?-[a-z]+-\d{1})?:(\d{12})?:(.*)/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the event source.
         DESCRIPTION

property :filter_criteria, Hash,
         callbacks: {
           "Subproperty `Filters` is not a Array" => lambda { |v| v[:Filters].is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The filter criteria to control event filtering.
         DESCRIPTION

property :function_name, String,
         required: true,
         callbacks: {
           "function_name is not a String" => lambda { |v| v.is_a? String },
           "function_name needs to be 1..140 characters" => lambda { |v| v.length >= 1 && v.length <= 140 },
           "function_name must match pattern (arn:(aws[a-zA-Z-]*)?:lambda:)?([a-z]{2}(-gov)?-[a-z]+-\d{1}:)?(\d{12}:)?(function:)?([a-zA-Z0-9-_]+)(:(\$LATEST|[a-zA-Z0-9-_]+))?" => lambda { |v| v =~ Regexp.new("/(arn:(aws[a-zA-Z-]*)?:lambda:)?([a-z]{2}(-gov)?-[a-z]+-\d{1}:)?(\d{12}:)?(function:)?([a-zA-Z0-9-_]+)(:(\$LATEST|[a-zA-Z0-9-_]+))?/") },
         },
         description: <<~'DESCRIPTION'
           The name of the Lambda function.
         DESCRIPTION

property :function_response_types, Array,
         callbacks: {
           "function_response_types is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           (Streams) A list of response types supported by the function.
         DESCRIPTION

property :maximum_batching_window_in_seconds, Integer,
         callbacks: {
           "maximum_batching_window_in_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           (Streams) The maximum amount of time to gather records before invoking the function, in seconds.
         DESCRIPTION

property :maximum_record_age_in_seconds, Integer,
         callbacks: {
           "maximum_record_age_in_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           (Streams) The maximum age of a record that Lambda sends to a function for processing.
         DESCRIPTION

property :maximum_retry_attempts, Integer,
         callbacks: {
           "maximum_retry_attempts is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           (Streams) The maximum number of times to retry when the function returns an error.
         DESCRIPTION

property :parallelization_factor, Integer,
         callbacks: {
           "parallelization_factor is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           (Streams) The number of batches to process from each shard concurrently.
         DESCRIPTION

property :queues, Array,
         callbacks: {
           "queues is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           (ActiveMQ) A list of ActiveMQ queues.
         DESCRIPTION

property :scaling_config, Hash,
         description: <<~'DESCRIPTION'
           The scaling configuration for the event source.
         DESCRIPTION

property :self_managed_event_source, Hash,
         description: <<~'DESCRIPTION'
           Self-managed event source endpoints.
         DESCRIPTION

property :self_managed_kafka_event_source_config, Hash,
         description: <<~'DESCRIPTION'
           Specific configuration settings for a Self-Managed Apache Kafka event source.
         DESCRIPTION

property :source_access_configurations, Array,
         callbacks: {
           "source_access_configurations is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of SourceAccessConfiguration.
         DESCRIPTION

property :starting_position, String,
         callbacks: {
           "starting_position is not a String" => lambda { |v| v.is_a? String },
           "starting_position needs to be 6..12 characters" => lambda { |v| v.length >= 6 && v.length <= 12 },
           "starting_position must match pattern (LATEST|TRIM_HORIZON|AT_TIMESTAMP)+" => lambda { |v| v =~ Regexp.new("/(LATEST|TRIM_HORIZON|AT_TIMESTAMP)+/") },
         },
         description: <<~'DESCRIPTION'
           The position in a stream from which to start reading. Required for Amazon Kinesis and Amazon DynamoDB Streams sources.
         DESCRIPTION

property :starting_position_timestamp, Number,
         callbacks: {
           "starting_position_timestamp is not a Number" => lambda { |v| v.is_a? Number },
         },
         description: <<~'DESCRIPTION'
           With StartingPosition set to AT_TIMESTAMP, the time from which to start reading, in Unix time seconds.
         DESCRIPTION

property :topics, Array,
         callbacks: {
           "topics is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           (Kafka) A list of Kafka topics.
         DESCRIPTION

property :tumbling_window_in_seconds, Integer,
         callbacks: {
           "tumbling_window_in_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           (Streams) Tumbling window (non-overlapping time window) duration to perform aggregations.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Lambda::EventSourceMapping"
rest_api_document "/AWS::Lambda::EventSourceMapping"

rest_property_map({
  amazon_managed_kafka_event_source_config: "AmazonManagedKafkaEventSourceConfig",
  batch_size:                               "BatchSize",
  bisect_batch_on_function_error:           "BisectBatchOnFunctionError",
  destination_config:                       "DestinationConfig",
  document_db_event_source_config:          "DocumentDBEventSourceConfig",
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
  scaling_config:                           "ScalingConfig",
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
