# Import API specifics
use "awscc_base"

resource_name :aws_ec2_nat_gateway
provides :aws_ec2_nat_gateway, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::NatGateway
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :allocation_id, String,
         callbacks: {
           "allocation_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :connectivity_type, String,
         callbacks: {
           "connectivity_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :max_drain_duration_seconds, Integer,
         callbacks: {
           "max_drain_duration_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :private_ip_address, String,
         callbacks: {
           "private_ip_address is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :secondary_allocation_ids, Array,
         callbacks: {
           "secondary_allocation_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :secondary_private_ip_address_count, Integer,
         callbacks: {
           "secondary_private_ip_address_count is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :secondary_private_ip_addresses, Array,
         callbacks: {
           "secondary_private_ip_addresses is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :subnet_id, String,
         required: true,
         callbacks: {
           "subnet_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::EC2::NatGateway"
rest_api_document "/AWS::EC2::NatGateway"

rest_property_map({
  allocation_id:                      "AllocationId",
  connectivity_type:                  "ConnectivityType",
  max_drain_duration_seconds:         "MaxDrainDurationSeconds",
  private_ip_address:                 "PrivateIpAddress",
  secondary_allocation_ids:           "SecondaryAllocationIds",
  secondary_private_ip_address_count: "SecondaryPrivateIpAddressCount",
  secondary_private_ip_addresses:     "SecondaryPrivateIpAddresses",
  subnet_id:                          "SubnetId",
  tags:                               "Tags",
})

rest_post_only_properties %i{
  allocation_id connectivity_type private_ip_address subnet_id
}
