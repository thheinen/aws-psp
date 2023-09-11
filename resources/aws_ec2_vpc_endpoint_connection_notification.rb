# Import API specifics
use "awscc_base"

resource_name :aws_ec2_vpc_endpoint_connection_notification
provides :aws_ec2_vpc_endpoint_connection_notification, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::VPCEndpointConnectionNotification
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :connection_events, Array,
         required: true,
         callbacks: {
           "connection_events is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The endpoint events for which to receive notifications.
         DESCRIPTION

property :connection_notification_arn, String,
         required: true,
         callbacks: {
           "connection_notification_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ARN of the SNS topic for the notifications.
         DESCRIPTION

property :service_id, String,
         callbacks: {
           "service_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the endpoint service.
         DESCRIPTION

property :vpc_endpoint_id, String,
         callbacks: {
           "vpc_endpoint_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the endpoint.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::VPCEndpointConnectionNotification"
rest_api_document "/AWS::EC2::VPCEndpointConnectionNotification"

rest_property_map({
  connection_events:           "ConnectionEvents",
  connection_notification_arn: "ConnectionNotificationArn",
  service_id:                  "ServiceId",
  vpc_endpoint_id:             "VPCEndpointId",
})

rest_post_only_properties %i{
  service_id vpc_endpoint_id
}
