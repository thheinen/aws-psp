# Import API specifics
use "awscc_base"

resource_name :aws_ec2_vpn_connection_route
provides :aws_ec2_vpn_connection_route, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::VPNConnectionRoute
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
           The CIDR block associated with the local subnet of the customer network.
         DESCRIPTION

property :vpn_connection_id, String,
         required: true,
         callbacks: {
           "vpn_connection_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the VPN connection.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::VPNConnectionRoute"
rest_api_document "/AWS::EC2::VPNConnectionRoute"

rest_property_map({
  destination_cidr_block: "DestinationCidrBlock",
  vpn_connection_id:      "VpnConnectionId",
})

rest_post_only_properties %i{
  destination_cidr_block vpn_connection_id
}
