# Import API specifics
use "awscc_base"

resource_name :aws_iot_wireless_multicast_group
provides :aws_iot_wireless_multicast_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Create and manage Multicast groups.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :associate_wireless_device, String,
         callbacks: {
           "associate_wireless_device is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Wireless device to associate. Only for update request.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Multicast group description
         DESCRIPTION

property :disassociate_wireless_device, String,
         callbacks: {
           "disassociate_wireless_device is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Wireless device to disassociate. Only for update request.
         DESCRIPTION

property :lo_ra_wan, Hash,
         required: true,
         callbacks: {
           "Subproperty `RfRegion` is not a String" => lambda { |v| v[:RfRegion].is_a? String },
           "Subproperty `RfRegion` needs to be 1..64 characters" => lambda { |v| v[:RfRegion].length >= 1 && v[:RfRegion].length <= 64 },
           "Subproperty `DlClass` is not a String" => lambda { |v| v[:DlClass].is_a? String },
           "Subproperty `DlClass` needs to be 1..64 characters" => lambda { |v| v[:DlClass].length >= 1 && v[:DlClass].length <= 64 },
           "Subproperty `NumberOfDevicesRequested` is not a Integer" => lambda { |v| v[:NumberOfDevicesRequested].is_a? Integer },
           "Subproperty `NumberOfDevicesInGroup` is not a Integer" => lambda { |v| v[:NumberOfDevicesInGroup].is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           Multicast group LoRaWAN
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Name of Multicast group
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of key-value pairs that contain metadata for the Multicast group.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IoTWireless::MulticastGroup"
rest_api_document "/AWS::IoTWireless::MulticastGroup"

rest_property_map({
  associate_wireless_device:    "AssociateWirelessDevice",
  description:                  "Description",
  disassociate_wireless_device: "DisassociateWirelessDevice",
  lo_ra_wan:                    "LoRaWAN",
  name:                         "Name",
  tags:                         "Tags",
})

