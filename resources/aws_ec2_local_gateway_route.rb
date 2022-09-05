# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_ec2_local_gateway_route
provides :aws_ec2_local_gateway_route, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Describes a route for a local gateway route table.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :destination_cidr_block, String,
         required: true,
         callbacks: {
           "destination_cidr_block is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The CIDR block used for destination matches.
         DESCRIPTION

property :local_gateway_route_table_id, String,
         required: true,
         callbacks: {
           "local_gateway_route_table_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the local gateway route table.
         DESCRIPTION

property :local_gateway_virtual_interface_group_id, String,
         required: true,
         callbacks: {
           "local_gateway_virtual_interface_group_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the virtual interface group.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::LocalGatewayRoute"
rest_api_document "/AWS::EC2::LocalGatewayRoute"

rest_property_map({
  destination_cidr_block:                   "DestinationCidrBlock",
  local_gateway_route_table_id:             "LocalGatewayRouteTableId",
  local_gateway_virtual_interface_group_id: "LocalGatewayVirtualInterfaceGroupId",
})

rest_post_only_properties %i{
  destination_cidr_block local_gateway_route_table_id local_gateway_virtual_interface_group_id
}
