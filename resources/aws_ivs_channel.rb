# Import API specifics
use "awscc_base"

resource_name :aws_ivs_channel
provides :aws_ivs_channel, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::IVS::Channel
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :authorized, [TrueClass, FalseClass],
         callbacks: {
           "authorized is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Whether the channel is authorized.
         DESCRIPTION

property :latency_mode, String,
         callbacks: {
           "latency_mode is not a String" => lambda { |v| v.is_a? String },
           "latency_modeis not one of `NORMAL`, `LOW`" => lambda { |v| %w{NORMAL LOW}.include? v },
         },
         description: <<~'DESCRIPTION'
           Channel latency mode.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 0..128 characters" => lambda { |v| v.length >= 0 && v.length <= 128 },
           "name must match pattern ^[a-zA-Z0-9-_]*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9-_]*$/") },
         },
         description: <<~'DESCRIPTION'
           Channel
         DESCRIPTION

property :recording_configuration_arn, String,
         callbacks: {
           "recording_configuration_arn is not a String" => lambda { |v| v.is_a? String },
           "recording_configuration_arn needs to be 0..128 characters" => lambda { |v| v.length >= 0 && v.length <= 128 },
           "recording_configuration_arn must match pattern ^$|arn:aws:ivs:[a-z0-9-]+:[0-9]+:recording-configuration/[a-zA-Z0-9-]+$" => lambda { |v| v =~ Regexp.new("/^$|arn:aws:ivs:[a-z0-9-]+:[0-9]+:recording-configuration/[a-zA-Z0-9-]+$/") },
         },
         description: <<~'DESCRIPTION'
           Recording Configuration ARN. A value other than an empty string indicates that recording is enabled. Default: ?? (recording is disabled).
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of key-value pairs that contain metadata for the asset model.
         DESCRIPTION

property :type, String,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
           "typeis not one of `STANDARD`, `BASIC`" => lambda { |v| %w{STANDARD BASIC}.include? v },
         },
         description: <<~'DESCRIPTION'
           Channel type, which determines the allowable resolution and bitrate. If you exceed the allowable resolution or bitrate, the stream probably will disconnect immediately.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IVS::Channel"
rest_api_document "/AWS::IVS::Channel"

rest_property_map({
  authorized:                  "Authorized",
  latency_mode:                "LatencyMode",
  name:                        "Name",
  recording_configuration_arn: "RecordingConfigurationArn",
  tags:                        "Tags",
  type:                        "Type",
})

