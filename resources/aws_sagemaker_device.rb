# Import API specifics
use "awscc_base"

resource_name :aws_sagemaker_device
provides :aws_sagemaker_device, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::SageMaker::Device
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :device, Hash,
         callbacks: {
           "Subproperty `Description` is not a String" => lambda { |v| v[:Description].is_a? String },
           "Subproperty `Description` needs to be 1..40 characters" => lambda { |v| v[:Description].length >= 1 && v[:Description].length <= 40 },
           "Subproperty `Description` must match pattern [\S\s]+" => lambda { |v| v[:Description] =~ Regexp.new("/[\S\s]+/") },
           "Subproperty `DeviceName` is not a String" => lambda { |v| v[:DeviceName].is_a? String },
           "Subproperty `DeviceName` needs to be 1..63 characters" => lambda { |v| v[:DeviceName].length >= 1 && v[:DeviceName].length <= 63 },
           "Subproperty `DeviceName` must match pattern ^[a-zA-Z0-9](-*[a-zA-Z0-9])*$" => lambda { |v| v[:DeviceName] =~ Regexp.new("/^[a-zA-Z0-9](-*[a-zA-Z0-9])*$/") },
           "Subproperty `IotThingName` is not a String" => lambda { |v| v[:IotThingName].is_a? String },
           "Subproperty `IotThingName` must match pattern [a-zA-Z0-9:_-]+" => lambda { |v| v[:IotThingName] =~ Regexp.new("/[a-zA-Z0-9:_-]+/") },
         },
         description: "The Edge Device you want to register against a device fleet"

property :device_fleet_name, String,
         required: true,
         callbacks: {
           "device_fleet_name is not a String" => lambda { |v| v.is_a? String },
           "device_fleet_name needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
           "device_fleet_name must match pattern ^[a-zA-Z0-9](-*_*[a-zA-Z0-9])*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9](-*_*[a-zA-Z0-9])*$/") },
         },
         description: "The name of the edge device fleet"

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "Associate tags with the resource"

# API URLs and mappings
rest_api_collection "/AWS::SageMaker::Device"
rest_api_document "/AWS::SageMaker::Device"

rest_property_map({
  device:            "Device",
  device_fleet_name: "DeviceFleetName",
  tags:              "Tags",
})

rest_post_only_properties %i{
  device/device_name
}
