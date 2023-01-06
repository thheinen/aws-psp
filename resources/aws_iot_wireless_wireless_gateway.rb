# Import API specifics
use "awscc_base"

resource_name :aws_iot_wireless_wireless_gateway
provides :aws_iot_wireless_wireless_gateway, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Create and manage wireless gateways, including LoRa gateways.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Description of Wireless Gateway.
         DESCRIPTION

property :last_uplink_received_at, String,
         callbacks: {
           "last_uplink_received_at is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The date and time when the most recent uplink was received.
         DESCRIPTION

property :lo_ra_wan, Hash,
         required: true,
         callbacks: {
           "Subproperty `GatewayEui` is not a String" => lambda { |v| v[:GatewayEui].is_a? String },
           "Subproperty `GatewayEui` must match pattern ^(([0-9A-Fa-f]{2}-){7}|([0-9A-Fa-f]{2}:){7}|([0-9A-Fa-f]{2}\s){7}|([0-9A-Fa-f]{2}){7})([0-9A-Fa-f]{2})$" => lambda { |v| v[:GatewayEui] =~ Regexp.new("/^(([0-9A-Fa-f]{2}-){7}|([0-9A-Fa-f]{2}:){7}|([0-9A-Fa-f]{2}\s){7}|([0-9A-Fa-f]{2}){7})([0-9A-Fa-f]{2})$/") },
           "Subproperty `RfRegion` is not a String" => lambda { |v| v[:RfRegion].is_a? String },
         },
         description: <<~'DESCRIPTION'
           The combination of Package, Station and Model which represents the version of the LoRaWAN Wireless Gateway.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Name of Wireless Gateway.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of key-value pairs that contain metadata for the gateway.
         DESCRIPTION

property :thing_arn, String,
         callbacks: {
           "thing_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Thing Arn. Passed into Update to associate a Thing with the Wireless Gateway.
         DESCRIPTION

property :thing_name, String,
         callbacks: {
           "thing_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Thing Name. If there is a Thing created, this can be returned with a Get call.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IoTWireless::WirelessGateway"
rest_api_document "/AWS::IoTWireless::WirelessGateway"

rest_property_map({
  description:             "Description",
  last_uplink_received_at: "LastUplinkReceivedAt",
  lo_ra_wan:               "LoRaWAN",
  name:                    "Name",
  tags:                    "Tags",
  thing_arn:               "ThingArn",
  thing_name:              "ThingName",
})

