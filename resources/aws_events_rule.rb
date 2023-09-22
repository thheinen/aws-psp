# Import API specifics
use "awscc_base"

resource_name :aws_events_rule
provides :aws_events_rule, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Events::Rule
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The description of the rule.
         DESCRIPTION

property :event_bus_name, String,
         callbacks: {
           "event_bus_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name or ARN of the event bus associated with the rule. If you omit this, the default event bus is used.
         DESCRIPTION

property :event_pattern, [String, Hash],
         description: <<~'DESCRIPTION'
           The event pattern of the rule. For more information, see Events and Event Patterns in the Amazon EventBridge User Guide.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the rule.
         DESCRIPTION

property :role_arn, String,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the role that is used for target invocation.
         DESCRIPTION

property :schedule_expression, String,
         callbacks: {
           "schedule_expression is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The scheduling expression. For example, "cron(0 20 * * ? *)", "rate(5 minutes)". For more information, see Creating an Amazon EventBridge rule that runs on a schedule.
         DESCRIPTION

property :state, String,
         callbacks: {
           "state is not a String" => lambda { |v| v.is_a? String },
           "stateis not one of `DISABLED`, `ENABLED`" => lambda { |v| %w{DISABLED ENABLED}.include? v },
         },
         description: <<~'DESCRIPTION'
           The state of the rule.
         DESCRIPTION

property :targets, Array,
         callbacks: {
           "targets is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Adds the specified targets to the specified rule, or updates the targets if they are already associated with the rule.
      Targets are the resources that are invoked when a rule is triggered.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Events::Rule"
rest_api_document "/AWS::Events::Rule"

rest_property_map({
  description:         "Description",
  event_bus_name:      "EventBusName",
  event_pattern:       "EventPattern",
  name:                "Name",
  role_arn:            "RoleArn",
  schedule_expression: "ScheduleExpression",
  state:               "State",
  targets:             "Targets",
})

rest_post_only_properties %i{
  name
}
