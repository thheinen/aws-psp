# Import API specifics
use "awscc_base"

resource_name :aws_efs_access_point
provides :aws_efs_access_point, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EFS::AccessPoint
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :access_point_tags, Array,
         callbacks: {
           "access_point_tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :client_token, String,
         callbacks: {
           "client_token is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           (optional) A string of up to 64 ASCII characters that Amazon EFS uses to ensure idempotent creation.
         DESCRIPTION

property :file_system_id, String,
         required: true,
         callbacks: {
           "file_system_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the EFS file system that the access point provides access to.
         DESCRIPTION

property :posix_user, Hash,
         callbacks: {
           "Subproperty `Uid` is not a String" => lambda { |v| v[:Uid].is_a? String },
           "Subproperty `Gid` is not a String" => lambda { |v| v[:Gid].is_a? String },
           "Subproperty `SecondaryGids` is not a Array" => lambda { |v| v[:SecondaryGids].is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The operating system user and group applied to all file system requests made using the access point.
         DESCRIPTION

property :root_directory, Hash,
         callbacks: {
           "Subproperty `Path` is not a String" => lambda { |v| v[:Path].is_a? String },
           "Subproperty `Path` needs to be 1..100 characters" => lambda { |v| v[:Path].length >= 1 && v[:Path].length <= 100 },
         },
         description: <<~'DESCRIPTION'
           Specifies the directory on the Amazon EFS file system that the access point exposes as the root directory of your file system to NFS clients using the access point. The clients using the access point can only access the root directory and below. If the RootDirectory>Path specified does not exist, EFS creates it and applies the CreationInfo settings when a client connects to an access point. When specifying a RootDirectory, you need to provide the Path, and the CreationInfo is optional.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EFS::AccessPoint"
rest_api_document "/AWS::EFS::AccessPoint"

rest_property_map({
  access_point_tags: "AccessPointTags",
  client_token:      "ClientToken",
  file_system_id:    "FileSystemId",
  posix_user:        "PosixUser",
  root_directory:    "RootDirectory",
})

rest_post_only_properties %i{
  client_token creation_info creation_info/owner_gid creation_info/owner_uid creation_info/permissions file_system_id posix_user posix_user/gid posix_user/secondary_gids posix_user/uid root_directory root_directory/creation_info root_directory/path
}
