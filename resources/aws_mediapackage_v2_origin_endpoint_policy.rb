# Import API specifics
use "awscc_base"

resource_name :aws_mediapackage_v2_origin_endpoint_policy
provides :aws_mediapackage_v2_origin_endpoint_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::MediaPackageV2::OriginEndpointPolicy Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :channel_group_name, String,
         callbacks: {
           "channel_group_name is not a String" => lambda { |v| v.is_a? String },
           "channel_group_name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "channel_group_name must match pattern ^[a-zA-Z0-9_-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_-]+$/") },
         },
         description: ""

property :channel_name, String,
         callbacks: {
           "channel_name is not a String" => lambda { |v| v.is_a? String },
           "channel_name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "channel_name must match pattern ^[a-zA-Z0-9_-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_-]+$/") },
         },
         description: ""

property :origin_endpoint_name, String,
         callbacks: {
           "origin_endpoint_name is not a String" => lambda { |v| v.is_a? String },
           "origin_endpoint_name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "origin_endpoint_name must match pattern ^[a-zA-Z0-9_-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_-]+$/") },
         },
         description: ""

property :policy, [Hash, String],
         required: true,
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::MediaPackageV2::OriginEndpointPolicy"
rest_api_document "/AWS::MediaPackageV2::OriginEndpointPolicy"

rest_property_map({
  channel_group_name:   "ChannelGroupName",
  channel_name:         "ChannelName",
  origin_endpoint_name: "OriginEndpointName",
  policy:               "Policy",
})

rest_post_only_properties %i{
  channel_group_name channel_name origin_endpoint_name
}
