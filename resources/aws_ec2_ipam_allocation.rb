# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_ec2_ipam_allocation
provides :aws_ec2_ipam_allocation, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Schema of AWS::EC2::IPAMAllocation Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :cidr, Hash,
         callbacks: {
           "cidr is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

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
           The desired netmask length of the allocation. If set, IPAM will choose a block of free space with this size and return the CIDR representing it.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::IPAMAllocation"
rest_api_document "/AWS::EC2::IPAMAllocation"

rest_property_map({
  cidr:           "Cidr",
  description:    "Description",
  ipam_pool_id:   "IpamPoolId",
  netmask_length: "NetmaskLength",
})

rest_post_only_properties %i{
  cidr description ipam_pool_id netmask_length
}
