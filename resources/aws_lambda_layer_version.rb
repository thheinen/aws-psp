# Import API specifics
use "awscc_base"

resource_name :aws_lambda_layer_version
provides :aws_lambda_layer_version, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Lambda::LayerVersion
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :compatible_architectures, Array,
         callbacks: {
           "compatible_architectures is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of compatible instruction set architectures.
         DESCRIPTION

property :compatible_runtimes, Array,
         callbacks: {
           "compatible_runtimes is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of compatible function runtimes. Used for filtering with ListLayers and ListLayerVersions.
         DESCRIPTION

property :content, Hash,
         required: true,
         callbacks: {
           "Subproperty `S3ObjectVersion` is not a String" => lambda { |v| v[:S3ObjectVersion].is_a? String },
           "Subproperty `S3Bucket` is not a String" => lambda { |v| v[:S3Bucket].is_a? String },
           "Subproperty `S3Key` is not a String" => lambda { |v| v[:S3Key].is_a? String },
         },
         description: <<~'DESCRIPTION'
           The function layer archive.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The description of the version.
         DESCRIPTION

property :layer_name, String,
         callbacks: {
           "layer_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name or Amazon Resource Name (ARN) of the layer.
         DESCRIPTION

property :license_info, String,
         callbacks: {
           "license_info is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The layer's software license.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Lambda::LayerVersion"
rest_api_document "/AWS::Lambda::LayerVersion"

rest_property_map({
  compatible_architectures: "CompatibleArchitectures",
  compatible_runtimes:      "CompatibleRuntimes",
  content:                  "Content",
  description:              "Description",
  layer_name:               "LayerName",
  license_info:             "LicenseInfo",
})

rest_post_only_properties %i{
  compatible_architectures compatible_runtimes content description layer_name license_info
}
