# Import API specifics
use "awscc_base"

resource_name :aws_iot_wireless_service_profile
provides :aws_iot_wireless_service_profile, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  An example resource schema demonstrating some basic constructs and validation rules.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :lo_ra_wan, Hash,
         callbacks: {
           "Subproperty `UlRate` is not a Integer" => lambda { |v| v[:UlRate].is_a? Integer },
           "Subproperty `UlBucketSize` is not a Integer" => lambda { |v| v[:UlBucketSize].is_a? Integer },
           "Subproperty `UlRatePolicy` is not a String" => lambda { |v| v[:UlRatePolicy].is_a? String },
           "Subproperty `DlRate` is not a Integer" => lambda { |v| v[:DlRate].is_a? Integer },
           "Subproperty `DlBucketSize` is not a Integer" => lambda { |v| v[:DlBucketSize].is_a? Integer },
           "Subproperty `DlRatePolicy` is not a String" => lambda { |v| v[:DlRatePolicy].is_a? String },
           "Subproperty `AddGwMetadata` is not a Boolean" => lambda { |v| v[:AddGwMetadata].is_a? Boolean },
           "Subproperty `DevStatusReqFreq` is not a Integer" => lambda { |v| v[:DevStatusReqFreq].is_a? Integer },
           "Subproperty `ReportDevStatusBattery` is not a Boolean" => lambda { |v| v[:ReportDevStatusBattery].is_a? Boolean },
           "Subproperty `ReportDevStatusMargin` is not a Boolean" => lambda { |v| v[:ReportDevStatusMargin].is_a? Boolean },
           "Subproperty `DrMin` is not a Integer" => lambda { |v| v[:DrMin].is_a? Integer },
           "Subproperty `DrMax` is not a Integer" => lambda { |v| v[:DrMax].is_a? Integer },
           "Subproperty `ChannelMask` is not a String" => lambda { |v| v[:ChannelMask].is_a? String },
           "Subproperty `PrAllowed` is not a Boolean" => lambda { |v| v[:PrAllowed].is_a? Boolean },
           "Subproperty `HrAllowed` is not a Boolean" => lambda { |v| v[:HrAllowed].is_a? Boolean },
           "Subproperty `RaAllowed` is not a Boolean" => lambda { |v| v[:RaAllowed].is_a? Boolean },
           "Subproperty `NwkGeoLoc` is not a Boolean" => lambda { |v| v[:NwkGeoLoc].is_a? Boolean },
           "Subproperty `TargetPer` is not a Integer" => lambda { |v| v[:TargetPer].is_a? Integer },
           "Subproperty `MinGwDiversity` is not a Integer" => lambda { |v| v[:MinGwDiversity].is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           LoRaWAN supports all LoRa specific attributes for service profile for CreateServiceProfile operation
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
           A list of key-value pairs that contain metadata for the service profile.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IoTWireless::ServiceProfile"
rest_api_document "/AWS::IoTWireless::ServiceProfile"

rest_property_map({
  lo_ra_wan: "LoRaWAN",
  name:      "Name",
  tags:      "Tags",
})

