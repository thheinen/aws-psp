# Import API specifics
use "awscc_base"

resource_name :aws_mediaconnect_flow_source
provides :aws_mediaconnect_flow_source, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::MediaConnect::FlowSource
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :decryption, Hash,
         callbacks: {
           "Subproperty `Algorithm` is not a String" => lambda { |v| v[:Algorithm].is_a? String },
           "Subproperty `Algorithm`is not one of `aes128`, `aes192`, `aes256`" => lambda { |v| %w{aes128 aes192 aes256}.include? v[:Algorithm] },
           "Subproperty `ConstantInitializationVector` is not a String" => lambda { |v| v[:ConstantInitializationVector].is_a? String },
           "Subproperty `DeviceId` is not a String" => lambda { |v| v[:DeviceId].is_a? String },
           "Subproperty `KeyType` is not a String" => lambda { |v| v[:KeyType].is_a? String },
           "Subproperty `KeyType`is not one of `speke`, `static-key`, `srt-password`" => lambda { |v| %w{speke static-key srt-password}.include? v[:KeyType] },
           "Subproperty `Region` is not a String" => lambda { |v| v[:Region].is_a? String },
           "Subproperty `ResourceId` is not a String" => lambda { |v| v[:ResourceId].is_a? String },
           "Subproperty `RoleArn` is not a String" => lambda { |v| v[:RoleArn].is_a? String },
           "Subproperty `RoleArn`is not a valid ARN" => lambda { |v| v[:RoleArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `SecretArn` is not a String" => lambda { |v| v[:SecretArn].is_a? String },
           "Subproperty `SecretArn`is not a valid ARN" => lambda { |v| v[:SecretArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `Url` is not a String" => lambda { |v| v[:Url].is_a? String },
         },
         description: <<~'DESCRIPTION'
           The type of encryption that is used on the content ingested from this source.
         DESCRIPTION

property :description, String,
         required: true,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A description for the source. This value is not used or seen outside of the current AWS Elemental MediaConnect account.
         DESCRIPTION

property :entitlement_arn, String,
         callbacks: {
           "entitlement_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ARN of the entitlement that allows you to subscribe to content that comes from another AWS account. The entitlement is set by the content originator and the ARN is generated as part of the originator's flow.
         DESCRIPTION

property :flow_arn, String,
         callbacks: {
           "flow_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ARN of the flow.
         DESCRIPTION

property :ingest_port, Integer,
         callbacks: {
           "ingest_port is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The port that the flow will be listening on for incoming content.
         DESCRIPTION

property :max_bitrate, Integer,
         callbacks: {
           "max_bitrate is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The smoothing max bitrate for RIST, RTP, and RTP-FEC streams.
         DESCRIPTION

property :max_latency, Integer,
         callbacks: {
           "max_latency is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The maximum latency in milliseconds. This parameter applies only to RIST-based and Zixi-based streams.
         DESCRIPTION

property :min_latency, Integer,
         callbacks: {
           "min_latency is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The minimum latency in milliseconds.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the source.
         DESCRIPTION

property :protocol, String,
         callbacks: {
           "protocol is not a String" => lambda { |v| v.is_a? String },
           "protocolis not one of `zixi-push`, `rtp-fec`, `rtp`, `rist`, `srt-listener`, `srt-caller`" => lambda { |v| %w{zixi-push rtp-fec rtp rist srt-listener srt-caller}.include? v },
         },
         description: <<~'DESCRIPTION'
           The protocol that is used by the source.
         DESCRIPTION

property :sender_control_port, Integer,
         callbacks: {
           "sender_control_port is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The port that the flow uses to send outbound requests to initiate connection with the sender for fujitsu-qos protocol.
         DESCRIPTION

property :sender_ip_address, String,
         callbacks: {
           "sender_ip_address is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The IP address that the flow communicates with to initiate connection with the sender for fujitsu-qos protocol.
         DESCRIPTION

property :source_listener_address, String,
         callbacks: {
           "source_listener_address is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Source IP or domain name for SRT-caller protocol.
         DESCRIPTION

property :source_listener_port, Integer,
         callbacks: {
           "source_listener_port is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           Source port for SRT-caller protocol.
         DESCRIPTION

property :stream_id, String,
         callbacks: {
           "stream_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The stream ID that you want to use for this transport. This parameter applies only to Zixi-based streams.
         DESCRIPTION

property :vpc_interface_name, String,
         callbacks: {
           "vpc_interface_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the VPC Interface this Source is configured with.
         DESCRIPTION

property :whitelist_cidr, String,
         callbacks: {
           "whitelist_cidr is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The range of IP addresses that should be allowed to contribute content to your source. These IP addresses should be in the form of a Classless Inter-Domain Routing (CIDR) block; for example, 10.0.0.0/16.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::MediaConnect::FlowSource"
rest_api_document "/AWS::MediaConnect::FlowSource"

rest_property_map({
  decryption:              "Decryption",
  description:             "Description",
  entitlement_arn:         "EntitlementArn",
  flow_arn:                "FlowArn",
  ingest_port:             "IngestPort",
  max_bitrate:             "MaxBitrate",
  max_latency:             "MaxLatency",
  min_latency:             "MinLatency",
  name:                    "Name",
  protocol:                "Protocol",
  sender_control_port:     "SenderControlPort",
  sender_ip_address:       "SenderIpAddress",
  source_listener_address: "SourceListenerAddress",
  source_listener_port:    "SourceListenerPort",
  stream_id:               "StreamId",
  vpc_interface_name:      "VpcInterfaceName",
  whitelist_cidr:          "WhitelistCidr",
})

rest_post_only_properties %i{
  name
}
