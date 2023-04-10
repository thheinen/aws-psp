# Import API specifics
use "awscc_base"

resource_name :aws_gamelift_build
provides :aws_gamelift_build, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::GameLift::Build
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A descriptive label that is associated with a build. Build names do not need to be unique.
         DESCRIPTION

property :operating_system, String,
         callbacks: {
           "operating_system is not a String" => lambda { |v| v.is_a? String },
           "operating_systemis not one of `AMAZON_LINUX`, `AMAZON_LINUX_2`, `WINDOWS_2012`, `WINDOWS_2016`" => lambda { |v| %w{AMAZON_LINUX AMAZON_LINUX_2 WINDOWS_2012 WINDOWS_2016}.include? v },
         },
         description: <<~'DESCRIPTION'
           The operating system that the game server binaries are built to run on. This value determines the type of fleet resources that you can use for this build. If your game build contains multiple executables, they all must run on the same operating system. If an operating system is not specified when creating a build, Amazon GameLift uses the default value (WINDOWS_2012). This value cannot be changed later.
         DESCRIPTION

property :storage_location, Hash,
         callbacks: {
           "Subproperty `Bucket` is not a String" => lambda { |v| v[:Bucket].is_a? String },
           "Subproperty `Key` is not a String" => lambda { |v| v[:Key].is_a? String },
           "Subproperty `ObjectVersion` is not a String" => lambda { |v| v[:ObjectVersion].is_a? String },
           "Subproperty `RoleArn` is not a String" => lambda { |v| v[:RoleArn].is_a? String },
           "Subproperty `RoleArn`is not a valid ARN" => lambda { |v| v[:RoleArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: <<~'DESCRIPTION'
           Information indicating where your game build files are stored. Use this parameter only when creating a build with files stored in an Amazon S3 bucket that you own. The storage location must specify an Amazon S3 bucket name and key. The location must also specify a role ARN that you set up to allow Amazon GameLift to access your Amazon S3 bucket. The S3 bucket and your new build must be in the same Region.
         DESCRIPTION

property :version, String,
         callbacks: {
           "version is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Version information that is associated with this build. Version strings do not need to be unique.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::GameLift::Build"
rest_api_document "/AWS::GameLift::Build"

rest_property_map({
  name:             "Name",
  operating_system: "OperatingSystem",
  storage_location: "StorageLocation",
  version:          "Version",
})

rest_post_only_properties %i{
  operating_system storage_location
}
