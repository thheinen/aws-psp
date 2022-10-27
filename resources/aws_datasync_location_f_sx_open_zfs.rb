# Import API specifics
use "awscc_base"

resource_name :aws_datasync_location_f_sx_open_zfs
provides :aws_datasync_location_f_sx_open_zfs, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::DataSync::LocationFSxOpenZFS.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :fsx_filesystem_arn, String,
         required: true,
         callbacks: {
           "fsx_filesystem_arn is not a String" => lambda { |v| v.is_a? String },
           "fsx_filesystem_arn must match pattern ^arn:(aws|aws-cn|aws-us-gov|aws-iso|aws-iso-b):fsx:[a-z\-0-9]+:[0-9]{12}:file-system/fs-[0-9a-f]+$" => lambda { |v| v =~ Regexp.new("/^arn:(aws|aws-cn|aws-us-gov|aws-iso|aws-iso-b):fsx:[a-z\-0-9]+:[0-9]{12}:file-system/fs-[0-9a-f]+$/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) for the FSx OpenZFS file system.
         DESCRIPTION

property :protocol, Hash,
         required: true,
         description: ""

property :security_group_arns, Array,
         required: true,
         callbacks: {
           "security_group_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The ARNs of the security groups that are to use to configure the FSx OpenZFS file system.
         DESCRIPTION

property :subdirectory, String,
         callbacks: {
           "subdirectory is not a String" => lambda { |v| v.is_a? String },
           "subdirectory must match pattern ^[a-zA-Z0-9_\-\+\./\(\)\$\p{Zs}]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_\-\+\./\(\)\$\p{Zs}]+$/") },
         },
         description: <<~'DESCRIPTION'
           A subdirectory in the location's path.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::DataSync::LocationFSxOpenZFS"
rest_api_document "/AWS::DataSync::LocationFSxOpenZFS"

rest_property_map({
  fsx_filesystem_arn:  "FsxFilesystemArn",
  protocol:            "Protocol",
  security_group_arns: "SecurityGroupArns",
  subdirectory:        "Subdirectory",
  tags:                "Tags",
})

rest_post_only_properties %i{
  fsx_filesystem_arn protocol security_group_arns subdirectory
}
