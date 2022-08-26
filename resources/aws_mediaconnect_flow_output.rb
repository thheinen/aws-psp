# Import API specifics
use "awscc_base"

resource_name :aws_mediaconnect_flow_output
provides :aws_mediaconnect_flow_output, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::MediaConnect::FlowOutput
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :cidr_allow_list, Array,
         callbacks: {
           "cidr_allow_list is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The range of IP addresses that should be allowed to initiate output requests to this flow. These IP addresses should be in the form of a Classless Inter-Domain Routing (CIDR) block; for example, 10.0.0.0/16."

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: "A description of the output."

property :destination, String,
         callbacks: {
           "destination is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The address where you want to send the output."

property :encryption, Hash,
         callbacks: {
           "Subproperty `Algorithm` is not a String" => lambda { |v| v[:Algorithm].is_a? String },
           "Subproperty `Algorithm`is not one of `aes128`, `aes192`, `aes256`" => lambda { |v| %w{aes128 aes192 aes256}.include? v[:Algorithm] },
           "Subproperty `KeyType` is not a String" => lambda { |v| v[:KeyType].is_a? String },
           "Subproperty `KeyType`is not one of `static-key`, `srt-password`" => lambda { |v| %w{static-key srt-password}.include? v[:KeyType] },
           "Subproperty `RoleArn` is not a String" => lambda { |v| v[:RoleArn].is_a? String },
           "Subproperty `RoleArn`is not a valid ARN" => lambda { |v| v[:RoleArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `SecretArn` is not a String" => lambda { |v| v[:SecretArn].is_a? String },
           "Subproperty `SecretArn`is not a valid ARN" => lambda { |v| v[:SecretArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: "The type of key used for the encryption. If no keyType is provided, the service will use the default setting (static-key)."

property :flow_arn, String,
         required: true,
         callbacks: {
           "flow_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The Amazon Resource Name (ARN), a unique identifier for any AWS resource, of the flow."

property :max_latency, Integer,
         callbacks: {
           "max_latency is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "The maximum latency in milliseconds. This parameter applies only to RIST-based and Zixi-based streams."

property :min_latency, Integer,
         callbacks: {
           "min_latency is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "The minimum latency in milliseconds."

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The name of the output. This value must be unique within the current flow."

property :port, Integer,
         callbacks: {
           "port is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "The port to use when content is distributed to this output."

property :protocol, String,
         required: true,
         callbacks: {
           "protocol is not a String" => lambda { |v| v.is_a? String },
           "protocolis not one of `zixi-push`, `rtp-fec`, `rtp`, `zixi-pull`, `rist`, `srt-listener`" => lambda { |v| %w{zixi-push rtp-fec rtp zixi-pull rist srt-listener}.include? v },
         },
         description: "The protocol that is used by the source or output."

property :remote_id, String,
         callbacks: {
           "remote_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The remote ID for the Zixi-pull stream."

property :smoothing_latency, Integer,
         callbacks: {
           "smoothing_latency is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "The smoothing latency in milliseconds for RIST, RTP, and RTP-FEC streams."

property :stream_id, String,
         callbacks: {
           "stream_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The stream ID that you want to use for this transport. This parameter applies only to Zixi-based streams."

property :vpc_interface_attachment, Hash,
         callbacks: {
           "Subproperty `VpcInterfaceName` is not a String" => lambda { |v| v[:VpcInterfaceName].is_a? String },
         },
         description: "The name of the VPC interface attachment to use for this output."

# API URLs and mappings
rest_api_collection "/AWS::MediaConnect::FlowOutput"
rest_api_document "/AWS::MediaConnect::FlowOutput"

rest_property_map({
  cidr_allow_list:          "CidrAllowList",
  description:              "Description",
  destination:              "Destination",
  encryption:               "Encryption",
  flow_arn:                 "FlowArn",
  max_latency:              "MaxLatency",
  min_latency:              "MinLatency",
  name:                     "Name",
  port:                     "Port",
  protocol:                 "Protocol",
  remote_id:                "RemoteId",
  smoothing_latency:        "SmoothingLatency",
  stream_id:                "StreamId",
  vpc_interface_attachment: "VpcInterfaceAttachment",
})

rest_post_only_properties %i{
  name
}
