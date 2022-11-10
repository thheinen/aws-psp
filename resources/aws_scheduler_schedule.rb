# Import API specifics
use "awscc_base"

resource_name :aws_scheduler_schedule
provides :aws_scheduler_schedule, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::Scheduler::Schedule Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..512 characters" => lambda { |v| v.length >= 0 && v.length <= 512 },
         },
         description: <<~'DESCRIPTION'
           The description of the schedule.
         DESCRIPTION

property :end_date, String,
         callbacks: {
           "end_date is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The date, in UTC, before which the schedule can invoke its target. Depending on the schedule's recurrence expression, invocations might stop on, or before, the EndDate you specify.
         DESCRIPTION

property :flexible_time_window, Hash,
         required: true,
         callbacks: {
           "Subproperty `MaximumWindowInMinutes` is not a Number" => lambda { |v| v[:MaximumWindowInMinutes].is_a? Number },
         },
         description: ""

property :group_name, String,
         callbacks: {
           "group_name is not a String" => lambda { |v| v.is_a? String },
           "group_name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "group_name must match pattern ^[0-9a-zA-Z-_.]+$" => lambda { |v| v =~ Regexp.new("/^[0-9a-zA-Z-_.]+$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the schedule group to associate with this schedule. If you omit this, the default schedule group is used.
         DESCRIPTION

property :kms_key_arn, String,
         callbacks: {
           "kms_key_arn is not a String" => lambda { |v| v.is_a? String },
           "kms_key_arn needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
           "kms_key_arn must match pattern ^arn:aws(-[a-z]+)?:kms:[a-z0-9\-]+:\d{12}:(key|alias)\/[0-9a-zA-Z-_]*$" => lambda { |v| v =~ Regexp.new("/^arn:aws(-[a-z]+)?:kms:[a-z0-9\-]+:\d{12}:(key|alias)\/[0-9a-zA-Z-_]*$/") },
         },
         description: <<~'DESCRIPTION'
           The ARN for a KMS Key that will be used to encrypt customer data.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "name must match pattern ^[0-9a-zA-Z-_.]+$" => lambda { |v| v =~ Regexp.new("/^[0-9a-zA-Z-_.]+$/") },
         },
         description: ""

property :schedule_expression, String,
         required: true,
         callbacks: {
           "schedule_expression is not a String" => lambda { |v| v.is_a? String },
           "schedule_expression needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
         },
         description: <<~'DESCRIPTION'
           The scheduling expression.
         DESCRIPTION

property :schedule_expression_timezone, String,
         callbacks: {
           "schedule_expression_timezone is not a String" => lambda { |v| v.is_a? String },
           "schedule_expression_timezone needs to be 1..50 characters" => lambda { |v| v.length >= 1 && v.length <= 50 },
         },
         description: <<~'DESCRIPTION'
           The timezone in which the scheduling expression is evaluated.
         DESCRIPTION

property :start_date, String,
         callbacks: {
           "start_date is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The date, in UTC, after which the schedule can begin invoking its target. Depending on the schedule's recurrence expression, invocations might occur on, or after, the StartDate you specify.
         DESCRIPTION

property :state, Hash,
         callbacks: {
           "state is not a String" => lambda { |v| v.is_a? String },
           "stateis not one of `ENABLED`, `DISABLED`" => lambda { |v| %w{ENABLED DISABLED}.include? v },
         },
         description: ""

property :target, Hash,
         required: true,
         callbacks: {
           "Subproperty `Arn` is not a String" => lambda { |v| v[:Arn].is_a? String },
           "Subproperty `Arn` needs to be 1..1600 characters" => lambda { |v| v[:Arn].length >= 1 && v[:Arn].length <= 1600 },
           "Subproperty `Arn`is not a valid ARN" => lambda { |v| v[:Arn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `RoleArn` is not a String" => lambda { |v| v[:RoleArn].is_a? String },
           "Subproperty `RoleArn` needs to be 1..1600 characters" => lambda { |v| v[:RoleArn].length >= 1 && v[:RoleArn].length <= 1600 },
           "Subproperty `RoleArn` must match pattern ^arn:aws(-[a-z]+)?:iam::\d{12}:role\/(service-role\/){0,1}[a-zA-Z0-9\+=,\.@\-_]+$" => lambda { |v| v[:RoleArn] =~ Regexp.new("/^arn:aws(-[a-z]+)?:iam::\d{12}:role\/(service-role\/){0,1}[a-zA-Z0-9\+=,\.@\-_]+$/") },
           "Subproperty `RoleArn`is not a valid ARN" => lambda { |v| v[:RoleArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `Input` is not a String" => lambda { |v| v[:Input].is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Scheduler::Schedule"
rest_api_document "/AWS::Scheduler::Schedule"

rest_property_map({
  description:                  "Description",
  end_date:                     "EndDate",
  flexible_time_window:         "FlexibleTimeWindow",
  group_name:                   "GroupName",
  kms_key_arn:                  "KmsKeyArn",
  name:                         "Name",
  schedule_expression:          "ScheduleExpression",
  schedule_expression_timezone: "ScheduleExpressionTimezone",
  start_date:                   "StartDate",
  state:                        "State",
  target:                       "Target",
})

rest_post_only_properties %i{
  name
}
