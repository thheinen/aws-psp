# Import API specifics
use "awscc_base"

resource_name :aws_appstream_app_block
provides :aws_appstream_app_block, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::AppStream::AppBlock
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

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

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :packaging_type, Hash,
         callbacks: {
           "packaging_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :post_setup_script_details, Hash,
         callbacks: {
           "Subproperty `ExecutablePath` is not a String" => lambda { |v| v[:ExecutablePath].is_a? String },
           "Subproperty `ExecutableParameters` is not a String" => lambda { |v| v[:ExecutableParameters].is_a? String },
           "Subproperty `TimeoutInSeconds` is not a Integer" => lambda { |v| v[:TimeoutInSeconds].is_a? Integer },
         },
         description: ""

property :setup_script_details, Hash,
         callbacks: {
           "Subproperty `ExecutablePath` is not a String" => lambda { |v| v[:ExecutablePath].is_a? String },
           "Subproperty `ExecutableParameters` is not a String" => lambda { |v| v[:ExecutableParameters].is_a? String },
           "Subproperty `TimeoutInSeconds` is not a Integer" => lambda { |v| v[:TimeoutInSeconds].is_a? Integer },
         },
         description: ""

property :source_s3_location, Hash,
         required: true,
         callbacks: {
           "Subproperty `S3Bucket` is not a String" => lambda { |v| v[:S3Bucket].is_a? String },
           "Subproperty `S3Key` is not a String" => lambda { |v| v[:S3Key].is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::AppStream::AppBlock"
rest_api_document "/AWS::AppStream::AppBlock"

rest_property_map({
  description:               "Description",
  display_name:              "DisplayName",
  name:                      "Name",
  packaging_type:            "PackagingType",
  post_setup_script_details: "PostSetupScriptDetails",
  setup_script_details:      "SetupScriptDetails",
  source_s3_location:        "SourceS3Location",
  tags:                      "Tags",
})

rest_post_only_properties %i{
  description display_name name packaging_type post_setup_script_details setup_script_details source_s3_location
}
