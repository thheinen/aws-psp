# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_ec2_eip
provides :aws_ec2_eip, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::EIP
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :domain, String,
         callbacks: {
           "domain is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Indicates whether the Elastic IP address is for use with instances in a VPC or instance in EC2-Classic.
         DESCRIPTION

property :instance_id, String,
         callbacks: {
           "instance_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the instance.
         DESCRIPTION

property :network_border_group, String,
         callbacks: {
           "network_border_group is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A unique set of Availability Zones, Local Zones, or Wavelength Zones from which Amazon Web Services advertises IP addresses.
         DESCRIPTION

property :public_ipv4_pool, String,
         callbacks: {
           "public_ipv4_pool is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of an address pool that you own. Use this parameter to let Amazon EC2 select an address from the address pool.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Any tags assigned to the EIP.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::EIP"
rest_api_document "/AWS::EC2::EIP"

rest_property_map({
  domain:               "Domain",
  instance_id:          "InstanceId",
  network_border_group: "NetworkBorderGroup",
  public_ipv4_pool:     "PublicIpv4Pool",
  tags:                 "Tags",
})

rest_post_only_properties %i{
  domain network_border_group
}