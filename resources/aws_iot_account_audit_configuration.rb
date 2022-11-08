# Import API specifics
use "awscc_base"

resource_name :aws_iot_account_audit_configuration
provides :aws_iot_account_audit_configuration, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Configures the Device Defender audit settings for this account. Settings include how audit notifications are sent and which audit checks are enabled or disabled.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :account_id, String,
         required: true,
         callbacks: {
           "account_id is not a String" => lambda { |v| v.is_a? String },
           "account_id needs to be 12..12 characters" => lambda { |v| v.length >= 12 && v.length <= 12 },
         },
         description: <<~'DESCRIPTION'
           Your 12-digit account ID (used as the primary identifier for the CloudFormation resource).
         DESCRIPTION

property :audit_check_configurations, Hash,
         required: true,
         description: ""

property :audit_notification_target_configurations, Hash,
         description: ""

property :role_arn, String,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
           "role_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
         },
         description: <<~'DESCRIPTION'
           The ARN of the role that grants permission to AWS IoT to access information about your devices, policies, certificates and other items as required when performing an audit.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IoT::AccountAuditConfiguration"
rest_api_document "/AWS::IoT::AccountAuditConfiguration"

rest_property_map({
  account_id:                               "AccountId",
  audit_check_configurations:               "AuditCheckConfigurations",
  audit_notification_target_configurations: "AuditNotificationTargetConfigurations",
  role_arn:                                 "RoleArn",
})

rest_post_only_properties %i{
  account_id
}
