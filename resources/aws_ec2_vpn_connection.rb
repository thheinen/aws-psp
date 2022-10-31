# Import API specifics
use "awscc_base"

resource_name :aws_ec2_vpn_connection
provides :aws_ec2_vpn_connection, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::VPNConnection
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :customer_gateway_id, String,
         required: true,
         callbacks: {
           "customer_gateway_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the customer gateway at your end of the VPN connection.
         DESCRIPTION

property :static_routes_only, [TrueClass, FalseClass],
         callbacks: {
           "static_routes_only is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Indicates whether the VPN connection uses static routes only.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Any tags assigned to the VPN connection.
         DESCRIPTION

property :transitgateway_id, String,
         callbacks: {
           "transitgateway_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the transit gateway associated with the VPN connection.
         DESCRIPTION

property :type, String,
         required: true,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The type of VPN connection.
         DESCRIPTION

property :vpn_gateway_id, String,
         callbacks: {
           "vpn_gateway_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the virtual private gateway at the AWS side of the VPN connection.
         DESCRIPTION

property :vpn_tunnel_options_specifications, Array,
         callbacks: {
           "vpn_tunnel_options_specifications is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tunnel options for the VPN connection.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::VPNConnection"
rest_api_document "/AWS::EC2::VPNConnection"

rest_property_map({
  customer_gateway_id:               "CustomerGatewayId",
  static_routes_only:                "StaticRoutesOnly",
  tags:                              "Tags",
  transitgateway_id:                 "TransitGatewayId",
  type:                              "Type",
  vpn_gateway_id:                    "VpnGatewayId",
  vpn_tunnel_options_specifications: "VpnTunnelOptionsSpecifications",
})

rest_post_only_properties %i{
  customer_gateway_id static_routes_only transitgateway_id type vpn_gateway_id vpn_tunnel_options_specifications
}
