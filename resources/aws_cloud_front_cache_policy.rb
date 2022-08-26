# Import API specifics
use "awscc_base"

resource_name :aws_cloud_front_cache_policy
provides :aws_cloud_front_cache_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::CloudFront::CachePolicy
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :cache_policy_config, Hash,
         required: true,
         callbacks: {
           "Subproperty `Comment` is not a String" => lambda { |v| v[:Comment].is_a? String },
           "Subproperty `DefaultTTL` is not a Number" => lambda { |v| v[:DefaultTTL].is_a? Number },
           "Subproperty `MaxTTL` is not a Number" => lambda { |v| v[:MaxTTL].is_a? Number },
           "Subproperty `MinTTL` is not a Number" => lambda { |v| v[:MinTTL].is_a? Number },
           "Subproperty `Name` is not a String" => lambda { |v| v[:Name].is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::CloudFront::CachePolicy"
rest_api_document "/AWS::CloudFront::CachePolicy"

rest_property_map({
  cache_policy_config: "CachePolicyConfig",
})

