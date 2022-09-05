# Import API specifics
use "awscc_base"

resource_name :aws_ec2_customer_gateway
provides :aws_ec2_customer_gateway, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::CustomerGateway
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :bgp_asn, Integer,
         required: true,
         callbacks: {
           "bgp_asn is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           For devices that support BGP, the customer gateway's BGP ASN.
         DESCRIPTION

property :ip_address, String,
         required: true,
         callbacks: {
           "ip_address is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The internet-routable IP address for the customer gateway's outside interface. The address must be static.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           One or more tags for the customer gateway.
         DESCRIPTION

property :type, String,
         required: true,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The type of VPN connection that this customer gateway supports.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::CustomerGateway"
rest_api_document "/AWS::EC2::CustomerGateway"

rest_property_map({
  bgp_asn:    "BgpAsn",
  ip_address: "IpAddress",
  tags:       "Tags",
  type:       "Type",
})

rest_post_only_properties %i{
  bgp_asn ip_address type
}
