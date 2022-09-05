# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_iot_events_alarm_model
provides :aws_iot_events_alarm_model, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::IoTEvents::AlarmModel resource creates a alarm model. AWS IoT Events alarms help you monitor your data for changes. The data can be metrics that you measure for your equipment and processes. You can create alarms that send notifications when a threshold is breached. Alarms help you detect issues, streamline maintenance, and optimize performance of your equipment and processes.

Alarms are instances of alarm models. The alarm model specifies what to detect, when to send notifications, who gets notified, and more. You can also specify one or more supported actions that occur when the alarm state changes. AWS IoT Events routes input attributes derived from your data to the appropriate alarms. If the data that you're monitoring is outside the specified range, the alarm is invoked. You can also acknowledge the alarms or set them to the snooze mode.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :alarm_capabilities, Hash,
         description: ""

property :alarm_event_actions, Hash,
         description: ""

property :alarm_model_description, String,
         callbacks: {
           "alarm_model_description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A brief description of the alarm model.
         DESCRIPTION

property :alarm_model_name, String,
         callbacks: {
           "alarm_model_name is not a String" => lambda { |v| v.is_a? String },
           "alarm_model_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "alarm_model_name must match pattern ^[a-zA-Z0-9_-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_-]+$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the alarm model.
         DESCRIPTION

property :alarm_rule, Hash,
         required: true,
         description: ""

property :key, String,
         callbacks: {
           "key is not a String" => lambda { |v| v.is_a? String },
           "key needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "key must match pattern ^((`[\w\- ]+`)|([\w\-]+))(\.((`[\w\- ]+`)|([\w\-]+)))*$" => lambda { |v| v =~ Regexp.new("/^((`[\w\- ]+`)|([\w\-]+))(\.((`[\w\- ]+`)|([\w\-]+)))*$/") },
         },
         description: <<~'DESCRIPTION'
           The value used to identify a alarm instance. When a device or system sends input, a new alarm instance with a unique key value is created. AWS IoT Events can continue to route input to its corresponding alarm instance based on this identifying information.
            This parameter uses a JSON-path expression to select the attribute-value pair in the message payload that is used for identification. To route the message to the correct alarm instance, the device must send a message payload that contains the same attribute-value.
         DESCRIPTION

property :role_arn, String,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
           "role_arn needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
         },
         description: <<~'DESCRIPTION'
           The ARN of the role that grants permission to AWS IoT Events to perform its operations.
         DESCRIPTION

property :severity, Integer,
         callbacks: {
           "severity is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           A non-negative integer that reflects the severity level of the alarm.

         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
            For more information, see [Tag](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-resource-tags.html).
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IoTEvents::AlarmModel"
rest_api_document "/AWS::IoTEvents::AlarmModel"

rest_property_map({
  alarm_capabilities:      "AlarmCapabilities",
  alarm_event_actions:     "AlarmEventActions",
  alarm_model_description: "AlarmModelDescription",
  alarm_model_name:        "AlarmModelName",
  alarm_rule:              "AlarmRule",
  key:                     "Key",
  role_arn:                "RoleArn",
  severity:                "Severity",
  tags:                    "Tags",
})

rest_post_only_properties %i{
  alarm_model_name key
}
