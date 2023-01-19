# Import API specifics
use "awscc_base"

resource_name :aws_imagebuilder_image_pipeline
provides :aws_imagebuilder_image_pipeline, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::ImageBuilder::ImagePipeline
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

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The description of the image pipeline.
         DESCRIPTION

property :distribution_configuration_arn, String,
         callbacks: {
           "distribution_configuration_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the distribution configuration associated with this image pipeline.
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
           The image tests configuration of the image pipeline.
         DESCRIPTION

property :infrastructure_configuration_arn, String,
         callbacks: {
           "infrastructure_configuration_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the infrastructure configuration associated with this image pipeline.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the image pipeline.
         DESCRIPTION

property :schedule, Hash,
         callbacks: {
           "Subproperty `ScheduleExpression` is not a String" => lambda { |v| v[:ScheduleExpression].is_a? String },
           "Subproperty `PipelineExecutionStartCondition` is not a String" => lambda { |v| v[:PipelineExecutionStartCondition].is_a? String },
           "Subproperty `PipelineExecutionStartCondition`is not one of `EXPRESSION_MATCH_ONLY`, `EXPRESSION_MATCH_AND_DEPENDENCY_UPDATES_AVAILABLE`" => lambda { |v| %w{EXPRESSION_MATCH_ONLY EXPRESSION_MATCH_AND_DEPENDENCY_UPDATES_AVAILABLE}.include? v[:PipelineExecutionStartCondition] },
         },
         description: <<~'DESCRIPTION'
           The schedule of the image pipeline.
         DESCRIPTION

property :status, String,
         callbacks: {
           "status is not a String" => lambda { |v| v.is_a? String },
           "statusis not one of `DISABLED`, `ENABLED`" => lambda { |v| %w{DISABLED ENABLED}.include? v },
         },
         description: <<~'DESCRIPTION'
           The status of the image pipeline.
         DESCRIPTION

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           The tags of this image pipeline.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ImageBuilder::ImagePipeline"
rest_api_document "/AWS::ImageBuilder::ImagePipeline"

rest_property_map({
  container_recipe_arn:             "ContainerRecipeArn",
  description:                      "Description",
  distribution_configuration_arn:   "DistributionConfigurationArn",
  enhanced_image_metadata_enabled:  "EnhancedImageMetadataEnabled",
  image_recipe_arn:                 "ImageRecipeArn",
  image_scanning_configuration:     "ImageScanningConfiguration",
  image_tests_configuration:        "ImageTestsConfiguration",
  infrastructure_configuration_arn: "InfrastructureConfigurationArn",
  name:                             "Name",
  schedule:                         "Schedule",
  status:                           "Status",
  tags:                             "Tags",
})

rest_post_only_properties %i{
  name
}
