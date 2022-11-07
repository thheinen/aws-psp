# Import API specifics
use "awscc_base"

resource_name :aws_ec2_vpc
provides :aws_ec2_vpc, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::VPC
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :cidr_block, String,
         callbacks: {
           "cidr_block is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The primary IPv4 CIDR block for the VPC.
         DESCRIPTION

property :enable_dns_hostnames, [TrueClass, FalseClass],
         callbacks: {
           "enable_dns_hostnames is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Indicates whether the instances launched in the VPC get DNS hostnames. If enabled, instances in the VPC get DNS hostnames; otherwise, they do not. Disabled by default for nondefault VPCs.
         DESCRIPTION

property :enable_dns_support, [TrueClass, FalseClass],
         callbacks: {
           "enable_dns_support is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Indicates whether the DNS resolution is supported for the VPC. If enabled, queries to the Amazon provided DNS server at the 169.254.169.253 IP address, or the reserved IP address at the base of the VPC network range "plus two" succeed. If disabled, the Amazon provided DNS service in the VPC that resolves public DNS hostnames to IP addresses is not enabled. Enabled by default.
         DESCRIPTION

property :instance_tenancy, String,
         callbacks: {
           "instance_tenancy is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The allowed tenancy of instances launched into the VPC.
            "default": An instance launched into the VPC runs on shared hardware by default, unless you explicitly specify a different tenancy during instance launch.
            "dedicated": An instance launched into the VPC is a Dedicated Instance by default, unless you explicitly specify a tenancy of host during instance launch. You cannot specify a tenancy of default during instance launch.
            Updating InstanceTenancy requires no replacement only if you are updating its value from "dedicated" to "default". Updating InstanceTenancy from "default" to "dedicated" requires replacement.
         DESCRIPTION

property :ipv4_ipam_pool_id, String,
         callbacks: {
           "ipv4_ipam_pool_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of an IPv4 IPAM pool you want to use for allocating this VPC's CIDR
         DESCRIPTION

property :ipv4_netmask_length, Integer,
         callbacks: {
           "ipv4_netmask_length is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The netmask length of the IPv4 CIDR you want to allocate to this VPC from an Amazon VPC IP Address Manager (IPAM) pool
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags for the VPC.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::VPC"
rest_api_document "/AWS::EC2::VPC"

rest_property_map({
  cidr_block:           "CidrBlock",
  enable_dns_hostnames: "EnableDnsHostnames",
  enable_dns_support:   "EnableDnsSupport",
  instance_tenancy:     "InstanceTenancy",
  ipv4_ipam_pool_id:    "Ipv4IpamPoolId",
  ipv4_netmask_length:  "Ipv4NetmaskLength",
  tags:                 "Tags",
})

rest_post_only_properties %i{
  cidr_block ipv4_ipam_pool_id ipv4_netmask_length
}
