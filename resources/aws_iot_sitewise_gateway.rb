# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_iot_sitewise_gateway
provides :aws_iot_sitewise_gateway, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::IoTSiteWise::Gateway
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :gateway_capability_summaries, Array,
         callbacks: {
           "gateway_capability_summaries is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of gateway capability summaries that each contain a namespace and status.
         DESCRIPTION

property :gateway_name, String,
         required: true,
         callbacks: {
           "gateway_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A unique, friendly name for the gateway.
         DESCRIPTION

property :gateway_platform, Hash,
         required: true,
         description: <<~'DESCRIPTION'
           The gateway's platform. You can only specify one platform in a gateway.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of key-value pairs that contain metadata for the gateway.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IoTSiteWise::Gateway"
rest_api_document "/AWS::IoTSiteWise::Gateway"

rest_property_map({
  gateway_capability_summaries: "GatewayCapabilitySummaries",
  gateway_name:                 "GatewayName",
  gateway_platform:             "GatewayPlatform",
  tags:                         "Tags",
})

rest_post_only_properties %i{
  gateway_platform
}
