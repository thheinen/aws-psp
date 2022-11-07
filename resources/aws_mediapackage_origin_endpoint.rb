# Import API specifics
use "awscc_base"

resource_name :aws_mediapackage_origin_endpoint
provides :aws_mediapackage_origin_endpoint, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::MediaPackage::OriginEndpoint
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :authorization, Hash,
         callbacks: {
           "Subproperty `SecretsRoleArn` is not a String" => lambda { |v| v[:SecretsRoleArn].is_a? String },
           "Subproperty `SecretsRoleArn`is not a valid ARN" => lambda { |v| v[:SecretsRoleArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `CdnIdentifierSecret` is not a String" => lambda { |v| v[:CdnIdentifierSecret].is_a? String },
         },
         description: ""

property :channel_id, String,
         required: true,
         callbacks: {
           "channel_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the Channel the OriginEndpoint is associated with.
         DESCRIPTION

property :cmaf_package, Hash,
         callbacks: {
           "Subproperty `SegmentDurationSeconds` is not a Integer" => lambda { |v| v[:SegmentDurationSeconds].is_a? Integer },
           "Subproperty `SegmentPrefix` is not a String" => lambda { |v| v[:SegmentPrefix].is_a? String },
           "Subproperty `HlsManifests` is not a Array" => lambda { |v| v[:HlsManifests].is_a? Array },
         },
         description: ""

property :dash_package, Hash,
         callbacks: {
           "Subproperty `SegmentDurationSeconds` is not a Integer" => lambda { |v| v[:SegmentDurationSeconds].is_a? Integer },
           "Subproperty `ManifestWindowSeconds` is not a Integer" => lambda { |v| v[:ManifestWindowSeconds].is_a? Integer },
           "Subproperty `Profile` is not a String" => lambda { |v| v[:Profile].is_a? String },
           "Subproperty `Profile`is not one of `NONE`, `HBBTV_1_5`, `HYBRIDCAST`, `DVB_DASH_2014`" => lambda { |v| %w{NONE HBBTV_1_5 HYBRIDCAST DVB_DASH_2014}.include? v[:Profile] },
           "Subproperty `MinUpdatePeriodSeconds` is not a Integer" => lambda { |v| v[:MinUpdatePeriodSeconds].is_a? Integer },
           "Subproperty `MinBufferTimeSeconds` is not a Integer" => lambda { |v| v[:MinBufferTimeSeconds].is_a? Integer },
           "Subproperty `SuggestedPresentationDelaySeconds` is not a Integer" => lambda { |v| v[:SuggestedPresentationDelaySeconds].is_a? Integer },
           "Subproperty `PeriodTriggers` is not a Array" => lambda { |v| v[:PeriodTriggers].is_a? Array },
           "Subproperty `IncludeIframeOnlyStream` is not a Boolean" => lambda { |v| v[:IncludeIframeOnlyStream].is_a? Boolean },
           "Subproperty `ManifestLayout` is not a String" => lambda { |v| v[:ManifestLayout].is_a? String },
           "Subproperty `ManifestLayout`is not one of `FULL`, `COMPACT`" => lambda { |v| %w{FULL COMPACT}.include? v[:ManifestLayout] },
           "Subproperty `SegmentTemplateFormat` is not a String" => lambda { |v| v[:SegmentTemplateFormat].is_a? String },
           "Subproperty `SegmentTemplateFormat`is not one of `NUMBER_WITH_TIMELINE`, `TIME_WITH_TIMELINE`, `NUMBER_WITH_DURATION`" => lambda { |v| %w{NUMBER_WITH_TIMELINE TIME_WITH_TIMELINE NUMBER_WITH_DURATION}.include? v[:SegmentTemplateFormat] },
           "Subproperty `AdTriggers` is not a Array" => lambda { |v| v[:AdTriggers].is_a? Array },
           "Subproperty `UtcTiming` is not a String" => lambda { |v| v[:UtcTiming].is_a? String },
           "Subproperty `UtcTiming`is not one of `HTTP-XSDATE`, `HTTP-ISO`, `HTTP-HEAD`, `NONE`" => lambda { |v| %w{HTTP-XSDATE HTTP-ISO HTTP-HEAD NONE}.include? v[:UtcTiming] },
           "Subproperty `UtcTimingUri` is not a String" => lambda { |v| v[:UtcTimingUri].is_a? String },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A short text description of the OriginEndpoint.
         DESCRIPTION

property :hls_package, Hash,
         callbacks: {
           "Subproperty `SegmentDurationSeconds` is not a Integer" => lambda { |v| v[:SegmentDurationSeconds].is_a? Integer },
           "Subproperty `PlaylistWindowSeconds` is not a Integer" => lambda { |v| v[:PlaylistWindowSeconds].is_a? Integer },
           "Subproperty `PlaylistType` is not a String" => lambda { |v| v[:PlaylistType].is_a? String },
           "Subproperty `PlaylistType`is not one of `NONE`, `EVENT`, `VOD`" => lambda { |v| %w{NONE EVENT VOD}.include? v[:PlaylistType] },
           "Subproperty `AdMarkers` is not a String" => lambda { |v| v[:AdMarkers].is_a? String },
           "Subproperty `AdMarkers`is not one of `NONE`, `SCTE35_ENHANCED`, `PASSTHROUGH`, `DATERANGE`" => lambda { |v| %w{NONE SCTE35_ENHANCED PASSTHROUGH DATERANGE}.include? v[:AdMarkers] },
           "Subproperty `AdTriggers` is not a Array" => lambda { |v| v[:AdTriggers].is_a? Array },
           "Subproperty `ProgramDateTimeIntervalSeconds` is not a Integer" => lambda { |v| v[:ProgramDateTimeIntervalSeconds].is_a? Integer },
           "Subproperty `IncludeIframeOnlyStream` is not a Boolean" => lambda { |v| v[:IncludeIframeOnlyStream].is_a? Boolean },
           "Subproperty `UseAudioRenditionGroup` is not a Boolean" => lambda { |v| v[:UseAudioRenditionGroup].is_a? Boolean },
           "Subproperty `IncludeDvbSubtitles` is not a Boolean" => lambda { |v| v[:IncludeDvbSubtitles].is_a? Boolean },
         },
         description: ""

property :id, String,
         required: true,
         callbacks: {
           "id is not a String" => lambda { |v| v.is_a? String },
           "id needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "id must match pattern \A[0-9a-zA-Z-_]+\Z" => lambda { |v| v =~ Regexp.new("/\A[0-9a-zA-Z-_]+\Z/") },
         },
         description: <<~'DESCRIPTION'
           The ID of the OriginEndpoint.
         DESCRIPTION

property :manifest_name, String,
         callbacks: {
           "manifest_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A short string appended to the end of the OriginEndpoint URL.
         DESCRIPTION

property :mss_package, Hash,
         callbacks: {
           "Subproperty `ManifestWindowSeconds` is not a Integer" => lambda { |v| v[:ManifestWindowSeconds].is_a? Integer },
           "Subproperty `SegmentDurationSeconds` is not a Integer" => lambda { |v| v[:SegmentDurationSeconds].is_a? Integer },
         },
         description: ""

property :origination, String,
         callbacks: {
           "origination is not a String" => lambda { |v| v.is_a? String },
           "originationis not one of `ALLOW`, `DENY`" => lambda { |v| %w{ALLOW DENY}.include? v },
         },
         description: <<~'DESCRIPTION'
           Control whether origination of video is allowed for this OriginEndpoint. If set to ALLOW, the OriginEndpoint may by requested, pursuant to any other form of access control. If set to DENY, the OriginEndpoint may not be requested. This can be helpful for Live to VOD harvesting, or for temporarily disabling origination
         DESCRIPTION

property :startover_window_seconds, Integer,
         callbacks: {
           "startover_window_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           Maximum duration (seconds) of content to retain for startover playback. If not specified, startover playback will be disabled for the OriginEndpoint.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A collection of tags associated with a resource
         DESCRIPTION

property :time_delay_seconds, Integer,
         callbacks: {
           "time_delay_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           Amount of delay (seconds) to enforce on the playback of live content. If not specified, there will be no time delay in effect for the OriginEndpoint.
         DESCRIPTION

property :whitelist, Array,
         callbacks: {
           "whitelist is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of source IP CIDR blocks that will be allowed to access the OriginEndpoint.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::MediaPackage::OriginEndpoint"
rest_api_document "/AWS::MediaPackage::OriginEndpoint"

rest_property_map({
  authorization:            "Authorization",
  channel_id:               "ChannelId",
  cmaf_package:             "CmafPackage",
  dash_package:             "DashPackage",
  description:              "Description",
  hls_package:              "HlsPackage",
  id:                       "Id",
  manifest_name:            "ManifestName",
  mss_package:              "MssPackage",
  origination:              "Origination",
  startover_window_seconds: "StartoverWindowSeconds",
  tags:                     "Tags",
  time_delay_seconds:       "TimeDelaySeconds",
  whitelist:                "Whitelist",
})

rest_post_only_properties %i{
  id
}
