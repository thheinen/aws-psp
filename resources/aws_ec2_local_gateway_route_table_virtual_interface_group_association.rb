# Import API specifics
use "awscc_base"

resource_name :aws_ec2_local_gateway_route_table_virtual_interface_group_association
provides :aws_ec2_local_gateway_route_table_virtual_interface_group_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Describes a local gateway route table virtual interface group association for a local gateway.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

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
           The ID of the local gateway route table virtual interface group.
         DESCRIPTION

property :tags, Hash,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags for the local gateway route table virtual interface group association.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::LocalGatewayRouteTableVirtualInterfaceGroupAssociation"
rest_api_document "/AWS::EC2::LocalGatewayRouteTableVirtualInterfaceGroupAssociation"

rest_property_map({
  local_gateway_route_table_id:             "LocalGatewayRouteTableId",
  local_gateway_virtual_interface_group_id: "LocalGatewayVirtualInterfaceGroupId",
  tags:                                     "Tags",
})

rest_post_only_properties %i{
  local_gateway_route_table_id local_gateway_virtual_interface_group_id
}
