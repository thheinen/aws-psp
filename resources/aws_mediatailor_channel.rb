# Import API specifics
use "awscc_base"

resource_name :aws_mediatailor_channel
provides :aws_mediatailor_channel, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::MediaTailor::Channel Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :channel_name, String,
         required: true,
         callbacks: {
           "channel_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :filler_slate, Hash,
         callbacks: {
           "Subproperty `SourceLocationName` is not a String" => lambda { |v| v[:SourceLocationName].is_a? String },
           "Subproperty `VodSourceName` is not a String" => lambda { |v| v[:VodSourceName].is_a? String },
         },
         description: ""

property :log_configuration, Hash,
         callbacks: {
           "Subproperty `LogTypes` is not a Array" => lambda { |v| v[:LogTypes].is_a? Array },
         },
         description: ""

property :outputs, Array,
         required: true,
         callbacks: {
           "outputs is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           <p>The channel's output properties.</p>
         DESCRIPTION

property :playback_mode, Hash,
         required: true,
         callbacks: {
           "playback_mode is not a String" => lambda { |v| v.is_a? String },
           "playback_modeis not one of `LOOP`, `LINEAR`" => lambda { |v| %w{LOOP LINEAR}.include? v },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags to assign to the channel.
         DESCRIPTION

property :tier, Hash,
         callbacks: {
           "tier is not a String" => lambda { |v| v.is_a? String },
           "tieris not one of `BASIC`, `STANDARD`" => lambda { |v| %w{BASIC STANDARD}.include? v },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::MediaTailor::Channel"
rest_api_document "/AWS::MediaTailor::Channel"

rest_property_map({
  channel_name:      "ChannelName",
  filler_slate:      "FillerSlate",
  log_configuration: "LogConfiguration",
  outputs:           "Outputs",
  playback_mode:     "PlaybackMode",
  tags:              "Tags",
  tier:              "Tier",
})

rest_post_only_properties %i{
  channel_name tier
}
