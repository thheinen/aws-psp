# Import API specifics
use "awscc_base"

resource_name :aws_iot_wireless_wireless_device
provides :aws_iot_wireless_wireless_device, target_mode: true, platform: "aws"

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
           Wireless device description
         DESCRIPTION

property :destination_name, String,
         required: true,
         callbacks: {
           "destination_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Wireless device destination name
         DESCRIPTION

property :last_uplink_received_at, String,
         callbacks: {
           "last_uplink_received_at is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The date and time when the most recent uplink was received.
         DESCRIPTION

property :lo_ra_wan, Hash,
         callbacks: {
           "Subproperty `DevEui` is not a String" => lambda { |v| v[:DevEui].is_a? String },
           "Subproperty `DevEui` must match pattern [a-f0-9]{16}" => lambda { |v| v[:DevEui] =~ Regexp.new("/[a-f0-9]{16}/") },
           "Subproperty `DeviceProfileId` is not a String" => lambda { |v| v[:DeviceProfileId].is_a? String },
           "Subproperty `ServiceProfileId` is not a String" => lambda { |v| v[:ServiceProfileId].is_a? String },
         },
         description: <<~'DESCRIPTION'
           The combination of Package, Station and Model which represents the version of the LoRaWAN Wireless Device.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Wireless device name
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of key-value pairs that contain metadata for the device. Currently not supported, will not create if tags are passed.
         DESCRIPTION

property :thing_arn, String,
         callbacks: {
           "thing_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Thing arn. Passed into update to associate Thing with Wireless device.
         DESCRIPTION

property :type, String,
         required: true,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
           "typeis not one of `Sidewalk`, `LoRaWAN`" => lambda { |v| %w{Sidewalk LoRaWAN}.include? v },
         },
         description: <<~'DESCRIPTION'
           Wireless device type, currently only Sidewalk and LoRa
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IoTWireless::WirelessDevice"
rest_api_document "/AWS::IoTWireless::WirelessDevice"

rest_property_map({
  description:             "Description",
  destination_name:        "DestinationName",
  last_uplink_received_at: "LastUplinkReceivedAt",
  lo_ra_wan:               "LoRaWAN",
  name:                    "Name",
  tags:                    "Tags",
  thing_arn:               "ThingArn",
  type:                    "Type",
})

