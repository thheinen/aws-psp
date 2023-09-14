# Import API specifics
use "awscc_base"

resource_name :aws_ec2_route
provides :aws_ec2_route, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::Route
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :carrier_gateway_id, String,
         callbacks: {
           "carrier_gateway_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the carrier gateway.
         DESCRIPTION

property :destination_cidr_block, String,
         callbacks: {
           "destination_cidr_block is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The IPv4 CIDR block used for the destination match.
         DESCRIPTION

property :destination_ipv6_cidr_block, String,
         callbacks: {
           "destination_ipv6_cidr_block is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The IPv6 CIDR block used for the destination match.
         DESCRIPTION

property :destination_prefix_list_id, String,
         callbacks: {
           "destination_prefix_list_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of managed prefix list, it's a set of one or more CIDR blocks.
         DESCRIPTION

property :egress_only_internet_gateway_id, String,
         callbacks: {
           "egress_only_internet_gateway_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the egress-only internet gateway.
         DESCRIPTION

property :gateway_id, String,
         callbacks: {
           "gateway_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of an internet gateway or virtual private gateway attached to your VPC.
         DESCRIPTION

property :instance_id, String,
         callbacks: {
           "instance_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of a NAT instance in your VPC.
         DESCRIPTION

property :local_gateway_id, String,
         callbacks: {
           "local_gateway_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the local gateway.
         DESCRIPTION

property :nat_gateway_id, String,
         callbacks: {
           "nat_gateway_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of a NAT gateway.
         DESCRIPTION

property :network_interface_id, String,
         callbacks: {
           "network_interface_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the network interface.
         DESCRIPTION

property :route_table_id, String,
         required: true,
         callbacks: {
           "route_table_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the route table. The routing table must be associated with the same VPC that the virtual private gateway is attached to.
         DESCRIPTION

property :transitgateway_id, String,
         callbacks: {
           "transitgateway_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of a transit gateway.
         DESCRIPTION

property :vpc_endpoint_id, String,
         callbacks: {
           "vpc_endpoint_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of a VPC endpoint. Supported for Gateway Load Balancer endpoints only.
         DESCRIPTION

property :vpc_peering_connection_id, String,
         callbacks: {
           "vpc_peering_connection_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of a VPC peering connection.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::Route"
rest_api_document "/AWS::EC2::Route"

rest_property_map({
  carrier_gateway_id:              "CarrierGatewayId",
  destination_cidr_block:          "DestinationCidrBlock",
  destination_ipv6_cidr_block:     "DestinationIpv6CidrBlock",
  destination_prefix_list_id:      "DestinationPrefixListId",
  egress_only_internet_gateway_id: "EgressOnlyInternetGatewayId",
  gateway_id:                      "GatewayId",
  instance_id:                     "InstanceId",
  local_gateway_id:                "LocalGatewayId",
  nat_gateway_id:                  "NatGatewayId",
  network_interface_id:            "NetworkInterfaceId",
  route_table_id:                  "RouteTableId",
  transitgateway_id:               "TransitGatewayId",
  vpc_endpoint_id:                 "VpcEndpointId",
  vpc_peering_connection_id:       "VpcPeeringConnectionId",
})

rest_post_only_properties %i{
  destination_cidr_block destination_ipv6_cidr_block destination_prefix_list_id route_table_id
}
