# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_redshift_scheduled_action
provides :aws_redshift_scheduled_action, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The `AWS::Redshift::ScheduledAction` resource creates an Amazon Redshift Scheduled Action.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :enable, [TrueClass, FalseClass],
         callbacks: {
           "enable is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           If true, the schedule is enabled. If false, the scheduled action does not trigger.
         DESCRIPTION

property :end_time, Hash,
         callbacks: {
           "end_time is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The end time in UTC of the scheduled action. After this time, the scheduled action does not trigger.
         DESCRIPTION

property :iam_role, String,
         callbacks: {
           "iam_role is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The IAM role to assume to run the target action.
         DESCRIPTION

property :schedule, String,
         callbacks: {
           "schedule is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The schedule in `at( )` or `cron( )` format.
         DESCRIPTION

property :scheduled_action_description, String,
         callbacks: {
           "scheduled_action_description is not a String" => lambda { |v| v.is_a? String },
           "scheduled_action_description must match pattern ^(?=^[\x09\x0a\x0d\x20-\xff]*$).{1,255}$" => lambda { |v| v =~ Regexp.new("/^(?=^[\x09\x0a\x0d\x20-\xff]*$).{1,255}$/") },
         },
         description: <<~'DESCRIPTION'
           The description of the scheduled action.
         DESCRIPTION

property :scheduled_action_name, String,
         required: true,
         callbacks: {
           "scheduled_action_name is not a String" => lambda { |v| v.is_a? String },
           "scheduled_action_name must match pattern ^(?=^[a-z][a-z0-9]*(-[a-z0-9]+)*$).{1,60}$" => lambda { |v| v =~ Regexp.new("/^(?=^[a-z][a-z0-9]*(-[a-z0-9]+)*$).{1,60}$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the scheduled action. The name must be unique within an account.
         DESCRIPTION

property :start_time, Hash,
         callbacks: {
           "start_time is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The start time in UTC of the scheduled action. Before this time, the scheduled action does not trigger.
         DESCRIPTION

property :target_action, Hash,
         description: <<~'DESCRIPTION'
           A JSON format string of the Amazon Redshift API operation with input parameters.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Redshift::ScheduledAction"
rest_api_document "/AWS::Redshift::ScheduledAction"

rest_property_map({
  enable:                       "Enable",
  end_time:                     "EndTime",
  iam_role:                     "IamRole",
  schedule:                     "Schedule",
  scheduled_action_description: "ScheduledActionDescription",
  scheduled_action_name:        "ScheduledActionName",
  start_time:                   "StartTime",
  target_action:                "TargetAction",
})

rest_post_only_properties %i{
  scheduled_action_name
}
