# Import API specifics
use "awscc_base"

resource_name :aws_iot_sitewise_portal
provides :aws_iot_sitewise_portal, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::IoTSiteWise::Portal
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :alarms, Hash,
         callbacks: {
           "Subproperty `AlarmRoleArn` is not a String" => lambda { |v| v[:AlarmRoleArn].is_a? String },
           "Subproperty `AlarmRoleArn`is not a valid ARN" => lambda { |v| v[:AlarmRoleArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `NotificationLambdaArn` is not a String" => lambda { |v| v[:NotificationLambdaArn].is_a? String },
           "Subproperty `NotificationLambdaArn`is not a valid ARN" => lambda { |v| v[:NotificationLambdaArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: "Contains the configuration information of an alarm created in an AWS IoT SiteWise Monitor portal. You can use the alarm to monitor an asset property and get notified when the asset property value is outside a specified range."

property :notification_sender_email, String,
         callbacks: {
           "notification_sender_email is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The email address that sends alarm notifications."

property :portal_auth_mode, String,
         callbacks: {
           "portal_auth_mode is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The service to use to authenticate users to the portal. Choose from SSO or IAM. You can't change this value after you create a portal."

property :portal_contact_email, String,
         required: true,
         callbacks: {
           "portal_contact_email is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The AWS administrator's contact email address."

property :portal_description, String,
         callbacks: {
           "portal_description is not a String" => lambda { |v| v.is_a? String },
         },
         description: "A description for the portal."

property :portal_name, String,
         required: true,
         callbacks: {
           "portal_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: "A friendly name for the portal."

property :role_arn, String,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The ARN of a service role that allows the portal's users to access your AWS IoT SiteWise resources on your behalf."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "A list of key-value pairs that contain metadata for the portal."

# API URLs and mappings
rest_api_collection "/AWS::IoTSiteWise::Portal"
rest_api_document "/AWS::IoTSiteWise::Portal"

rest_property_map({
  alarms:                    "Alarms",
  notification_sender_email: "NotificationSenderEmail",
  portal_auth_mode:          "PortalAuthMode",
  portal_contact_email:      "PortalContactEmail",
  portal_description:        "PortalDescription",
  portal_name:               "PortalName",
  role_arn:                  "RoleArn",
  tags:                      "Tags",
})

rest_post_only_properties %i{
  portal_auth_mode
}
