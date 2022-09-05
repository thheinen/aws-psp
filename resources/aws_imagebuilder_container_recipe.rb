# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_imagebuilder_container_recipe
provides :aws_imagebuilder_container_recipe, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::ImageBuilder::ContainerRecipe
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :components, Array,
         callbacks: {
           "components is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Components for build and test that are included in the container recipe.
         DESCRIPTION

property :container_type, String,
         callbacks: {
           "container_type is not a String" => lambda { |v| v.is_a? String },
           "container_typeis not one of `DOCKER`" => lambda { |v| %w{DOCKER}.include? v },
         },
         description: <<~'DESCRIPTION'
           Specifies the type of container, such as Docker.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The description of the container recipe.
         DESCRIPTION

property :dockerfile_template_data, String,
         callbacks: {
           "dockerfile_template_data is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Dockerfiles are text documents that are used to build Docker containers, and ensure that they contain all of the elements required by the application running inside. The template data consists of contextual variables where Image Builder places build information or scripts, based on your container image recipe.
         DESCRIPTION

property :dockerfile_template_uri, String,
         callbacks: {
           "dockerfile_template_uri is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The S3 URI for the Dockerfile that will be used to build your container image.
         DESCRIPTION

property :image_os_version_override, String,
         callbacks: {
           "image_os_version_override is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies the operating system version for the source image.
         DESCRIPTION

property :instance_configuration, Hash,
         callbacks: {
           "Subproperty `Image` is not a String" => lambda { |v| v[:Image].is_a? String },
           "Subproperty `BlockDeviceMappings` is not a Array" => lambda { |v| v[:BlockDeviceMappings].is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A group of options that can be used to configure an instance for building and testing container images.
         DESCRIPTION

property :kms_key_id, String,
         callbacks: {
           "kms_key_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Identifies which KMS key is used to encrypt the container image.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the container recipe.
         DESCRIPTION

property :parent_image, String,
         callbacks: {
           "parent_image is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The source image for the container recipe.
         DESCRIPTION

property :platform_override, String,
         callbacks: {
           "platform_override is not a String" => lambda { |v| v.is_a? String },
           "platform_overrideis not one of `Windows`, `Linux`" => lambda { |v| %w{Windows Linux}.include? v },
         },
         description: <<~'DESCRIPTION'
           Specifies the operating system platform when you use a custom source image.
         DESCRIPTION

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           Tags that are attached to the container recipe.
         DESCRIPTION

property :target_repository, Hash,
         callbacks: {
           "Subproperty `Service` is not a String" => lambda { |v| v[:Service].is_a? String },
           "Subproperty `Service`is not one of `ECR`" => lambda { |v| %w{ECR}.include? v[:Service] },
           "Subproperty `RepositoryName` is not a String" => lambda { |v| v[:RepositoryName].is_a? String },
         },
         description: <<~'DESCRIPTION'
           The destination repository for the container image.
         DESCRIPTION

property :version, String,
         callbacks: {
           "version is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The semantic version of the container recipe (<major>.<minor>.<patch>).
         DESCRIPTION

property :working_directory, String,
         callbacks: {
           "working_directory is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The working directory to be used during build and test workflows.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ImageBuilder::ContainerRecipe"
rest_api_document "/AWS::ImageBuilder::ContainerRecipe"

rest_property_map({
  components:                "Components",
  container_type:            "ContainerType",
  description:               "Description",
  dockerfile_template_data:  "DockerfileTemplateData",
  dockerfile_template_uri:   "DockerfileTemplateUri",
  image_os_version_override: "ImageOsVersionOverride",
  instance_configuration:    "InstanceConfiguration",
  kms_key_id:                "KmsKeyId",
  name:                      "Name",
  parent_image:              "ParentImage",
  platform_override:         "PlatformOverride",
  tags:                      "Tags",
  target_repository:         "TargetRepository",
  version:                   "Version",
  working_directory:         "WorkingDirectory",
})

rest_post_only_properties %i{
  components container_type description dockerfile_template_data dockerfile_template_uri image_os_version_override instance_configuration kms_key_id name parent_image platform_override tags target_repository version working_directory
}
