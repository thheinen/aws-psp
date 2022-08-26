# Import API specifics
use "awscc_base"

resource_name :aws_efs_mount_target
provides :aws_efs_mount_target, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EFS::MountTarget
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :file_system_id, String,
         required: true,
         callbacks: {
           "file_system_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :ip_address, String,
         callbacks: {
           "ip_address is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :security_groups, Array,
         required: true,
         callbacks: {
           "security_groups is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :subnet_id, String,
         required: true,
         callbacks: {
           "subnet_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::EFS::MountTarget"
rest_api_document "/AWS::EFS::MountTarget"

rest_property_map({
  file_system_id:  "FileSystemId",
  ip_address:      "IpAddress",
  security_groups: "SecurityGroups",
  subnet_id:       "SubnetId",
})

rest_post_only_properties %i{
  file_system_id ip_address subnet_id
}
