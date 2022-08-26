# Import API specifics
use "awscc_base"

resource_name :aws_datasync_location_f_sx_lustre
provides :aws_datasync_location_f_sx_lustre, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::DataSync::LocationFSxLustre.
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
         description: "The Amazon Resource Name (ARN) for the FSx for Lustre file system."

property :security_group_arns, Array,
         required: true,
         callbacks: {
           "security_group_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The ARNs of the security groups that are to use to configure the FSx for Lustre file system."

property :subdirectory, String,
         callbacks: {
           "subdirectory is not a String" => lambda { |v| v.is_a? String },
           "subdirectory must match pattern ^[a-zA-Z0-9_\-\+\./\(\)\$\p{Zs}]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_\-\+\./\(\)\$\p{Zs}]+$/") },
         },
         description: "A subdirectory in the location's path."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "An array of key-value pairs to apply to this resource."

# API URLs and mappings
rest_api_collection "/AWS::DataSync::LocationFSxLustre"
rest_api_document "/AWS::DataSync::LocationFSxLustre"

rest_property_map({
  fsx_filesystem_arn:  "FsxFilesystemArn",
  security_group_arns: "SecurityGroupArns",
  subdirectory:        "Subdirectory",
  tags:                "Tags",
})

rest_post_only_properties %i{
  fsx_filesystem_arn security_group_arns subdirectory
}
