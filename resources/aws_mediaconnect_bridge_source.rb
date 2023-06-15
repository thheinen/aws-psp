# Import API specifics
use "awscc_base"

resource_name :aws_mediaconnect_bridge_source
provides :aws_mediaconnect_bridge_source, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::MediaConnect::BridgeSource
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

property :flow_source, Hash,
         callbacks: {
           "Subproperty `FlowArn` is not a String" => lambda { |v| v[:FlowArn].is_a? String },
           "Subproperty `FlowArn`is not a valid ARN" => lambda { |v| v[:FlowArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: ""

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the source.
         DESCRIPTION

property :network_source, Hash,
         callbacks: {
           "Subproperty `MulticastIp` is not a String" => lambda { |v| v[:MulticastIp].is_a? String },
           "Subproperty `Port` is not a Integer" => lambda { |v| v[:Port].is_a? Integer },
           "Subproperty `NetworkName` is not a String" => lambda { |v| v[:NetworkName].is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::MediaConnect::BridgeSource"
rest_api_document "/AWS::MediaConnect::BridgeSource"

rest_property_map({
  bridge_arn:     "BridgeArn",
  flow_source:    "FlowSource",
  name:           "Name",
  network_source: "NetworkSource",
})

rest_post_only_properties %i{
  bridge_arn name
}
