# Import API specifics
use "awscc_base"

resource_name :aws_autoscaling_scheduled_action
provides :aws_autoscaling_scheduled_action, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::AutoScaling::ScheduledAction resource specifies an Amazon EC2 Auto Scaling scheduled action so that the Auto Scaling group can change the number of instances available for your application in response to predictable load changes.
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
           The name of the Auto Scaling group.
         DESCRIPTION

property :desired_capacity, Integer,
         callbacks: {
           "desired_capacity is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The desired capacity is the initial capacity of the Auto Scaling group after the scheduled action runs and the capacity it attempts to maintain.
         DESCRIPTION

property :end_time, String,
         callbacks: {
           "end_time is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The latest scheduled start time to return. If scheduled action names are provided, this parameter is ignored.
         DESCRIPTION

property :max_size, Integer,
         callbacks: {
           "max_size is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The minimum size of the Auto Scaling group.
         DESCRIPTION

property :min_size, Integer,
         callbacks: {
           "min_size is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The minimum size of the Auto Scaling group.
         DESCRIPTION

property :recurrence, String,
         callbacks: {
           "recurrence is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The recurring schedule for the action, in Unix cron syntax format. When StartTime and EndTime are specified with Recurrence , they form the boundaries of when the recurring action starts and stops.
         DESCRIPTION

property :start_time, String,
         callbacks: {
           "start_time is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The earliest scheduled start time to return. If scheduled action names are provided, this parameter is ignored.
         DESCRIPTION

property :time_zone, String,
         callbacks: {
           "time_zone is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The time zone for the cron expression.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::AutoScaling::ScheduledAction"
rest_api_document "/AWS::AutoScaling::ScheduledAction"

rest_property_map({
  autoscaling_group_name: "AutoScalingGroupName",
  desired_capacity:       "DesiredCapacity",
  end_time:               "EndTime",
  max_size:               "MaxSize",
  min_size:               "MinSize",
  recurrence:             "Recurrence",
  start_time:             "StartTime",
  time_zone:              "TimeZone",
})

rest_post_only_properties %i{
  autoscaling_group_name
}
