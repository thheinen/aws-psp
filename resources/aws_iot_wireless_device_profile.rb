# Import API specifics
use "awscc_base"

resource_name :aws_iot_wireless_device_profile
provides :aws_iot_wireless_device_profile, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Device Profile's resource schema demonstrating some basic constructs and validation rules.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :lo_ra_wan, Hash,
         callbacks: {
           "Subproperty `SupportsClassB` is not a Boolean" => lambda { |v| v[:SupportsClassB].is_a? Boolean },
           "Subproperty `ClassBTimeout` is not a Integer" => lambda { |v| v[:ClassBTimeout].is_a? Integer },
           "Subproperty `PingSlotPeriod` is not a Integer" => lambda { |v| v[:PingSlotPeriod].is_a? Integer },
           "Subproperty `PingSlotDr` is not a Integer" => lambda { |v| v[:PingSlotDr].is_a? Integer },
           "Subproperty `PingSlotFreq` is not a Integer" => lambda { |v| v[:PingSlotFreq].is_a? Integer },
           "Subproperty `SupportsClassC` is not a Boolean" => lambda { |v| v[:SupportsClassC].is_a? Boolean },
           "Subproperty `ClassCTimeout` is not a Integer" => lambda { |v| v[:ClassCTimeout].is_a? Integer },
           "Subproperty `MacVersion` is not a String" => lambda { |v| v[:MacVersion].is_a? String },
           "Subproperty `RegParamsRevision` is not a String" => lambda { |v| v[:RegParamsRevision].is_a? String },
           "Subproperty `RxDelay1` is not a Integer" => lambda { |v| v[:RxDelay1].is_a? Integer },
           "Subproperty `RxDrOffset1` is not a Integer" => lambda { |v| v[:RxDrOffset1].is_a? Integer },
           "Subproperty `RxFreq2` is not a Integer" => lambda { |v| v[:RxFreq2].is_a? Integer },
           "Subproperty `RxDataRate2` is not a Integer" => lambda { |v| v[:RxDataRate2].is_a? Integer },
           "Subproperty `FactoryPresetFreqsList` is not a Array" => lambda { |v| v[:FactoryPresetFreqsList].is_a? Array },
           "Subproperty `MaxEirp` is not a Integer" => lambda { |v| v[:MaxEirp].is_a? Integer },
           "Subproperty `MaxDutyCycle` is not a Integer" => lambda { |v| v[:MaxDutyCycle].is_a? Integer },
           "Subproperty `SupportsJoin` is not a Boolean" => lambda { |v| v[:SupportsJoin].is_a? Boolean },
           "Subproperty `RfRegion` is not a String" => lambda { |v| v[:RfRegion].is_a? String },
           "Subproperty `Supports32BitFCnt` is not a Boolean" => lambda { |v| v[:Supports32BitFCnt].is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           LoRaWANDeviceProfile supports all LoRa specific attributes for service profile for CreateDeviceProfile operation
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Name of service profile
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of key-value pairs that contain metadata for the device profile.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IoTWireless::DeviceProfile"
rest_api_document "/AWS::IoTWireless::DeviceProfile"

rest_property_map({
  lo_ra_wan: "LoRaWAN",
  name:      "Name",
  tags:      "Tags",
})

