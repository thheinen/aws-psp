# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_logs_subscription_filter
provides :aws_logs_subscription_filter, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  An example resource schema demonstrating some basic constructs and validation rules.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :destination_arn, String,
         required: true,
         callbacks: {
           "destination_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the destination.
         DESCRIPTION

property :filter_pattern, String,
         required: true,
         callbacks: {
           "filter_pattern is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The filtering expressions that restrict what gets delivered to the destination AWS resource.
         DESCRIPTION

property :log_group_name, String,
         required: true,
         callbacks: {
           "log_group_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Existing log group that you want to associate with this filter.
         DESCRIPTION

property :role_arn, String,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ARN of an IAM role that grants CloudWatch Logs permissions to deliver ingested log events to the destination stream. You don't need to provide the ARN when you are working with a logical destination for cross-account delivery.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Logs::SubscriptionFilter"
rest_api_document "/AWS::Logs::SubscriptionFilter"

rest_property_map({
  destination_arn: "DestinationArn",
  filter_pattern:  "FilterPattern",
  log_group_name:  "LogGroupName",
  role_arn:        "RoleArn",
})

rest_post_only_properties %i{
  destination_arn filter_pattern log_group_name role_arn
}
