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
         description: <<~'DESCRIPTION'
           Specify additional settings and launch scripts for your build instances.
         DESCRIPTION

property :block_device_mappings, Array,
         callbacks: {
           "block_device_mappings is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The block device mappings to apply when creating images from this recipe.
         DESCRIPTION

property :components, Array,
         required: true,
         callbacks: {
           "components is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The components of the image recipe.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The description of the image recipe.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the image recipe.
         DESCRIPTION

property :parent_image, String,
         required: true,
         callbacks: {
           "parent_image is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The parent image of the image recipe.
         DESCRIPTION

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           The tags of the image recipe.
         DESCRIPTION

property :version, String,
         required: true,
         callbacks: {
           "version is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The version of the image recipe.
         DESCRIPTION

property :working_directory, String,
         callbacks: {
           "working_directory is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The working directory to be used during build and test workflows.
         DESCRIPTION

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
