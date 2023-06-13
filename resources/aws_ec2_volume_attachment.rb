# Import API specifics
use "awscc_base"

resource_name :aws_ec2_volume_attachment
provides :aws_ec2_volume_attachment, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::VolumeAttachment
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :device, Hash,
         callbacks: {
           "device is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :instance_id, Hash,
         required: true,
         callbacks: {
           "instance_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :volume_id, Hash,
         required: true,
         callbacks: {
           "volume_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::EC2::VolumeAttachment"
rest_api_document "/AWS::EC2::VolumeAttachment"

rest_property_map({
  device:      "Device",
  instance_id: "InstanceId",
  volume_id:   "VolumeId",
})

rest_post_only_properties %i{
  device instance_id volume_id
}
