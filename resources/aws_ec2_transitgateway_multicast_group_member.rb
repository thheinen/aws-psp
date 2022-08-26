# Import API specifics
use "awscc_base"

resource_name :aws_ec2_transitgateway_multicast_group_member
provides :aws_ec2_transitgateway_multicast_group_member, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::EC2::TransitGatewayMulticastGroupMember registers and deregisters members and sources (network interfaces) with the transit gateway multicast group
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :group_ip_address, String,
         required: true,
         callbacks: {
           "group_ip_address is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The IP address assigned to the transit gateway multicast group."

property :network_interface_id, String,
         required: true,
         callbacks: {
           "network_interface_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The ID of the transit gateway attachment."

property :transitgateway_multicast_domain_id, String,
         required: true,
         callbacks: {
           "transitgateway_multicast_domain_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The ID of the transit gateway multicast domain."

# API URLs and mappings
rest_api_collection "/AWS::EC2::TransitGatewayMulticastGroupMember"
rest_api_document "/AWS::EC2::TransitGatewayMulticastGroupMember"

rest_property_map({
  group_ip_address:                   "GroupIpAddress",
  network_interface_id:               "NetworkInterfaceId",
  transitgateway_multicast_domain_id: "TransitGatewayMulticastDomainId",
})

rest_post_only_properties %i{
  group_ip_address network_interface_id transitgateway_multicast_domain_id
}
