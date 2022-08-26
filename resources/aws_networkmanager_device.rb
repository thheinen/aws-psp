# Import API specifics
use "awscc_base"

resource_name :aws_networkmanager_device
provides :aws_networkmanager_device, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::NetworkManager::Device type describes a device.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The description of the device."

property :global_network_id, String,
         required: true,
         callbacks: {
           "global_network_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The ID of the global network."

property :location, Hash,
         callbacks: {
           "Subproperty `Address` is not a String" => lambda { |v| v[:Address].is_a? String },
           "Subproperty `Latitude` is not a String" => lambda { |v| v[:Latitude].is_a? String },
           "Subproperty `Longitude` is not a String" => lambda { |v| v[:Longitude].is_a? String },
         },
         description: "The site location."

property :model, String,
         callbacks: {
           "model is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The device model"

property :serial_number, String,
         callbacks: {
           "serial_number is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The device serial number."

property :site_id, String,
         callbacks: {
           "site_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The site ID."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The tags for the device."

property :type, String,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The device type."

property :vendor, String,
         callbacks: {
           "vendor is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The device vendor."

# API URLs and mappings
rest_api_collection "/AWS::NetworkManager::Device"
rest_api_document "/AWS::NetworkManager::Device"

rest_property_map({
  description:       "Description",
  global_network_id: "GlobalNetworkId",
  location:          "Location",
  model:             "Model",
  serial_number:     "SerialNumber",
  site_id:           "SiteId",
  tags:              "Tags",
  type:              "Type",
  vendor:            "Vendor",
})

rest_post_only_properties %i{
  global_network_id
}
