# Import API specifics
use "awscc_base"

resource_name :aws_datasync_location_efs
provides :aws_datasync_location_efs, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::DataSync::LocationEFS.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :access_point_arn, String,
         callbacks: {
           "access_point_arn is not a String" => lambda { |v| v.is_a? String },
           "access_point_arn must match pattern ^arn:(aws|aws-cn|aws-us-gov|aws-iso|aws-iso-b):elasticfilesystem:[a-z\-0-9]+:[0-9]{12}:access-point/fsap-[0-9a-f]{8,40}$" => lambda { |v| v =~ Regexp.new("/^arn:(aws|aws-cn|aws-us-gov|aws-iso|aws-iso-b):elasticfilesystem:[a-z\-0-9]+:[0-9]{12}:access-point/fsap-[0-9a-f]{8,40}$/") },
         },
         description: "The Amazon Resource Name (ARN) for the Amazon EFS Access point that DataSync uses when accessing the EFS file system."

property :ec2_config, Hash,
         required: true,
         callbacks: {
           "Subproperty `SecurityGroupArns` is not a Array" => lambda { |v| v[:SecurityGroupArns].is_a? Array },
           "Subproperty `SubnetArn` is not a String" => lambda { |v| v[:SubnetArn].is_a? String },
           "Subproperty `SubnetArn` must match pattern ^arn:(aws|aws-cn|aws-us-gov|aws-iso|aws-iso-b):ec2:[a-z\-0-9]*:[0-9]{12}:subnet/.*$" => lambda { |v| v[:SubnetArn] =~ Regexp.new("/^arn:(aws|aws-cn|aws-us-gov|aws-iso|aws-iso-b):ec2:[a-z\-0-9]*:[0-9]{12}:subnet/.*$/") },
           "Subproperty `SubnetArn`is not a valid ARN" => lambda { |v| v[:SubnetArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: ""

property :efs_filesystem_arn, String,
         required: true,
         callbacks: {
           "efs_filesystem_arn is not a String" => lambda { |v| v.is_a? String },
           "efs_filesystem_arn must match pattern ^arn:(aws|aws-cn|aws-us-gov|aws-iso|aws-iso-b):elasticfilesystem:[a-z\-0-9]*:[0-9]{12}:file-system/fs-.*$" => lambda { |v| v =~ Regexp.new("/^arn:(aws|aws-cn|aws-us-gov|aws-iso|aws-iso-b):elasticfilesystem:[a-z\-0-9]*:[0-9]{12}:file-system/fs-.*$/") },
         },
         description: "The Amazon Resource Name (ARN) for the Amazon EFS file system."

property :file_system_access_role_arn, String,
         callbacks: {
           "file_system_access_role_arn is not a String" => lambda { |v| v.is_a? String },
           "file_system_access_role_arn must match pattern ^arn:(aws|aws-cn|aws-us-gov|aws-iso|aws-iso-b):iam::[0-9]{12}:role/.*$" => lambda { |v| v =~ Regexp.new("/^arn:(aws|aws-cn|aws-us-gov|aws-iso|aws-iso-b):iam::[0-9]{12}:role/.*$/") },
         },
         description: "The Amazon Resource Name (ARN) of the AWS IAM role that the DataSync will assume when mounting the EFS file system."

property :in_transit_encryption, String,
         callbacks: {
           "in_transit_encryption is not a String" => lambda { |v| v.is_a? String },
           "in_transit_encryptionis not one of `NONE`, `TLS1_2`" => lambda { |v| %w{NONE TLS1_2}.include? v },
         },
         description: "Protocol that is used for encrypting the traffic exchanged between the DataSync Agent and the EFS file system."

property :subdirectory, String,
         callbacks: {
           "subdirectory is not a String" => lambda { |v| v.is_a? String },
           "subdirectory must match pattern ^[a-zA-Z0-9_\-\+\./\(\)\$\p{Zs}]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_\-\+\./\(\)\$\p{Zs}]+$/") },
         },
         description: "A subdirectory in the location's path. This subdirectory in the EFS file system is used to read data from the EFS source location or write data to the EFS destination."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "An array of key-value pairs to apply to this resource."

# API URLs and mappings
rest_api_collection "/AWS::DataSync::LocationEFS"
rest_api_document "/AWS::DataSync::LocationEFS"

rest_property_map({
  access_point_arn:            "AccessPointArn",
  ec2_config:                  "Ec2Config",
  efs_filesystem_arn:          "EfsFilesystemArn",
  file_system_access_role_arn: "FileSystemAccessRoleArn",
  in_transit_encryption:       "InTransitEncryption",
  subdirectory:                "Subdirectory",
  tags:                        "Tags",
})

rest_post_only_properties %i{
  access_point_arn ec2_config efs_filesystem_arn file_system_access_role_arn in_transit_encryption subdirectory
}
