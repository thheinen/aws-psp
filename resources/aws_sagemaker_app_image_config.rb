# Import API specifics
use "awscc_base"

resource_name :aws_sagemaker_app_image_config
provides :aws_sagemaker_app_image_config, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SageMaker::AppImageConfig
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :app_image_config_name, String,
         required: true,
         callbacks: {
           "app_image_config_name is not a String" => lambda { |v| v.is_a? String },
           "app_image_config_name needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
           "app_image_config_name must match pattern ^[a-zA-Z0-9](-*[a-zA-Z0-9]){0,62}" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9](-*[a-zA-Z0-9]){0,62}/") },
         },
         description: "The Name of the AppImageConfig."

property :kernel_gateway_image_config, Hash,
         callbacks: {
           "Subproperty `KernelSpecs` is not a Array" => lambda { |v| v[:KernelSpecs].is_a? Array },
         },
         description: "The KernelGatewayImageConfig."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "A list of tags to apply to the AppImageConfig."

# API URLs and mappings
rest_api_collection "/AWS::SageMaker::AppImageConfig"
rest_api_document "/AWS::SageMaker::AppImageConfig"

rest_property_map({
  app_image_config_name:       "AppImageConfigName",
  kernel_gateway_image_config: "KernelGatewayImageConfig",
  tags:                        "Tags",
})

rest_post_only_properties %i{
  app_image_config_name tags
}
