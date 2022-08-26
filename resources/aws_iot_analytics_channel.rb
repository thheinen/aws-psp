# Import API specifics
use "awscc_base"

resource_name :aws_iot_analytics_channel
provides :aws_iot_analytics_channel, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::IoTAnalytics::Channel
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :channel_name, String,
         callbacks: {
           "channel_name is not a String" => lambda { |v| v.is_a? String },
           "channel_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "channel_name must match pattern (^(?!_{2}))(^[a-zA-Z0-9_]+$)" => lambda { |v| v =~ Regexp.new("/(^(?!_{2}))(^[a-zA-Z0-9_]+$)/") },
         },
         description: ""

property :channel_storage, Hash,
         description: ""

property :retention_period, Hash,
         callbacks: {
           "Subproperty `NumberOfDays` is not a Integer" => lambda { |v| v[:NumberOfDays].is_a? Integer },
           "Subproperty `Unlimited` is not a Boolean" => lambda { |v| v[:Unlimited].is_a? Boolean },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::IoTAnalytics::Channel"
rest_api_document "/AWS::IoTAnalytics::Channel"

rest_property_map({
  channel_name:     "ChannelName",
  channel_storage:  "ChannelStorage",
  retention_period: "RetentionPeriod",
  tags:             "Tags",
})

rest_post_only_properties %i{
  channel_name
}
