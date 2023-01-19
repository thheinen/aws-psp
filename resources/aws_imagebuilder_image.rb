# Import API specifics
use "awscc_base"

resource_name :aws_imagebuilder_image
provides :aws_imagebuilder_image, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::ImageBuilder::Image
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :container_recipe_arn, String,
         callbacks: {
           "container_recipe_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the container recipe that defines how images are configured and tested.
         DESCRIPTION

property :distribution_configuration_arn, String,
         callbacks: {
           "distribution_configuration_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the distribution configuration.
         DESCRIPTION

property :enhanced_image_metadata_enabled, [TrueClass, FalseClass],
         callbacks: {
           "enhanced_image_metadata_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Collects additional information about the image being created, including the operating system (OS) version and package list.
         DESCRIPTION

property :image_recipe_arn, String,
         callbacks: {
           "image_recipe_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the image recipe that defines how images are configured, tested, and assessed.
         DESCRIPTION

property :image_scanning_configuration, Hash,
         callbacks: {
           "Subproperty `ImageScanningEnabled` is not a Boolean" => lambda { |v| v[:ImageScanningEnabled].is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Contains settings for vulnerability scans.
         DESCRIPTION

property :image_tests_configuration, Hash,
         callbacks: {
           "Subproperty `ImageTestsEnabled` is not a Boolean" => lambda { |v| v[:ImageTestsEnabled].is_a? Boolean },
           "Subproperty `TimeoutMinutes` is not a Integer" => lambda { |v| v[:TimeoutMinutes].is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The image tests configuration used when creating this image.
         DESCRIPTION

property :infrastructure_configuration_arn, String,
         callbacks: {
           "infrastructure_configuration_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the infrastructure configuration.
         DESCRIPTION

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           The tags associated with the image.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ImageBuilder::Image"
rest_api_document "/AWS::ImageBuilder::Image"

rest_property_map({
  container_recipe_arn:             "ContainerRecipeArn",
  distribution_configuration_arn:   "DistributionConfigurationArn",
  enhanced_image_metadata_enabled:  "EnhancedImageMetadataEnabled",
  image_recipe_arn:                 "ImageRecipeArn",
  image_scanning_configuration:     "ImageScanningConfiguration",
  image_tests_configuration:        "ImageTestsConfiguration",
  infrastructure_configuration_arn: "InfrastructureConfigurationArn",
  tags:                             "Tags",
})

rest_post_only_properties %i{
  container_recipe_arn distribution_configuration_arn enhanced_image_metadata_enabled image_recipe_arn image_scanning_configuration image_tests_configuration infrastructure_configuration_arn tags
}
