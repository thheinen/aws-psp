# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_ivs_stream_key
provides :aws_ivs_stream_key, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::IVS::StreamKey
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :channel_arn, String,
         required: true,
         callbacks: {
           "channel_arn is not a String" => lambda { |v| v.is_a? String },
           "channel_arn must match pattern ^arn:aws:ivs:[a-z0-9-]+:[0-9]+:channel/[a-zA-Z0-9-]+$" => lambda { |v| v =~ Regexp.new("/^arn:aws:ivs:[a-z0-9-]+:[0-9]+:channel/[a-zA-Z0-9-]+$/") },
         },
         description: <<~'DESCRIPTION'
           Channel ARN for the stream.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of key-value pairs that contain metadata for the asset model.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IVS::StreamKey"
rest_api_document "/AWS::IVS::StreamKey"

rest_property_map({
  channel_arn: "ChannelArn",
  tags:        "Tags",
})

rest_post_only_properties %i{
  channel_arn
}
