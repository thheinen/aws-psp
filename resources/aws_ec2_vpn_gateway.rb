# Import API specifics
use "awscc_base"

resource_name :aws_ec2_vpn_gateway
provides :aws_ec2_vpn_gateway, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Schema for EC2 VPN Gateway
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :amazon_side_asn, Integer,
         callbacks: {
           "amazon_side_asn is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "The private Autonomous System Number (ASN) for the Amazon side of a BGP session."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "Any tags assigned to the virtual private gateway."

property :type, String,
         required: true,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The type of VPN connection the virtual private gateway supports."

# API URLs and mappings
rest_api_collection "/AWS::EC2::VPNGateway"
rest_api_document "/AWS::EC2::VPNGateway"

rest_property_map({
  amazon_side_asn: "AmazonSideAsn",
  tags:            "Tags",
  type:            "Type",
})

rest_post_only_properties %i{
  amazon_side_asn type
}
