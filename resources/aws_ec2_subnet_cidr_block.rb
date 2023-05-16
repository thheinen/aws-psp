# Import API specifics
use "awscc_base"

resource_name :aws_ec2_subnet_cidr_block
provides :aws_ec2_subnet_cidr_block, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::EC2::SubnetCidrBlock resource creates association between subnet and IPv6 CIDR
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :ipv6_cidr_block, String,
         required: true,
         callbacks: {
           "ipv6_cidr_block is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The IPv6 network range for the subnet, in CIDR notation. The subnet size must use a /64 prefix length
         DESCRIPTION

property :subnet_id, String,
         required: true,
         callbacks: {
           "subnet_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the subnet
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::SubnetCidrBlock"
rest_api_document "/AWS::EC2::SubnetCidrBlock"

rest_property_map({
  ipv6_cidr_block: "Ipv6CidrBlock",
  subnet_id:       "SubnetId",
})

rest_post_only_properties %i{
  ipv6_cidr_block subnet_id
}
