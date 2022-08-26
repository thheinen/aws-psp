# Import API specifics
use "awscc_base"

resource_name :aws_cloud_front_response_headers_policy
provides :aws_cloud_front_response_headers_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::CloudFront::ResponseHeadersPolicy
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :response_headers_policy_config, Hash,
         required: true,
         callbacks: {
           "Subproperty `Comment` is not a String" => lambda { |v| v[:Comment].is_a? String },
           "Subproperty `Name` is not a String" => lambda { |v| v[:Name].is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::CloudFront::ResponseHeadersPolicy"
rest_api_document "/AWS::CloudFront::ResponseHeadersPolicy"

rest_property_map({
  response_headers_policy_config: "ResponseHeadersPolicyConfig",
})

