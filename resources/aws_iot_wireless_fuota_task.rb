# Import API specifics
use "awscc_base"

resource_name :aws_iot_wireless_fuota_task
provides :aws_iot_wireless_fuota_task, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Create and manage FUOTA tasks.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :associate_multicast_group, String,
         callbacks: {
           "associate_multicast_group is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Multicast group to associate. Only for update request.
         DESCRIPTION

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
           FUOTA task description
         DESCRIPTION

property :disassociate_multicast_group, String,
         callbacks: {
           "disassociate_multicast_group is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Multicast group to disassociate. Only for update request.
         DESCRIPTION

property :disassociate_wireless_device, String,
         callbacks: {
           "disassociate_wireless_device is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Wireless device to disassociate. Only for update request.
         DESCRIPTION

property :firmware_update_image, String,
         required: true,
         callbacks: {
           "firmware_update_image is not a String" => lambda { |v| v.is_a? String },
           "firmware_update_image needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
         },
         description: <<~'DESCRIPTION'
           FUOTA task firmware update image binary S3 link
         DESCRIPTION

property :firmware_update_role, String,
         required: true,
         callbacks: {
           "firmware_update_role is not a String" => lambda { |v| v.is_a? String },
           "firmware_update_role needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
         },
         description: <<~'DESCRIPTION'
           FUOTA task firmware IAM role for reading S3
         DESCRIPTION

property :lo_ra_wan, Hash,
         required: true,
         callbacks: {
           "Subproperty `StartTime` is not a String" => lambda { |v| v[:StartTime].is_a? String },
           "Subproperty `RfRegion` is not a String" => lambda { |v| v[:RfRegion].is_a? String },
           "Subproperty `RfRegion` needs to be 1..64 characters" => lambda { |v| v[:RfRegion].length >= 1 && v[:RfRegion].length <= 64 },
         },
         description: <<~'DESCRIPTION'
           FUOTA task LoRaWAN
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Name of FUOTA task
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of key-value pairs that contain metadata for the FUOTA task.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IoTWireless::FuotaTask"
rest_api_document "/AWS::IoTWireless::FuotaTask"

rest_property_map({
  associate_multicast_group:    "AssociateMulticastGroup",
  associate_wireless_device:    "AssociateWirelessDevice",
  description:                  "Description",
  disassociate_multicast_group: "DisassociateMulticastGroup",
  disassociate_wireless_device: "DisassociateWirelessDevice",
  firmware_update_image:        "FirmwareUpdateImage",
  firmware_update_role:         "FirmwareUpdateRole",
  lo_ra_wan:                    "LoRaWAN",
  name:                         "Name",
  tags:                         "Tags",
})

