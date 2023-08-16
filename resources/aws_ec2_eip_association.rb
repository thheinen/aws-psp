# Import API specifics
use "awscc_base"

resource_name :aws_ec2_eip_association
provides :aws_ec2_eip_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for EC2 EIP association.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :allocation_id, String,
         callbacks: {
           "allocation_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The allocation ID. This is required for EC2-VPC.
         DESCRIPTION

property :eip, String,
         callbacks: {
           "eip is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Elastic IP address to associate with the instance.
         DESCRIPTION

property :instance_id, String,
         callbacks: {
           "instance_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the instance.
         DESCRIPTION

property :network_interface_id, String,
         callbacks: {
           "network_interface_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the network interface.
         DESCRIPTION

property :private_ip_address, String,
         callbacks: {
           "private_ip_address is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The primary or secondary private IP address to associate with the Elastic IP address.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::EIPAssociation"
rest_api_document "/AWS::EC2::EIPAssociation"

rest_property_map({
  allocation_id:        "AllocationId",
  eip:                  "EIP",
  instance_id:          "InstanceId",
  network_interface_id: "NetworkInterfaceId",
  private_ip_address:   "PrivateIpAddress",
})

rest_post_only_properties %i{
  allocation_id eip instance_id network_interface_id private_ip_address
}
