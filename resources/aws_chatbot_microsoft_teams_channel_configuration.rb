# Import API specifics
use "awscc_base"

resource_name :aws_chatbot_microsoft_teams_channel_configuration
provides :aws_chatbot_microsoft_teams_channel_configuration, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::Chatbot::MicrosoftTeamsChannelConfiguration.
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
         description: <<~'DESCRIPTION'
           The name of the configuration
         DESCRIPTION

property :guardrail_policies, Array,
         callbacks: {
           "guardrail_policies is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The list of IAM policy ARNs that are applied as channel guardrails. The AWS managed 'AdministratorAccess' policy is applied as a default if this is not set.
         DESCRIPTION

property :iam_role_arn, String,
         required: true,
         callbacks: {
           "iam_role_arn is not a String" => lambda { |v| v.is_a? String },
           "iam_role_arn must match pattern ^arn:(aws[a-zA-Z-]*)?:[A-Za-z0-9][A-Za-z0-9_/.-]{0,62}:[A-Za-z0-9_/.-]{0,63}:[A-Za-z0-9_/.-]{0,63}:[A-Za-z0-9][A-Za-z0-9:_/+=,@.-]{0,1023}$" => lambda { |v| v =~ Regexp.new("/^arn:(aws[a-zA-Z-]*)?:[A-Za-z0-9][A-Za-z0-9_/.-]{0,62}:[A-Za-z0-9_/.-]{0,63}:[A-Za-z0-9_/.-]{0,63}:[A-Za-z0-9][A-Za-z0-9:_/+=,@.-]{0,1023}$/") },
         },
         description: <<~'DESCRIPTION'
           The ARN of the IAM role that defines the permissions for AWS Chatbot
         DESCRIPTION

property :logging_level, String,
         callbacks: {
           "logging_level is not a String" => lambda { |v| v.is_a? String },
           "logging_level must match pattern ^(ERROR|INFO|NONE)$" => lambda { |v| v =~ Regexp.new("/^(ERROR|INFO|NONE)$/") },
         },
         description: <<~'DESCRIPTION'
           Specifies the logging level for this configuration:ERROR,INFO or NONE. This property affects the log entries pushed to Amazon CloudWatch logs
         DESCRIPTION

property :sns_topic_arns, Array,
         callbacks: {
           "sns_topic_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           ARNs of SNS topics which delivers notifications to AWS Chatbot, for example CloudWatch alarm notifications.
         DESCRIPTION

property :team_id, String,
         required: true,
         callbacks: {
           "team_id is not a String" => lambda { |v| v.is_a? String },
           "team_id needs to be 36..36 characters" => lambda { |v| v.length >= 36 && v.length <= 36 },
           "team_id must match pattern ^[0-9A-Fa-f]{8}(?:-[0-9A-Fa-f]{4}){3}-[0-9A-Fa-f]{12}$" => lambda { |v| v =~ Regexp.new("/^[0-9A-Fa-f]{8}(?:-[0-9A-Fa-f]{4}){3}-[0-9A-Fa-f]{12}$/") },
         },
         description: <<~'DESCRIPTION'
           The id of the Microsoft Teams team
         DESCRIPTION

property :teams_channel_id, String,
         required: true,
         callbacks: {
           "teams_channel_id is not a String" => lambda { |v| v.is_a? String },
           "teams_channel_id needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "teams_channel_id must match pattern ^([a-zA-Z0-9-_=+/.,])*%3a([a-zA-Z0-9-_=+/.,])*%40([a-zA-Z0-9-_=+/.,])*$" => lambda { |v| v =~ Regexp.new("/^([a-zA-Z0-9-_=+/.,])*%3a([a-zA-Z0-9-_=+/.,])*%40([a-zA-Z0-9-_=+/.,])*$/") },
         },
         description: <<~'DESCRIPTION'
           The id of the Microsoft Teams channel
         DESCRIPTION

property :teams_tenant_id, String,
         required: true,
         callbacks: {
           "teams_tenant_id is not a String" => lambda { |v| v.is_a? String },
           "teams_tenant_id needs to be 36..36 characters" => lambda { |v| v.length >= 36 && v.length <= 36 },
           "teams_tenant_id must match pattern ^[0-9A-Fa-f]{8}(?:-[0-9A-Fa-f]{4}){3}-[0-9A-Fa-f]{12}$" => lambda { |v| v =~ Regexp.new("/^[0-9A-Fa-f]{8}(?:-[0-9A-Fa-f]{4}){3}-[0-9A-Fa-f]{12}$/") },
         },
         description: <<~'DESCRIPTION'
           The id of the Microsoft Teams tenant
         DESCRIPTION

property :user_role_required, [TrueClass, FalseClass],
         callbacks: {
           "user_role_required is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Enables use of a user role requirement in your chat configuration
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Chatbot::MicrosoftTeamsChannelConfiguration"
rest_api_document "/AWS::Chatbot::MicrosoftTeamsChannelConfiguration"

rest_property_map({
  configuration_name: "ConfigurationName",
  guardrail_policies: "GuardrailPolicies",
  iam_role_arn:       "IamRoleArn",
  logging_level:      "LoggingLevel",
  sns_topic_arns:     "SnsTopicArns",
  team_id:            "TeamId",
  teams_channel_id:   "TeamsChannelId",
  teams_tenant_id:    "TeamsTenantId",
  user_role_required: "UserRoleRequired",
})

rest_post_only_properties %i{
  configuration_name team_id teams_tenant_id
}
