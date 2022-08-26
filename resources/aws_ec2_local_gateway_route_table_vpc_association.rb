# Import API specifics
use "awscc_base"

resource_name :aws_ec2_local_gateway_route_table_vpc_association
provides :aws_ec2_local_gateway_route_table_vpc_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Describes an association between a local gateway route table and a VPC.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :local_gateway_route_table_id, String,
         required: true,
         callbacks: {
           "local_gateway_route_table_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The ID of the local gateway route table."

property :tags, Hash,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The tags for the association."

property :vpc_id, String,
         required: true,
         callbacks: {
           "vpc_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The ID of the VPC."

# API URLs and mappings
rest_api_collection "/AWS::EC2::LocalGatewayRouteTableVPCAssociation"
rest_api_document "/AWS::EC2::LocalGatewayRouteTableVPCAssociation"

rest_property_map({
  local_gateway_route_table_id: "LocalGatewayRouteTableId",
  tags:                         "Tags",
  vpc_id:                       "VpcId",
})

rest_post_only_properties %i{
  local_gateway_route_table_id vpc_id
}
