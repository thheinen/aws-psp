# Import API specifics
use "awscc_base"

resource_name :aws_networkmanager_customer_gateway_association
provides :aws_networkmanager_customer_gateway_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::NetworkManager::CustomerGatewayAssociation type associates a customer gateway with a device and optionally, with a link.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :customer_gateway_arn, String,
         required: true,
         callbacks: {
           "customer_gateway_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the customer gateway.
         DESCRIPTION

property :device_id, String,
         required: true,
         callbacks: {
           "device_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the device
         DESCRIPTION

property :global_network_id, String,
         required: true,
         callbacks: {
           "global_network_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the global network.
         DESCRIPTION

property :link_id, String,
         callbacks: {
           "link_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the link
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::NetworkManager::CustomerGatewayAssociation"
rest_api_document "/AWS::NetworkManager::CustomerGatewayAssociation"

rest_property_map({
  customer_gateway_arn: "CustomerGatewayArn",
  device_id:            "DeviceId",
  global_network_id:    "GlobalNetworkId",
  link_id:              "LinkId",
})

rest_post_only_properties %i{
  customer_gateway_arn device_id global_network_id link_id
}
