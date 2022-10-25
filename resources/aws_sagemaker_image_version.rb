# Import API specifics
use "awscc_base"

resource_name :aws_sagemaker_image_version
provides :aws_sagemaker_image_version, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SageMaker::ImageVersion
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :base_image, Hash,
         required: true,
         callbacks: {
           "base_image is not a String" => lambda { |v| v.is_a? String },
           "base_image needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "base_image must match pattern .+" => lambda { |v| v =~ Regexp.new("/.+/") },
         },
         description: ""

property :image_name, Hash,
         required: true,
         callbacks: {
           "image_name is not a String" => lambda { |v| v.is_a? String },
           "image_name needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
           "image_name must match pattern ^[A-Za-z0-9]([-.]?[A-Za-z0-9])*$" => lambda { |v| v =~ Regexp.new("/^[A-Za-z0-9]([-.]?[A-Za-z0-9])*$/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::SageMaker::ImageVersion"
rest_api_document "/AWS::SageMaker::ImageVersion"

rest_property_map({
  base_image: "BaseImage",
  image_name: "ImageName",
})

rest_post_only_properties %i{
  base_image image_name
}
