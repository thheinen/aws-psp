# Import API specifics
use "awscc_base"

resource_name :aws_ec2_subnet
provides :aws_ec2_subnet, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::Subnet
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :assign_ipv6_address_on_creation, [TrueClass, FalseClass],
         callbacks: {
           "assign_ipv6_address_on_creation is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :availability_zone, String,
         callbacks: {
           "availability_zone is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :availability_zone_id, String,
         callbacks: {
           "availability_zone_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :cidr_block, String,
         callbacks: {
           "cidr_block is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :enable_dns64, [TrueClass, FalseClass],
         callbacks: {
           "enable_dns64 is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :ipv6_cidr_block, String,
         callbacks: {
           "ipv6_cidr_block is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :ipv6_native, [TrueClass, FalseClass],
         callbacks: {
           "ipv6_native is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :map_public_ip_on_launch, [TrueClass, FalseClass],
         callbacks: {
           "map_public_ip_on_launch is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :outpost_arn, String,
         callbacks: {
           "outpost_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :private_dns_name_options_on_launch, Hash,
         callbacks: {
           "Subproperty `HostnameType` is not a String" => lambda { |v| v[:HostnameType].is_a? String },
           "Subproperty `EnableResourceNameDnsARecord` is not a Boolean" => lambda { |v| v[:EnableResourceNameDnsARecord].is_a? Boolean },
           "Subproperty `EnableResourceNameDnsAAAARecord` is not a Boolean" => lambda { |v| v[:EnableResourceNameDnsAAAARecord].is_a? Boolean },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :vpc_id, String,
         required: true,
         callbacks: {
           "vpc_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::EC2::Subnet"
rest_api_document "/AWS::EC2::Subnet"

rest_property_map({
  assign_ipv6_address_on_creation:    "AssignIpv6AddressOnCreation",
  availability_zone:                  "AvailabilityZone",
  availability_zone_id:               "AvailabilityZoneId",
  cidr_block:                         "CidrBlock",
  enable_dns64:                       "EnableDns64",
  ipv6_cidr_block:                    "Ipv6CidrBlock",
  ipv6_native:                        "Ipv6Native",
  map_public_ip_on_launch:            "MapPublicIpOnLaunch",
  outpost_arn:                        "OutpostArn",
  private_dns_name_options_on_launch: "PrivateDnsNameOptionsOnLaunch",
  tags:                               "Tags",
  vpc_id:                             "VpcId",
})

rest_post_only_properties %i{
  availability_zone availability_zone_id cidr_block ipv6_native outpost_arn vpc_id
}
