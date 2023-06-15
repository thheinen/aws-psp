# Import API specifics
use "awscc_base"

resource_name :aws_mediaconnect_bridge_output
provides :aws_mediaconnect_bridge_output, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::MediaConnect::BridgeOutput
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :bridge_arn, String,
         required: true,
         callbacks: {
           "bridge_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Number (ARN) of the bridge.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The network output name.
         DESCRIPTION

property :network_output, Hash,
         required: true,
         callbacks: {
           "Subproperty `Protocol` is not a String" => lambda { |v| v[:Protocol].is_a? String },
           "Subproperty `Protocol`is not one of `rtp-fec`, `rtp`, `udp`" => lambda { |v| %w{rtp-fec rtp udp}.include? v[:Protocol] },
           "Subproperty `IpAddress` is not a String" => lambda { |v| v[:IpAddress].is_a? String },
           "Subproperty `Port` is not a Integer" => lambda { |v| v[:Port].is_a? Integer },
           "Subproperty `NetworkName` is not a String" => lambda { |v| v[:NetworkName].is_a? String },
           "Subproperty `Ttl` is not a Integer" => lambda { |v| v[:Ttl].is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The output of the bridge.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::MediaConnect::BridgeOutput"
rest_api_document "/AWS::MediaConnect::BridgeOutput"

rest_property_map({
  bridge_arn:     "BridgeArn",
  name:           "Name",
  network_output: "NetworkOutput",
})

rest_post_only_properties %i{
  bridge_arn name
}
