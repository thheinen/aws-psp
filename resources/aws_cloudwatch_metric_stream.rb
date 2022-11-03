# Import API specifics
use "awscc_base"

resource_name :aws_cloudwatch_metric_stream
provides :aws_cloudwatch_metric_stream, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for Metric Stream
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :exclude_filters, Array,
         callbacks: {
           "exclude_filters is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Define which metrics will be not streamed. Metrics matched by multiple instances of MetricStreamFilter are joined with an OR operation by default. If both IncludeFilters and ExcludeFilters are omitted, all metrics in the account will be streamed. IncludeFilters and ExcludeFilters are mutually exclusive. Default to null.
         DESCRIPTION

property :firehose_arn, String,
         required: true,
         callbacks: {
           "firehose_arn is not a String" => lambda { |v| v.is_a? String },
           "firehose_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
         },
         description: <<~'DESCRIPTION'
           The ARN of the Kinesis Firehose where to stream the data.
         DESCRIPTION

property :include_filters, Array,
         callbacks: {
           "include_filters is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Define which metrics will be streamed. Metrics matched by multiple instances of MetricStreamFilter are joined with an OR operation by default. If both IncludeFilters and ExcludeFilters are omitted, all metrics in the account will be streamed. IncludeFilters and ExcludeFilters are mutually exclusive. Default to null.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           Name of the metric stream.
         DESCRIPTION

property :output_format, String,
         required: true,
         callbacks: {
           "output_format is not a String" => lambda { |v| v.is_a? String },
           "output_format needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           The output format of the data streamed to the Kinesis Firehose.
         DESCRIPTION

property :role_arn, String,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
           "role_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
         },
         description: <<~'DESCRIPTION'
           The ARN of the role that provides access to the Kinesis Firehose.
         DESCRIPTION

property :statistics_configurations, Array,
         callbacks: {
           "statistics_configurations is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           By default, a metric stream always sends the MAX, MIN, SUM, and SAMPLECOUNT statistics for each metric that is streamed. You can use this parameter to have the metric stream also send additional statistics in the stream. This array can have up to 100 members.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A set of tags to assign to the delivery stream.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::CloudWatch::MetricStream"
rest_api_document "/AWS::CloudWatch::MetricStream"

rest_property_map({
  exclude_filters:           "ExcludeFilters",
  firehose_arn:              "FirehoseArn",
  include_filters:           "IncludeFilters",
  name:                      "Name",
  output_format:             "OutputFormat",
  role_arn:                  "RoleArn",
  statistics_configurations: "StatisticsConfigurations",
  tags:                      "Tags",
})

rest_post_only_properties %i{
  name
}
