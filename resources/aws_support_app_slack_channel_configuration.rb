# Import API specifics
use "awscc_base"

resource_name :aws_support_app_slack_channel_configuration
provides :aws_support_app_slack_channel_configuration, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  An AWS Support App resource that creates, updates, lists and deletes Slack channel configurations.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :channel_id, String,
         required: true,
         callbacks: {
           "channel_id is not a String" => lambda { |v| v.is_a? String },
           "channel_id needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "channel_id must match pattern ^\S+$" => lambda { |v| v =~ Regexp.new("/^\S+$/") },
         },
         description: <<~'DESCRIPTION'
           The channel ID in Slack, which identifies a channel within a workspace.
         DESCRIPTION

property :channel_name, String,
         callbacks: {
           "channel_name is not a String" => lambda { |v| v.is_a? String },
           "channel_name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "channel_name must match pattern ^.+$" => lambda { |v| v =~ Regexp.new("/^.+$/") },
         },
         description: <<~'DESCRIPTION'
           The channel name in Slack.
         DESCRIPTION

property :channel_role_arn, String,
         required: true,
         callbacks: {
           "channel_role_arn is not a String" => lambda { |v| v.is_a? String },
           "channel_role_arn needs to be 31..2048 characters" => lambda { |v| v.length >= 31 && v.length <= 2048 },
           "channel_role_arn must match pattern ^arn:aws[-a-z0-9]*:iam::[0-9]{12}:role\/(.+)$" => lambda { |v| v =~ Regexp.new("/^arn:aws[-a-z0-9]*:iam::[0-9]{12}:role\/(.+)$/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of an IAM role that grants the AWS Support App access to perform operations for AWS services.
         DESCRIPTION

property :notify_on_add_correspondence_to_case, [TrueClass, FalseClass],
         callbacks: {
           "notify_on_add_correspondence_to_case is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Whether to notify when a correspondence is added to a case.
         DESCRIPTION

property :notify_on_case_severity, String,
         required: true,
         callbacks: {
           "notify_on_case_severity is not a String" => lambda { |v| v.is_a? String },
           "notify_on_case_severityis not one of `none`, `all`, `high`" => lambda { |v| %w{none all high}.include? v },
         },
         description: <<~'DESCRIPTION'
           The severity level of a support case that a customer wants to get notified for.
         DESCRIPTION

property :notify_on_create_or_reopen_case, [TrueClass, FalseClass],
         callbacks: {
           "notify_on_create_or_reopen_case is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Whether to notify when a case is created or reopened.
         DESCRIPTION

property :notify_on_resolve_case, [TrueClass, FalseClass],
         callbacks: {
           "notify_on_resolve_case is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Whether to notify when a case is resolved.
         DESCRIPTION

property :team_id, String,
         required: true,
         callbacks: {
           "team_id is not a String" => lambda { |v| v.is_a? String },
           "team_id needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "team_id must match pattern ^\S+$" => lambda { |v| v =~ Regexp.new("/^\S+$/") },
         },
         description: <<~'DESCRIPTION'
           The team ID in Slack, which uniquely identifies a workspace.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SupportApp::SlackChannelConfiguration"
rest_api_document "/AWS::SupportApp::SlackChannelConfiguration"

rest_property_map({
  channel_id:                           "ChannelId",
  channel_name:                         "ChannelName",
  channel_role_arn:                     "ChannelRoleArn",
  notify_on_add_correspondence_to_case: "NotifyOnAddCorrespondenceToCase",
  notify_on_case_severity:              "NotifyOnCaseSeverity",
  notify_on_create_or_reopen_case:      "NotifyOnCreateOrReopenCase",
  notify_on_resolve_case:               "NotifyOnResolveCase",
  team_id:                              "TeamId",
})

rest_post_only_properties %i{
  channel_id team_id
}
