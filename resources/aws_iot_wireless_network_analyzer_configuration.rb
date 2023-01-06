# Import API specifics
use "awscc_base"

resource_name :aws_iot_wireless_network_analyzer_configuration
provides :aws_iot_wireless_network_analyzer_configuration, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Create and manage NetworkAnalyzerConfiguration resource.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The description of the new resource
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name must match pattern ^[a-zA-Z0-9-_]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9-_]+$/") },
         },
         description: <<~'DESCRIPTION'
           Name of the network analyzer configuration
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

property :trace_content, Hash,
         description: <<~'DESCRIPTION'
           Trace content for your wireless gateway and wireless device resources
         DESCRIPTION

property :wireless_devices, Array,
         callbacks: {
           "wireless_devices is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           List of wireless gateway resources that have been added to the network analyzer configuration
         DESCRIPTION

property :wireless_gateways, Array,
         callbacks: {
           "wireless_gateways is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           List of wireless gateway resources that have been added to the network analyzer configuration
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IoTWireless::NetworkAnalyzerConfiguration"
rest_api_document "/AWS::IoTWireless::NetworkAnalyzerConfiguration"

rest_property_map({
  description:       "Description",
  name:              "Name",
  tags:              "Tags",
  trace_content:     "TraceContent",
  wireless_devices:  "WirelessDevices",
  wireless_gateways: "WirelessGateways",
})

rest_post_only_properties %i{
  name tags
}
