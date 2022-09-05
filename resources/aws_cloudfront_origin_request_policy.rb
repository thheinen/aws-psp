# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_cloudfront_origin_request_policy
provides :aws_cloudfront_origin_request_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::CloudFront::OriginRequestPolicy
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :origin_request_policy_config, Hash,
         required: true,
         callbacks: {
           "Subproperty `Comment` is not a String" => lambda { |v| v[:Comment].is_a? String },
           "Subproperty `Name` is not a String" => lambda { |v| v[:Name].is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::CloudFront::OriginRequestPolicy"
rest_api_document "/AWS::CloudFront::OriginRequestPolicy"

rest_property_map({
  origin_request_policy_config: "OriginRequestPolicyConfig",
})

