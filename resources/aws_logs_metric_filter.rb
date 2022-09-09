# Import API specifics
use "awscc_base"

resource_name :aws_logs_metric_filter
provides :aws_logs_metric_filter, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Specifies a metric filter that describes how CloudWatch Logs extracts information from logs and transforms it into Amazon CloudWatch metrics.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :filter_name, String,
         callbacks: {
           "filter_name is not a String" => lambda { |v| v.is_a? String },
           "filter_name needs to be 1..512 characters" => lambda { |v| v.length >= 1 && v.length <= 512 },
           "filter_name must match pattern ^[^:*]{1,512}" => lambda { |v| v =~ Regexp.new("/^[^:*]{1,512}/") },
         },
         description: <<~'DESCRIPTION'
           A name for the metric filter.
         DESCRIPTION

property :filter_pattern, String,
         required: true,
         callbacks: {
           "filter_pattern is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Pattern that Logs follows to interpret each entry in a log.
         DESCRIPTION

property :log_group_name, String,
         required: true,
         callbacks: {
           "log_group_name is not a String" => lambda { |v| v.is_a? String },
           "log_group_name needs to be 1..512 characters" => lambda { |v| v.length >= 1 && v.length <= 512 },
           "log_group_name must match pattern ^[.\-_/#A-Za-z0-9]{1,512}" => lambda { |v| v =~ Regexp.new("/^[.\-_/#A-Za-z0-9]{1,512}/") },
         },
         description: <<~'DESCRIPTION'
           Existing log group that you want to associate with this filter.
         DESCRIPTION

property :metric_transformations, Array,
         required: true,
         callbacks: {
           "metric_transformations is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A collection of information that defines how metric data gets emitted.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Logs::MetricFilter"
rest_api_document "/AWS::Logs::MetricFilter"

rest_property_map({
  filter_name:            "FilterName",
  filter_pattern:         "FilterPattern",
  log_group_name:         "LogGroupName",
  metric_transformations: "MetricTransformations",
})

rest_post_only_properties %i{
  filter_name log_group_name
}
