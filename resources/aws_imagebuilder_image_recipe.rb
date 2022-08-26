# Import API specifics
use "awscc_base"

resource_name :aws_imagebuilder_image_recipe
provides :aws_imagebuilder_image_recipe, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::ImageBuilder::ImageRecipe
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :additional_instance_configuration, Hash,
         callbacks: {
           "Subproperty `UserDataOverride` is not a String" => lambda { |v| v[:UserDataOverride].is_a? String },
         },
         description: "Specify additional settings and launch scripts for your build instances."

property :block_device_mappings, Array,
         callbacks: {
           "block_device_mappings is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The block device mappings to apply when creating images from this recipe."

property :components, Array,
         required: true,
         callbacks: {
           "components is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The components of the image recipe."

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The description of the image recipe."

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The name of the image recipe."

property :parent_image, String,
         required: true,
         callbacks: {
           "parent_image is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The parent image of the image recipe."

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: "The tags of the image recipe."

property :version, String,
         required: true,
         callbacks: {
           "version is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The version of the image recipe."

property :working_directory, String,
         callbacks: {
           "working_directory is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The working directory to be used during build and test workflows."

# API URLs and mappings
rest_api_collection "/AWS::ImageBuilder::ImageRecipe"
rest_api_document "/AWS::ImageBuilder::ImageRecipe"

rest_property_map({
  additional_instance_configuration: "AdditionalInstanceConfiguration",
  block_device_mappings:             "BlockDeviceMappings",
  components:                        "Components",
  description:                       "Description",
  name:                              "Name",
  parent_image:                      "ParentImage",
  tags:                              "Tags",
  version:                           "Version",
  working_directory:                 "WorkingDirectory",
})

rest_post_only_properties %i{
  block_device_mappings components description name parent_image tags version working_directory
}
