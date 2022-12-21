# Import API specifics
use "awscc_base"

resource_name :aws_mediatailor_playback_configuration
provides :aws_mediatailor_playback_configuration, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::MediaTailor::PlaybackConfiguration
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :ad_decision_server_url, String,
         required: true,
         callbacks: {
           "ad_decision_server_url is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The URL for the ad decision server (ADS). This includes the specification of static parameters and placeholders for dynamic parameters. AWS Elemental MediaTailor substitutes player-specific and session-specific parameters as needed when calling the ADS. Alternately, for testing you can provide a static VAST URL. The maximum length is 25,000 characters.
         DESCRIPTION

property :avail_suppression, Hash,
         callbacks: {
           "Subproperty `Mode` is not a String" => lambda { |v| v[:Mode].is_a? String },
           "Subproperty `Mode`is not one of `OFF`, `BEHIND_LIVE_EDGE`" => lambda { |v| %w{OFF BEHIND_LIVE_EDGE}.include? v[:Mode] },
           "Subproperty `Value` is not a String" => lambda { |v| v[:Value].is_a? String },
         },
         description: <<~'DESCRIPTION'
           The configuration for avail suppression, also known as ad suppression. For more information about ad suppression, see Ad Suppression (https://docs.aws.amazon.com/mediatailor/latest/ug/ad-behavior.html).
         DESCRIPTION

property :bumper, Hash,
         callbacks: {
           "Subproperty `StartUrl` is not a String" => lambda { |v| v[:StartUrl].is_a? String },
           "Subproperty `EndUrl` is not a String" => lambda { |v| v[:EndUrl].is_a? String },
         },
         description: <<~'DESCRIPTION'
           The configuration for bumpers. Bumpers are short audio or video clips that play at the start or before the end of an ad break. To learn more about bumpers, see Bumpers (https://docs.aws.amazon.com/mediatailor/latest/ug/bumpers.html).
         DESCRIPTION

property :cdn_configuration, Hash,
         callbacks: {
           "Subproperty `AdSegmentUrlPrefix` is not a String" => lambda { |v| v[:AdSegmentUrlPrefix].is_a? String },
           "Subproperty `ContentSegmentUrlPrefix` is not a String" => lambda { |v| v[:ContentSegmentUrlPrefix].is_a? String },
         },
         description: <<~'DESCRIPTION'
           The configuration for using a content delivery network (CDN), like Amazon CloudFront, for content and ad segment management.
         DESCRIPTION

property :configuration_aliases, Hash,
         description: <<~'DESCRIPTION'
           The player parameters and aliases used as dynamic variables during session initialization. For more information, see Domain Variables.
         DESCRIPTION

property :dash_configuration, Hash,
         callbacks: {
           "Subproperty `MpdLocation` is not a String" => lambda { |v| v[:MpdLocation].is_a? String },
           "Subproperty `OriginManifestType` is not a String" => lambda { |v| v[:OriginManifestType].is_a? String },
           "Subproperty `OriginManifestType`is not one of `SINGLE_PERIOD`, `MULTI_PERIOD`" => lambda { |v| %w{SINGLE_PERIOD MULTI_PERIOD}.include? v[:OriginManifestType] },
           "Subproperty `ManifestEndpointPrefix` is not a String" => lambda { |v| v[:ManifestEndpointPrefix].is_a? String },
         },
         description: <<~'DESCRIPTION'
           The configuration for DASH content.
         DESCRIPTION

property :hls_configuration, Hash,
         callbacks: {
           "Subproperty `ManifestEndpointPrefix` is not a String" => lambda { |v| v[:ManifestEndpointPrefix].is_a? String },
         },
         description: <<~'DESCRIPTION'
           The configuration for HLS content.
         DESCRIPTION

property :live_pre_roll_configuration, Hash,
         callbacks: {
           "Subproperty `AdDecisionServerUrl` is not a String" => lambda { |v| v[:AdDecisionServerUrl].is_a? String },
           "Subproperty `MaxDurationSeconds` is not a Integer" => lambda { |v| v[:MaxDurationSeconds].is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The configuration for pre-roll ad insertion.
         DESCRIPTION

property :manifest_processing_rules, Hash,
         description: <<~'DESCRIPTION'
           The configuration for manifest processing rules. Manifest processing rules enable customization of the personalized manifests created by MediaTailor.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "name must match pattern ^[a-zA-Z0-9_-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_-]+$/") },
         },
         description: <<~'DESCRIPTION'
           The identifier for the playback configuration.
         DESCRIPTION

property :personalization_threshold_seconds, Integer,
         callbacks: {
           "personalization_threshold_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           Defines the maximum duration of underfilled ad time (in seconds) allowed in an ad break. If the duration of underfilled ad time exceeds the personalization threshold, then the personalization of the ad break is abandoned and the underlying content is shown. This feature applies to ad replacement in live and VOD streams, rather than ad insertion, because it relies on an underlying content stream. For more information about ad break behavior, including ad replacement and insertion, see Ad Behavior in AWS Elemental MediaTailor (https://docs.aws.amazon.com/mediatailor/latest/ug/ad-behavior.html).
         DESCRIPTION

property :slate_ad_url, String,
         callbacks: {
           "slate_ad_url is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The URL for a high-quality video asset to transcode and use to fill in time that's not used by ads. AWS Elemental MediaTailor shows the slate to fill in gaps in media content. Configuring the slate is optional for non-VPAID configurations. For VPAID, the slate is required because MediaTailor provides it in the slots that are designated for dynamic ad content. The slate must be a high-quality asset that contains both audio and video.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags to assign to the playback configuration.
         DESCRIPTION

property :transcode_profile_name, String,
         callbacks: {
           "transcode_profile_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name that is used to associate this playback configuration with a custom transcode profile. This overrides the dynamic transcoding defaults of MediaTailor. Use this only if you have already set up custom profiles with the help of AWS Support.
         DESCRIPTION

property :video_content_source_url, String,
         required: true,
         callbacks: {
           "video_content_source_url is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The URL prefix for the parent manifest for the stream, minus the asset ID. The maximum length is 512 characters.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::MediaTailor::PlaybackConfiguration"
rest_api_document "/AWS::MediaTailor::PlaybackConfiguration"

rest_property_map({
  ad_decision_server_url:            "AdDecisionServerUrl",
  avail_suppression:                 "AvailSuppression",
  bumper:                            "Bumper",
  cdn_configuration:                 "CdnConfiguration",
  configuration_aliases:             "ConfigurationAliases",
  dash_configuration:                "DashConfiguration",
  hls_configuration:                 "HlsConfiguration",
  live_pre_roll_configuration:       "LivePreRollConfiguration",
  manifest_processing_rules:         "ManifestProcessingRules",
  name:                              "Name",
  personalization_threshold_seconds: "PersonalizationThresholdSeconds",
  slate_ad_url:                      "SlateAdUrl",
  tags:                              "Tags",
  transcode_profile_name:            "TranscodeProfileName",
  video_content_source_url:          "VideoContentSourceUrl",
})

rest_post_only_properties %i{
  name
}
