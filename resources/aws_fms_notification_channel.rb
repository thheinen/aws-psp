# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_fms_notification_channel
provides :aws_fms_notification_channel, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Designates the IAM role and Amazon Simple Notification Service (SNS) topic that AWS Firewall Manager uses to record SNS logs.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :sns_role_name, Hash,
         required: true,
         callbacks: {
           "sns_role_name is not a String" => lambda { |v| v.is_a? String },
           "sns_role_name needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
           "sns_role_name must match pattern ^([^\s]+)$" => lambda { |v| v =~ Regexp.new("/^([^\s]+)$/") },
         },
         description: ""

property :sns_topic_arn, Hash,
         required: true,
         callbacks: {
           "sns_topic_arn is not a String" => lambda { |v| v.is_a? String },
           "sns_topic_arn needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
           "sns_topic_arn must match pattern ^([^\s]+)$" => lambda { |v| v =~ Regexp.new("/^([^\s]+)$/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::FMS::NotificationChannel"
rest_api_document "/AWS::FMS::NotificationChannel"

rest_property_map({
  sns_role_name: "SnsRoleName",
  sns_topic_arn: "SnsTopicArn",
})

