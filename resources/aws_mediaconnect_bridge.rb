# Import API specifics
use "awscc_base"

resource_name :aws_mediaconnect_bridge
provides :aws_mediaconnect_bridge, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::MediaConnect::Bridge
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :egress_gateway_bridge, Hash,
         callbacks: {
           "Subproperty `MaxBitrate` is not a Integer" => lambda { |v| v[:MaxBitrate].is_a? Integer },
         },
         description: ""

property :ingress_gateway_bridge, Hash,
         callbacks: {
           "Subproperty `MaxBitrate` is not a Integer" => lambda { |v| v[:MaxBitrate].is_a? Integer },
           "Subproperty `MaxOutputs` is not a Integer" => lambda { |v| v[:MaxOutputs].is_a? Integer },
         },
         description: ""

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the bridge.
         DESCRIPTION

property :outputs, Array,
         callbacks: {
           "outputs is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The outputs on this bridge.
         DESCRIPTION

property :placement_arn, String,
         required: true,
         callbacks: {
           "placement_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The placement Amazon Resource Number (ARN) of the bridge.
         DESCRIPTION

property :source_failover_config, Hash,
         description: ""

property :sources, Array,
         required: true,
         callbacks: {
           "sources is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The sources on this bridge.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::MediaConnect::Bridge"
rest_api_document "/AWS::MediaConnect::Bridge"

rest_property_map({
  egress_gateway_bridge:  "EgressGatewayBridge",
  ingress_gateway_bridge: "IngressGatewayBridge",
  name:                   "Name",
  outputs:                "Outputs",
  placement_arn:          "PlacementArn",
  source_failover_config: "SourceFailoverConfig",
  sources:                "Sources",
})

