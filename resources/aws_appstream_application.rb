# Import API specifics
use "awscc_base"

resource_name :aws_appstream_application
provides :aws_appstream_application, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::AppStream::Application
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :app_block_arn, Hash,
         required: true,
         callbacks: {
           "app_block_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :attributes_to_delete, Array,
         callbacks: {
           "attributes_to_delete is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :display_name, String,
         callbacks: {
           "display_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :icon_s3_location, Hash,
         required: true,
         callbacks: {
           "Subproperty `S3Bucket` is not a String" => lambda { |v| v[:S3Bucket].is_a? String },
           "Subproperty `S3Key` is not a String" => lambda { |v| v[:S3Key].is_a? String },
         },
         description: ""

property :instance_families, Array,
         required: true,
         callbacks: {
           "instance_families is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :launch_parameters, String,
         callbacks: {
           "launch_parameters is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :launch_path, String,
         required: true,
         callbacks: {
           "launch_path is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :platforms, Array,
         required: true,
         callbacks: {
           "platforms is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :working_directory, String,
         callbacks: {
           "working_directory is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::AppStream::Application"
rest_api_document "/AWS::AppStream::Application"

rest_property_map({
  app_block_arn:        "AppBlockArn",
  attributes_to_delete: "AttributesToDelete",
  description:          "Description",
  display_name:         "DisplayName",
  icon_s3_location:     "IconS3Location",
  instance_families:    "InstanceFamilies",
  launch_parameters:    "LaunchParameters",
  launch_path:          "LaunchPath",
  name:                 "Name",
  platforms:            "Platforms",
  tags:                 "Tags",
  working_directory:    "WorkingDirectory",
})

rest_post_only_properties %i{
  instance_families name platforms
}
