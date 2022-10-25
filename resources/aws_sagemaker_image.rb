# Import API specifics
use "awscc_base"

resource_name :aws_sagemaker_image
provides :aws_sagemaker_image, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SageMaker::Image
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :image_description, Hash,
         callbacks: {
           "image_description is not a String" => lambda { |v| v.is_a? String },
           "image_description needs to be 1..512 characters" => lambda { |v| v.length >= 1 && v.length <= 512 },
           "image_description must match pattern .+" => lambda { |v| v =~ Regexp.new("/.+/") },
         },
         description: ""

property :image_display_name, Hash,
         callbacks: {
           "image_display_name is not a String" => lambda { |v| v.is_a? String },
           "image_display_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "image_display_name must match pattern ^[A-Za-z0-9 -_]+$" => lambda { |v| v =~ Regexp.new("/^[A-Za-z0-9 -_]+$/") },
         },
         description: ""

property :image_name, Hash,
         required: true,
         callbacks: {
           "image_name is not a String" => lambda { |v| v.is_a? String },
           "image_name needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
           "image_name must match pattern ^[a-zA-Z0-9]([-.]?[a-zA-Z0-9])*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9]([-.]?[a-zA-Z0-9])*$/") },
         },
         description: ""

property :image_role_arn, Hash,
         required: true,
         callbacks: {
           "image_role_arn is not a String" => lambda { |v| v.is_a? String },
           "image_role_arn needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "image_role_arn must match pattern ^arn:aws(-[\w]+)*:iam::[0-9]{12}:role/.*$" => lambda { |v| v =~ Regexp.new("/^arn:aws(-[\w]+)*:iam::[0-9]{12}:role/.*$/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SageMaker::Image"
rest_api_document "/AWS::SageMaker::Image"

rest_property_map({
  image_description:  "ImageDescription",
  image_display_name: "ImageDisplayName",
  image_name:         "ImageName",
  image_role_arn:     "ImageRoleArn",
  tags:               "Tags",
})

rest_post_only_properties %i{
  image_name
}
