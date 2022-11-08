# Import API specifics
use "awscc_base"

resource_name :aws_cloudwatch_alarm
provides :aws_cloudwatch_alarm, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::CloudWatch::Alarm
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :actions_enabled, [TrueClass, FalseClass],
         callbacks: {
           "actions_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Indicates whether actions should be executed during any changes to the alarm state. The default is TRUE.
         DESCRIPTION

property :alarm_actions, Array,
         callbacks: {
           "alarm_actions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The list of actions to execute when this alarm transitions into an ALARM state from any other state.
         DESCRIPTION

property :alarm_description, String,
         callbacks: {
           "alarm_description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The description of the alarm.
         DESCRIPTION

property :alarm_name, String,
         callbacks: {
           "alarm_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the alarm.
         DESCRIPTION

property :comparison_operator, String,
         required: true,
         callbacks: {
           "comparison_operator is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The arithmetic operation to use when comparing the specified statistic and threshold.
         DESCRIPTION

property :datapoints_to_alarm, Integer,
         callbacks: {
           "datapoints_to_alarm is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of datapoints that must be breaching to trigger the alarm.
         DESCRIPTION

property :dimensions, Array,
         callbacks: {
           "dimensions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The dimensions for the metric associated with the alarm. For an alarm based on a math expression, you can't specify Dimensions. Instead, you use Metrics.
         DESCRIPTION

property :evaluate_low_sample_count_percentile, String,
         callbacks: {
           "evaluate_low_sample_count_percentile is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Used only for alarms based on percentiles.
         DESCRIPTION

property :evaluation_periods, Integer,
         required: true,
         callbacks: {
           "evaluation_periods is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of periods over which data is compared to the specified threshold.
         DESCRIPTION

property :extended_statistic, String,
         callbacks: {
           "extended_statistic is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The percentile statistic for the metric associated with the alarm. Specify a value between p0.0 and p100.
         DESCRIPTION

property :insufficient_data_actions, Array,
         callbacks: {
           "insufficient_data_actions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The actions to execute when this alarm transitions to the INSUFFICIENT_DATA state from any other state.
         DESCRIPTION

property :metric_name, String,
         callbacks: {
           "metric_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the metric associated with the alarm.
         DESCRIPTION

property :metrics, Array,
         callbacks: {
           "metrics is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array that enables you to create an alarm based on the result of a metric math expression.
         DESCRIPTION

property :namespace, String,
         callbacks: {
           "namespace is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The namespace of the metric associated with the alarm.
         DESCRIPTION

property :ok_actions, Array,
         callbacks: {
           "ok_actions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The actions to execute when this alarm transitions to the OK state from any other state.
         DESCRIPTION

property :period, Integer,
         callbacks: {
           "period is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The period in seconds, over which the statistic is applied.
         DESCRIPTION

property :statistic, String,
         callbacks: {
           "statistic is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The statistic for the metric associated with the alarm, other than percentile.
         DESCRIPTION

property :threshold, Number,
         callbacks: {
           "threshold is not a Number" => lambda { |v| v.is_a? Number },
         },
         description: <<~'DESCRIPTION'
           In an alarm based on an anomaly detection model, this is the ID of the ANOMALY_DETECTION_BAND function used as the threshold for the alarm.
         DESCRIPTION

property :threshold_metric_id, String,
         callbacks: {
           "threshold_metric_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           In an alarm based on an anomaly detection model, this is the ID of the ANOMALY_DETECTION_BAND function used as the threshold for the alarm.
         DESCRIPTION

property :treat_missing_data, String,
         callbacks: {
           "treat_missing_data is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Sets how this alarm is to handle missing data points. Valid values are breaching, notBreaching, ignore, and missing.
         DESCRIPTION

property :unit, String,
         callbacks: {
           "unit is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The unit of the metric associated with the alarm.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::CloudWatch::Alarm"
rest_api_document "/AWS::CloudWatch::Alarm"

rest_property_map({
  actions_enabled:                      "ActionsEnabled",
  alarm_actions:                        "AlarmActions",
  alarm_description:                    "AlarmDescription",
  alarm_name:                           "AlarmName",
  comparison_operator:                  "ComparisonOperator",
  datapoints_to_alarm:                  "DatapointsToAlarm",
  dimensions:                           "Dimensions",
  evaluate_low_sample_count_percentile: "EvaluateLowSampleCountPercentile",
  evaluation_periods:                   "EvaluationPeriods",
  extended_statistic:                   "ExtendedStatistic",
  insufficient_data_actions:            "InsufficientDataActions",
  metric_name:                          "MetricName",
  metrics:                              "Metrics",
  namespace:                            "Namespace",
  ok_actions:                           "OKActions",
  period:                               "Period",
  statistic:                            "Statistic",
  threshold:                            "Threshold",
  threshold_metric_id:                  "ThresholdMetricId",
  treat_missing_data:                   "TreatMissingData",
  unit:                                 "Unit",
})

rest_post_only_properties %i{
  alarm_name
}
