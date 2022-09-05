# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_cloudfront_origin_access_control
provides :aws_cloudfront_origin_access_control, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::CloudFront::OriginAccessControl
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :origin_access_control_config, Hash,
         required: true,
         callbacks: {
           "Subproperty `Name` is not a String" => lambda { |v| v[:Name].is_a? String },
           "Subproperty `Description` is not a String" => lambda { |v| v[:Description].is_a? String },
           "Subproperty `SigningProtocol` is not a String" => lambda { |v| v[:SigningProtocol].is_a? String },
           "Subproperty `SigningProtocol` must match pattern ^(sigv4)$" => lambda { |v| v[:SigningProtocol] =~ Regexp.new("/^(sigv4)$/") },
           "Subproperty `SigningBehavior` is not a String" => lambda { |v| v[:SigningBehavior].is_a? String },
           "Subproperty `SigningBehavior` must match pattern ^(never|no-override|always)$" => lambda { |v| v[:SigningBehavior] =~ Regexp.new("/^(never|no-override|always)$/") },
           "Subproperty `OriginAccessControlOriginType` is not a String" => lambda { |v| v[:OriginAccessControlOriginType].is_a? String },
           "Subproperty `OriginAccessControlOriginType` must match pattern ^(s3)$" => lambda { |v| v[:OriginAccessControlOriginType] =~ Regexp.new("/^(s3)$/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::CloudFront::OriginAccessControl"
rest_api_document "/AWS::CloudFront::OriginAccessControl"

rest_property_map({
  origin_access_control_config: "OriginAccessControlConfig",
})

