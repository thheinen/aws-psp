# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_sagemaker_device_fleet
provides :aws_sagemaker_device_fleet, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::SageMaker::DeviceFleet
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..800 characters" => lambda { |v| v.length >= 0 && v.length <= 800 },
           "description must match pattern [\S\s]+" => lambda { |v| v =~ Regexp.new("/[\S\s]+/") },
         },
         description: <<~'DESCRIPTION'
           Description for the edge device fleet
         DESCRIPTION

property :device_fleet_name, String,
         required: true,
         callbacks: {
           "device_fleet_name is not a String" => lambda { |v| v.is_a? String },
           "device_fleet_name needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
           "device_fleet_name must match pattern ^[a-zA-Z0-9](-*_*[a-zA-Z0-9])*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9](-*_*[a-zA-Z0-9])*$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the edge device fleet
         DESCRIPTION

property :output_config, Hash,
         required: true,
         callbacks: {
           "Subproperty `S3OutputLocation` is not a String" => lambda { |v| v[:S3OutputLocation].is_a? String },
           "Subproperty `S3OutputLocation` must match pattern ^s3://([^/]+)/?(.*)$" => lambda { |v| v[:S3OutputLocation] =~ Regexp.new("/^s3://([^/]+)/?(.*)$/") },
           "Subproperty `KmsKeyId` is not a String" => lambda { |v| v[:KmsKeyId].is_a? String },
           "Subproperty `KmsKeyId` needs to be 1..2048 characters" => lambda { |v| v[:KmsKeyId].length >= 1 && v[:KmsKeyId].length <= 2048 },
           "Subproperty `KmsKeyId` must match pattern [a-zA-Z0-9:_-]+" => lambda { |v| v[:KmsKeyId] =~ Regexp.new("/[a-zA-Z0-9:_-]+/") },
         },
         description: <<~'DESCRIPTION'
           S3 bucket and an ecryption key id (if available) to store outputs for the fleet
         DESCRIPTION

property :role_arn, String,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
           "role_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "role_arn must match pattern ^arn:aws[a-z\-]*:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+$" => lambda { |v| v =~ Regexp.new("/^arn:aws[a-z\-]*:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+$/") },
         },
         description: <<~'DESCRIPTION'
           Role associated with the device fleet
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Associate tags with the resource
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SageMaker::DeviceFleet"
rest_api_document "/AWS::SageMaker::DeviceFleet"

rest_property_map({
  description:       "Description",
  device_fleet_name: "DeviceFleetName",
  output_config:     "OutputConfig",
  role_arn:          "RoleArn",
  tags:              "Tags",
})

rest_post_only_properties %i{
  device_fleet_name
}
