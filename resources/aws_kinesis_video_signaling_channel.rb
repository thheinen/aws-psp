# Import API specifics
use "awscc_base"

resource_name :aws_kinesis_video_signaling_channel
provides :aws_kinesis_video_signaling_channel, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type Definition for AWS::KinesisVideo::SignalingChannel
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :message_ttl_seconds, Integer,
         callbacks: {
           "message_ttl_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The period of time a signaling channel retains undelivered messages before they are discarded.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "name must match pattern [a-zA-Z0-9_.-]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9_.-]+/") },
         },
         description: <<~'DESCRIPTION'
           The name of the Kinesis Video Signaling Channel.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

property :type, String,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
           "typeis not one of `SINGLE_MASTER`" => lambda { |v| %w{SINGLE_MASTER}.include? v },
         },
         description: <<~'DESCRIPTION'
           The type of the Kinesis Video Signaling Channel to create. Currently, SINGLE_MASTER is the only supported channel type.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::KinesisVideo::SignalingChannel"
rest_api_document "/AWS::KinesisVideo::SignalingChannel"

rest_property_map({
  message_ttl_seconds: "MessageTtlSeconds",
  name:                "Name",
  tags:                "Tags",
  type:                "Type",
})

rest_post_only_properties %i{
  name
}
