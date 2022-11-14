# Import API specifics
use "awscc_base"

resource_name :aws_lightsail_alarm
provides :aws_lightsail_alarm, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Lightsail::Alarm
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :alarm_name, String,
         required: true,
         callbacks: {
           "alarm_name is not a String" => lambda { |v| v.is_a? String },
           "alarm_name must match pattern \w[\w\-]*\w" => lambda { |v| v =~ Regexp.new("/\w[\w\-]*\w/") },
         },
         description: <<~'DESCRIPTION'
           The name for the alarm. Specify the name of an existing alarm to update, and overwrite the previous configuration of the alarm.
         DESCRIPTION

property :comparison_operator, String,
         required: true,
         callbacks: {
           "comparison_operator is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The arithmetic operation to use when comparing the specified statistic to the threshold. The specified statistic value is used as the first operand.
         DESCRIPTION

property :contact_protocols, Array,
         callbacks: {
           "contact_protocols is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The contact protocols to use for the alarm, such as Email, SMS (text messaging), or both.
         DESCRIPTION

property :datapoints_to_alarm, Integer,
         callbacks: {
           "datapoints_to_alarm is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of data points that must be not within the specified threshold to trigger the alarm. If you are setting an "M out of N" alarm, this value (datapointsToAlarm) is the M.
         DESCRIPTION

property :evaluation_periods, Integer,
         required: true,
         callbacks: {
           "evaluation_periods is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of most recent periods over which data is compared to the specified threshold. If you are setting an "M out of N" alarm, this value (evaluationPeriods) is the N.
         DESCRIPTION

property :metric_name, String,
         required: true,
         callbacks: {
           "metric_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the metric to associate with the alarm.
         DESCRIPTION

property :monitored_resource_name, String,
         required: true,
         callbacks: {
           "monitored_resource_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The validation status of the SSL/TLS certificate.
         DESCRIPTION

property :notification_enabled, [TrueClass, FalseClass],
         callbacks: {
           "notification_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Indicates whether the alarm is enabled. Notifications are enabled by default if you don't specify this parameter.
         DESCRIPTION

property :notification_triggers, Array,
         callbacks: {
           "notification_triggers is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The alarm states that trigger a notification.
         DESCRIPTION

property :threshold, Number,
         required: true,
         callbacks: {
           "threshold is not a Number" => lambda { |v| v.is_a? Number },
         },
         description: <<~'DESCRIPTION'
           The value against which the specified statistic is compared.
         DESCRIPTION

property :treat_missing_data, String,
         callbacks: {
           "treat_missing_data is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Sets how this alarm will handle missing data points.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Lightsail::Alarm"
rest_api_document "/AWS::Lightsail::Alarm"

rest_property_map({
  alarm_name:              "AlarmName",
  comparison_operator:     "ComparisonOperator",
  contact_protocols:       "ContactProtocols",
  datapoints_to_alarm:     "DatapointsToAlarm",
  evaluation_periods:      "EvaluationPeriods",
  metric_name:             "MetricName",
  monitored_resource_name: "MonitoredResourceName",
  notification_enabled:    "NotificationEnabled",
  notification_triggers:   "NotificationTriggers",
  threshold:               "Threshold",
  treat_missing_data:      "TreatMissingData",
})

rest_post_only_properties %i{
  alarm_name metric_name monitored_resource_name
}
