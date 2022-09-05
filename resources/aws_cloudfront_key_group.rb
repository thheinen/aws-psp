# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_cloudfront_key_group
provides :aws_cloudfront_key_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::CloudFront::KeyGroup
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :key_group_config, Hash,
         required: true,
         callbacks: {
           "Subproperty `Comment` is not a String" => lambda { |v| v[:Comment].is_a? String },
           "Subproperty `Items` is not a Array" => lambda { |v| v[:Items].is_a? Array },
           "Subproperty `Name` is not a String" => lambda { |v| v[:Name].is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::CloudFront::KeyGroup"
rest_api_document "/AWS::CloudFront::KeyGroup"

rest_property_map({
  key_group_config: "KeyGroupConfig",
})

