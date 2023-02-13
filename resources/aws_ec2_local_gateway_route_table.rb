# Import API specifics
use "awscc_base"

resource_name :aws_ec2_local_gateway_route_table
provides :aws_ec2_local_gateway_route_table, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Describes a route table for a local gateway.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :local_gateway_id, String,
         required: true,
         callbacks: {
           "local_gateway_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the local gateway.
         DESCRIPTION

property :mode, String,
         callbacks: {
           "mode is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The mode of the local gateway route table.
         DESCRIPTION

property :tags, Hash,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags for the local gateway route table.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::LocalGatewayRouteTable"
rest_api_document "/AWS::EC2::LocalGatewayRouteTable"

rest_property_map({
  local_gateway_id: "LocalGatewayId",
  mode:             "Mode",
  tags:             "Tags",
})

rest_post_only_properties %i{
  local_gateway_id mode
}
