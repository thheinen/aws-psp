# Import API specifics
use "awscc_base"

resource_name :aws_ec2_network_interface_attachment
provides :aws_ec2_network_interface_attachment, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::NetworkInterfaceAttachment
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :delete_on_termination, [TrueClass, FalseClass],
         callbacks: {
           "delete_on_termination is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Whether to delete the network interface when the instance terminates. By default, this value is set to true.
         DESCRIPTION

property :device_index, String,
         required: true,
         callbacks: {
           "device_index is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The network interface's position in the attachment order. For example, the first attached network interface has a DeviceIndex of 0.
         DESCRIPTION

property :instance_id, String,
         required: true,
         callbacks: {
           "instance_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the instance to which you will attach the ENI.
         DESCRIPTION

property :network_interface_id, String,
         required: true,
         callbacks: {
           "network_interface_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the ENI that you want to attach.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::NetworkInterfaceAttachment"
rest_api_document "/AWS::EC2::NetworkInterfaceAttachment"

rest_property_map({
  delete_on_termination: "DeleteOnTermination",
  device_index:          "DeviceIndex",
  instance_id:           "InstanceId",
  network_interface_id:  "NetworkInterfaceId",
})

rest_post_only_properties %i{
  device_index instance_id network_interface_id
}
