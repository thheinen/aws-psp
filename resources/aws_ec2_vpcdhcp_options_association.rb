# Import API specifics
use "awscc_base"

resource_name :aws_ec2_vpcdhcp_options_association
provides :aws_ec2_vpcdhcp_options_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Associates a set of DHCP options with a VPC, or associates no DHCP options with the VPC.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :dhcp_options_id, String,
         required: true,
         callbacks: {
           "dhcp_options_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The ID of the DHCP options set, or default to associate no DHCP options with the VPC."

property :vpc_id, String,
         required: true,
         callbacks: {
           "vpc_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The ID of the VPC."

# API URLs and mappings
rest_api_collection "/AWS::EC2::VPCDHCPOptionsAssociation"
rest_api_document "/AWS::EC2::VPCDHCPOptionsAssociation"

rest_property_map({
  dhcp_options_id: "DhcpOptionsId",
  vpc_id:          "VpcId",
})

rest_post_only_properties %i{
  dhcp_options_id vpc_id
}
