# Import API specifics
use "awscc_base"

resource_name :aws_ec2_transitgateway_route_table
provides :aws_ec2_transitgateway_route_table, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::TransitGatewayRouteTable
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Tags are composed of a Key/Value pair. You can use tags to categorize and track each parameter group. The tag value null is permitted.
         DESCRIPTION

property :transitgateway_id, String,
         required: true,
         callbacks: {
           "transitgateway_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the transit gateway.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::TransitGatewayRouteTable"
rest_api_document "/AWS::EC2::TransitGatewayRouteTable"

rest_property_map({
  tags:              "Tags",
  transitgateway_id: "TransitGatewayId",
})

rest_post_only_properties %i{
  tags transitgateway_id
}
