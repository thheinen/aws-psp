# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_datasync_location_f_sx_windows
provides :aws_datasync_location_f_sx_windows, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::DataSync::LocationFSxWindows.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :domain, String,
         callbacks: {
           "domain is not a String" => lambda { |v| v.is_a? String },
           "domain must match pattern ^([A-Za-z0-9]+[A-Za-z0-9-.]*)*[A-Za-z0-9-]*[A-Za-z0-9]$" => lambda { |v| v =~ Regexp.new("/^([A-Za-z0-9]+[A-Za-z0-9-.]*)*[A-Za-z0-9-]*[A-Za-z0-9]$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the Windows domain that the FSx for Windows server belongs to.
         DESCRIPTION

property :fsx_filesystem_arn, String,
         required: true,
         callbacks: {
           "fsx_filesystem_arn is not a String" => lambda { |v| v.is_a? String },
           "fsx_filesystem_arn must match pattern ^arn:(aws|aws-cn|aws-us-gov|aws-iso|aws-iso-b):fsx:[a-z\-0-9]*:[0-9]{12}:file-system/fs-.*$" => lambda { |v| v =~ Regexp.new("/^arn:(aws|aws-cn|aws-us-gov|aws-iso|aws-iso-b):fsx:[a-z\-0-9]*:[0-9]{12}:file-system/fs-.*$/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) for the FSx for Windows file system.
         DESCRIPTION

property :password, String,
         required: true,
         callbacks: {
           "password is not a String" => lambda { |v| v.is_a? String },
           "password must match pattern ^.{0,104}$" => lambda { |v| v =~ Regexp.new("/^.{0,104}$/") },
         },
         description: <<~'DESCRIPTION'
           The password of the user who has the permissions to access files and folders in the FSx for Windows file system.
         DESCRIPTION

property :security_group_arns, Array,
         required: true,
         callbacks: {
           "security_group_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The ARNs of the security groups that are to use to configure the FSx for Windows file system.
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

property :user, String,
         required: true,
         callbacks: {
           "user is not a String" => lambda { |v| v.is_a? String },
           "user must match pattern ^[^\x5B\x5D\\/:;|=,+*?]{1,104}$" => lambda { |v| v =~ Regexp.new("/^[^\x5B\x5D\\/:;|=,+*?]{1,104}$/") },
         },
         description: <<~'DESCRIPTION'
           The user who has the permissions to access files and folders in the FSx for Windows file system.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::DataSync::LocationFSxWindows"
rest_api_document "/AWS::DataSync::LocationFSxWindows"

rest_property_map({
  domain:              "Domain",
  fsx_filesystem_arn:  "FsxFilesystemArn",
  password:            "Password",
  security_group_arns: "SecurityGroupArns",
  subdirectory:        "Subdirectory",
  tags:                "Tags",
  user:                "User",
})

rest_post_only_properties %i{
  domain fsx_filesystem_arn password security_group_arns subdirectory user
}
