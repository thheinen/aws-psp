# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_autoscaling_lifecycle_hook
provides :aws_autoscaling_lifecycle_hook, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::AutoScaling::LifecycleHook
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :autoscaling_group_name, String,
         required: true,
         callbacks: {
           "autoscaling_group_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the Auto Scaling group for the lifecycle hook.
         DESCRIPTION

property :default_result, String,
         callbacks: {
           "default_result is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The action the Auto Scaling group takes when the lifecycle hook timeout elapses or if an unexpected failure occurs. The valid values are CONTINUE and ABANDON (default).
         DESCRIPTION

property :heartbeat_timeout, Integer,
         callbacks: {
           "heartbeat_timeout is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The maximum time, in seconds, that can elapse before the lifecycle hook times out. The range is from 30 to 7200 seconds. The default value is 3600 seconds (1 hour). If the lifecycle hook times out, Amazon EC2 Auto Scaling performs the action that you specified in the DefaultResult property.
         DESCRIPTION

property :lifecycle_hook_name, String,
         callbacks: {
           "lifecycle_hook_name is not a String" => lambda { |v| v.is_a? String },
           "lifecycle_hook_name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           The name of the lifecycle hook.
         DESCRIPTION

property :lifecycle_transition, String,
         required: true,
         callbacks: {
           "lifecycle_transition is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The instance state to which you want to attach the lifecycle hook.
         DESCRIPTION

property :notification_metadata, String,
         callbacks: {
           "notification_metadata is not a String" => lambda { |v| v.is_a? String },
           "notification_metadata needs to be 1..1023 characters" => lambda { |v| v.length >= 1 && v.length <= 1023 },
         },
         description: <<~'DESCRIPTION'
           Additional information that is included any time Amazon EC2 Auto Scaling sends a message to the notification target.
         DESCRIPTION

property :notification_target_arn, String,
         callbacks: {
           "notification_target_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the notification target that Amazon EC2 Auto Scaling uses to notify you when an instance is in the transition state for the lifecycle hook. You can specify an Amazon SQS queue or an Amazon SNS topic. The notification message includes the following information: lifecycle action token, user account ID, Auto Scaling group name, lifecycle hook name, instance ID, lifecycle transition, and notification metadata.
         DESCRIPTION

property :role_arn, String,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ARN of the IAM role that allows the Auto Scaling group to publish to the specified notification target, for example, an Amazon SNS topic or an Amazon SQS queue.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::AutoScaling::LifecycleHook"
rest_api_document "/AWS::AutoScaling::LifecycleHook"

rest_property_map({
  autoscaling_group_name:  "AutoScalingGroupName",
  default_result:          "DefaultResult",
  heartbeat_timeout:       "HeartbeatTimeout",
  lifecycle_hook_name:     "LifecycleHookName",
  lifecycle_transition:    "LifecycleTransition",
  notification_metadata:   "NotificationMetadata",
  notification_target_arn: "NotificationTargetARN",
  role_arn:                "RoleARN",
})

rest_post_only_properties %i{
  autoscaling_group_name lifecycle_hook_name
}
