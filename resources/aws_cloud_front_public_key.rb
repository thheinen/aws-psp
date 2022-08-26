# Import API specifics
use "awscc_base"

resource_name :aws_cloud_front_public_key
provides :aws_cloud_front_public_key, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::CloudFront::PublicKey
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :public_key_config, Hash,
         required: true,
         callbacks: {
           "Subproperty `CallerReference` is not a String" => lambda { |v| v[:CallerReference].is_a? String },
           "Subproperty `Comment` is not a String" => lambda { |v| v[:Comment].is_a? String },
           "Subproperty `EncodedKey` is not a String" => lambda { |v| v[:EncodedKey].is_a? String },
           "Subproperty `Name` is not a String" => lambda { |v| v[:Name].is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::CloudFront::PublicKey"
rest_api_document "/AWS::CloudFront::PublicKey"

rest_property_map({
  public_key_config: "PublicKeyConfig",
})

