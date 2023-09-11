# Import API specifics
use "awscc_base"

resource_name :aws_mediapackage_v2_origin_endpoint
provides :aws_mediapackage_v2_origin_endpoint, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::MediaPackageV2::OriginEndpoint Resource Type
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

property :container_type, Hash,
         required: true,
         callbacks: {
           "container_type is not a String" => lambda { |v| v.is_a? String },
           "container_typeis not one of `TS`, `CMAF`" => lambda { |v| %w{TS CMAF}.include? v },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..1024 characters" => lambda { |v| v.length >= 0 && v.length <= 1024 },
         },
         description: <<~'DESCRIPTION'
           <p>Enter any descriptive text that helps you to identify the origin endpoint.</p>
         DESCRIPTION

property :hls_manifests, Array,
         callbacks: {
           "hls_manifests is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           <p>An HTTP live streaming (HLS) manifest configuration.</p>
         DESCRIPTION

property :low_latency_hls_manifests, Array,
         callbacks: {
           "low_latency_hls_manifests is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           <p>A low-latency HLS manifest configuration.</p>
         DESCRIPTION

property :origin_endpoint_name, String,
         callbacks: {
           "origin_endpoint_name is not a String" => lambda { |v| v.is_a? String },
           "origin_endpoint_name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "origin_endpoint_name must match pattern ^[a-zA-Z0-9_-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_-]+$/") },
         },
         description: ""

property :segment, Hash,
         callbacks: {
           "Subproperty `SegmentDurationSeconds` is not a Integer" => lambda { |v| v[:SegmentDurationSeconds].is_a? Integer },
           "Subproperty `SegmentName` is not a String" => lambda { |v| v[:SegmentName].is_a? String },
           "Subproperty `SegmentName` needs to be 1..256 characters" => lambda { |v| v[:SegmentName].length >= 1 && v[:SegmentName].length <= 256 },
           "Subproperty `SegmentName` must match pattern ^[a-zA-Z0-9_-]+$" => lambda { |v| v[:SegmentName] =~ Regexp.new("/^[a-zA-Z0-9_-]+$/") },
           "Subproperty `TsUseAudioRenditionGroup` is not a Boolean" => lambda { |v| v[:TsUseAudioRenditionGroup].is_a? Boolean },
           "Subproperty `IncludeIframeOnlyStreams` is not a Boolean" => lambda { |v| v[:IncludeIframeOnlyStreams].is_a? Boolean },
           "Subproperty `TsIncludeDvbSubtitles` is not a Boolean" => lambda { |v| v[:TsIncludeDvbSubtitles].is_a? Boolean },
         },
         description: ""

property :startover_window_seconds, Integer,
         callbacks: {
           "startover_window_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           <p>The size of the window (in seconds) to create a window of the live stream that's available for on-demand viewing. Viewers can start-over or catch-up on content that falls within the window. The maximum startover window is 1,209,600 seconds (14 days).</p>
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::MediaPackageV2::OriginEndpoint"
rest_api_document "/AWS::MediaPackageV2::OriginEndpoint"

rest_property_map({
  channel_group_name:        "ChannelGroupName",
  channel_name:              "ChannelName",
  container_type:            "ContainerType",
  description:               "Description",
  hls_manifests:             "HlsManifests",
  low_latency_hls_manifests: "LowLatencyHlsManifests",
  origin_endpoint_name:      "OriginEndpointName",
  segment:                   "Segment",
  startover_window_seconds:  "StartoverWindowSeconds",
  tags:                      "Tags",
})

rest_post_only_properties %i{
  channel_group_name channel_name origin_endpoint_name
}
