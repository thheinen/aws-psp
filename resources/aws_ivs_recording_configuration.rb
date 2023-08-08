# Import API specifics
use "awscc_base"

resource_name :aws_ivs_recording_configuration
provides :aws_ivs_recording_configuration, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::IVS::RecordingConfiguration
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :destination_configuration, Hash,
         required: true,
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 0..128 characters" => lambda { |v| v.length >= 0 && v.length <= 128 },
           "name must match pattern ^[a-zA-Z0-9-_]*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9-_]*$/") },
         },
         description: <<~'DESCRIPTION'
           Recording Configuration Name.
         DESCRIPTION

property :recording_reconnect_window_seconds, Integer,
         callbacks: {
           "recording_reconnect_window_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           Recording Reconnect Window Seconds. (0 means disabled)
         DESCRIPTION

property :rendition_configuration, Hash,
         callbacks: {
           "Subproperty `RenditionSelection` is not a String" => lambda { |v| v[:RenditionSelection].is_a? String },
           "Subproperty `RenditionSelection`is not one of `ALL`, `NONE`, `CUSTOM`" => lambda { |v| %w{ALL NONE CUSTOM}.include? v[:RenditionSelection] },
           "Subproperty `Renditions` is not a Array" => lambda { |v| v[:Renditions].is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of key-value pairs that contain metadata for the asset model.
         DESCRIPTION

property :thumbnail_configuration, Hash,
         callbacks: {
           "Subproperty `RecordingMode` is not a String" => lambda { |v| v[:RecordingMode].is_a? String },
           "Subproperty `RecordingMode`is not one of `INTERVAL`, `DISABLED`" => lambda { |v| %w{INTERVAL DISABLED}.include? v[:RecordingMode] },
           "Subproperty `TargetIntervalSeconds` is not a Integer" => lambda { |v| v[:TargetIntervalSeconds].is_a? Integer },
           "Subproperty `Resolution` is not a String" => lambda { |v| v[:Resolution].is_a? String },
           "Subproperty `Resolution`is not one of `FULL_HD`, `HD`, `SD`, `LOWEST_RESOLUTION`" => lambda { |v| %w{FULL_HD HD SD LOWEST_RESOLUTION}.include? v[:Resolution] },
           "Subproperty `Storage` is not a Array" => lambda { |v| v[:Storage].is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::IVS::RecordingConfiguration"
rest_api_document "/AWS::IVS::RecordingConfiguration"

rest_property_map({
  destination_configuration:          "DestinationConfiguration",
  name:                               "Name",
  recording_reconnect_window_seconds: "RecordingReconnectWindowSeconds",
  rendition_configuration:            "RenditionConfiguration",
  tags:                               "Tags",
  thumbnail_configuration:            "ThumbnailConfiguration",
})

rest_post_only_properties %i{
  destination_configuration destination_configuration/s3 destination_configuration/s3/bucket_name name recording_reconnect_window_seconds rendition_configuration rendition_configuration/rendition_selection rendition_configuration/renditions thumbnail_configuration thumbnail_configuration/recording_mode thumbnail_configuration/resolution thumbnail_configuration/storage thumbnail_configuration/target_interval_seconds
}
