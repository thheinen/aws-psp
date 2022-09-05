# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_cloudfront_cloud_front_origin_access_identity
provides :aws_cloudfront_cloud_front_origin_access_identity, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::CloudFront::CloudFrontOriginAccessIdentity
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :cloudfront_origin_access_identity_config, Hash,
         required: true,
         callbacks: {
           "Subproperty `Comment` is not a String" => lambda { |v| v[:Comment].is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::CloudFront::CloudFrontOriginAccessIdentity"
rest_api_document "/AWS::CloudFront::CloudFrontOriginAccessIdentity"

rest_property_map({
  cloudfront_origin_access_identity_config: "CloudFrontOriginAccessIdentityConfig",
})

