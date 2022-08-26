# Import API specifics
use "awscc_base"

resource_name :aws_cloudwatch_composite_alarm
provides :aws_cloudwatch_composite_alarm, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::CloudWatch::CompositeAlarm type specifies an alarm which aggregates the states of other Alarms (Metric or Composite Alarms) as defined by the AlarmRule expression
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :actions_enabled, [TrueClass, FalseClass],
         callbacks: {
           "actions_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: "Indicates whether actions should be executed during any changes to the alarm state. The default is TRUE."

property :actions_suppressor, String,
         callbacks: {
           "actions_suppressor is not a String" => lambda { |v| v.is_a? String },
           "actions_suppressor needs to be 1..1600 characters" => lambda { |v| v.length >= 1 && v.length <= 1600 },
         },
         description: "Actions will be suppressed if the suppressor alarm is in the ALARM state. ActionsSuppressor can be an AlarmName or an Amazon Resource Name (ARN) from an existing alarm. "

property :actions_suppressor_extension_period, Integer,
         callbacks: {
           "actions_suppressor_extension_period is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "Actions will be suppressed if WaitPeriod is active. The length of time that actions are suppressed is in seconds."

property :actions_suppressor_wait_period, Integer,
         callbacks: {
           "actions_suppressor_wait_period is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "Actions will be suppressed if ExtensionPeriod is active. The length of time that actions are suppressed is in seconds."

property :alarm_actions, Array,
         callbacks: {
           "alarm_actions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The list of actions to execute when this alarm transitions into an ALARM state from any other state. Specify each action as an Amazon Resource Name (ARN)."

property :alarm_description, String,
         callbacks: {
           "alarm_description is not a String" => lambda { |v| v.is_a? String },
           "alarm_description needs to be 0..1024 characters" => lambda { |v| v.length >= 0 && v.length <= 1024 },
         },
         description: "The description of the alarm"

property :alarm_name, String,
         required: true,
         callbacks: {
           "alarm_name is not a String" => lambda { |v| v.is_a? String },
           "alarm_name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: "The name of the Composite Alarm"

property :alarm_rule, String,
         required: true,
         callbacks: {
           "alarm_rule is not a String" => lambda { |v| v.is_a? String },
           "alarm_rule needs to be 1..10240 characters" => lambda { |v| v.length >= 1 && v.length <= 10240 },
         },
         description: "Expression which aggregates the state of other Alarms (Metric or Composite Alarms)"

property :insufficient_data_actions, Array,
         callbacks: {
           "insufficient_data_actions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The actions to execute when this alarm transitions to the INSUFFICIENT_DATA state from any other state. Each action is specified as an Amazon Resource Name (ARN)."

property :ok_actions, Array,
         callbacks: {
           "ok_actions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The actions to execute when this alarm transitions to the OK state from any other state. Each action is specified as an Amazon Resource Name (ARN)."

# API URLs and mappings
rest_api_collection "/AWS::CloudWatch::CompositeAlarm"
rest_api_document "/AWS::CloudWatch::CompositeAlarm"

rest_property_map({
  actions_enabled:                     "ActionsEnabled",
  actions_suppressor:                  "ActionsSuppressor",
  actions_suppressor_extension_period: "ActionsSuppressorExtensionPeriod",
  actions_suppressor_wait_period:      "ActionsSuppressorWaitPeriod",
  alarm_actions:                       "AlarmActions",
  alarm_description:                   "AlarmDescription",
  alarm_name:                          "AlarmName",
  alarm_rule:                          "AlarmRule",
  insufficient_data_actions:           "InsufficientDataActions",
  ok_actions:                          "OKActions",
})

rest_post_only_properties %i{
  alarm_name
}
