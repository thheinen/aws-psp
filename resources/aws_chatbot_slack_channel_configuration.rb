# Import API specifics
use "awscc_base"

resource_name :aws_chatbot_slack_channel_configuration
provides :aws_chatbot_slack_channel_configuration, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::Chatbot::SlackChannelConfiguration.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :configuration_name, String,
         required: true,
         callbacks: {
           "configuration_name is not a String" => lambda { |v| v.is_a? String },
           "configuration_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "configuration_name must match pattern ^[A-Za-z0-9-_]+$" => lambda { |v| v =~ Regexp.new("/^[A-Za-z0-9-_]+$/") },
         },
         description: "The name of the configuration"

property :guardrail_policies, Array,
         callbacks: {
           "guardrail_policies is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The list of IAM policy ARNs that are applied as channel guardrails. The AWS managed 'AdministratorAccess' policy is applied as a default if this is not set."

property :iam_role_arn, String,
         required: true,
         callbacks: {
           "iam_role_arn is not a String" => lambda { |v| v.is_a? String },
           "iam_role_arn must match pattern ^arn:(aws[a-zA-Z-]*)?:[A-Za-z0-9][A-Za-z0-9_/.-]{0,62}:[A-Za-z0-9_/.-]{0,63}:[A-Za-z0-9_/.-]{0,63}:[A-Za-z0-9][A-Za-z0-9:_/+=,@.-]{0,1023}$" => lambda { |v| v =~ Regexp.new("/^arn:(aws[a-zA-Z-]*)?:[A-Za-z0-9][A-Za-z0-9_/.-]{0,62}:[A-Za-z0-9_/.-]{0,63}:[A-Za-z0-9_/.-]{0,63}:[A-Za-z0-9][A-Za-z0-9:_/+=,@.-]{0,1023}$/") },
         },
         description: "The ARN of the IAM role that defines the permissions for AWS Chatbot"

property :logging_level, String,
         callbacks: {
           "logging_level is not a String" => lambda { |v| v.is_a? String },
           "logging_level must match pattern ^(ERROR|INFO|NONE)$" => lambda { |v| v =~ Regexp.new("/^(ERROR|INFO|NONE)$/") },
         },
         description: "Specifies the logging level for this configuration:ERROR,INFO or NONE. This property affects the log entries pushed to Amazon CloudWatch logs"

property :slack_channel_id, String,
         required: true,
         callbacks: {
           "slack_channel_id is not a String" => lambda { |v| v.is_a? String },
           "slack_channel_id needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "slack_channel_id must match pattern ^[A-Za-z0-9]+$" => lambda { |v| v =~ Regexp.new("/^[A-Za-z0-9]+$/") },
         },
         description: "The id of the Slack channel"

property :slack_workspace_id, String,
         required: true,
         callbacks: {
           "slack_workspace_id is not a String" => lambda { |v| v.is_a? String },
           "slack_workspace_id needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "slack_workspace_id must match pattern ^[0-9A-Z]{1,255}$" => lambda { |v| v =~ Regexp.new("/^[0-9A-Z]{1,255}$/") },
         },
         description: "The id of the Slack workspace"

property :sns_topic_arns, Array,
         callbacks: {
           "sns_topic_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "ARNs of SNS topics which delivers notifications to AWS Chatbot, for example CloudWatch alarm notifications."

property :user_role_required, [TrueClass, FalseClass],
         callbacks: {
           "user_role_required is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: "Enables use of a user role requirement in your chat configuration"

# API URLs and mappings
rest_api_collection "/AWS::Chatbot::SlackChannelConfiguration"
rest_api_document "/AWS::Chatbot::SlackChannelConfiguration"

rest_property_map({
  configuration_name: "ConfigurationName",
  guardrail_policies: "GuardrailPolicies",
  iam_role_arn:       "IamRoleArn",
  logging_level:      "LoggingLevel",
  slack_channel_id:   "SlackChannelId",
  slack_workspace_id: "SlackWorkspaceId",
  sns_topic_arns:     "SnsTopicArns",
  user_role_required: "UserRoleRequired",
})

rest_post_only_properties %i{
  configuration_name slack_workspace_id
}
