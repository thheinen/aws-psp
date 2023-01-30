# Import API specifics
use "awscc_base"

resource_name :aws_ec2_ipam_pool_cidr
provides :aws_ec2_ipam_pool_cidr, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Schema of AWS::EC2::IPAMPoolCidr Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :cidr, String,
         callbacks: {
           "cidr is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Represents a single IPv4 or IPv6 CIDR
         DESCRIPTION

property :ipam_pool_id, String,
         required: true,
         callbacks: {
           "ipam_pool_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Id of the IPAM Pool.
         DESCRIPTION

property :netmask_length, Integer,
         callbacks: {
           "netmask_length is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The desired netmask length of the provision. If set, IPAM will choose a block of free space with this size and return the CIDR representing it.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::IPAMPoolCidr"
rest_api_document "/AWS::EC2::IPAMPoolCidr"

rest_property_map({
  cidr:           "Cidr",
  ipam_pool_id:   "IpamPoolId",
  netmask_length: "NetmaskLength",
})

rest_post_only_properties %i{
  cidr ipam_pool_id netmask_length
}
