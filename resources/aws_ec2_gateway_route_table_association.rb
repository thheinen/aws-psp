# Import API specifics
use "awscc_base"

resource_name :aws_ec2_gateway_route_table_association
provides :aws_ec2_gateway_route_table_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Associates a gateway with a route table. The gateway and route table must be in the same VPC. This association causes the incoming traffic to the gateway to be routed according to the routes in the route table.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :gateway_id, String,
         required: true,
         callbacks: {
           "gateway_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the gateway.
         DESCRIPTION

property :route_table_id, String,
         required: true,
         callbacks: {
           "route_table_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the route table.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::GatewayRouteTableAssociation"
rest_api_document "/AWS::EC2::GatewayRouteTableAssociation"

rest_property_map({
  gateway_id:     "GatewayId",
  route_table_id: "RouteTableId",
})

rest_post_only_properties %i{
  gateway_id
}
