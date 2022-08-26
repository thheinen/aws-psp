# Import API specifics
use "awscc_base"

resource_name :aws_iam_virtual_mfa_device
provides :aws_iam_virtual_mfa_device, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::IAM::VirtualMFADevice
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :path, String,
         callbacks: {
           "path is not a String" => lambda { |v| v.is_a? String },
           "path needs to be 1..512 characters" => lambda { |v| v.length >= 1 && v.length <= 512 },
           "path must match pattern (\u002F)|(\u002F[\u0021-\u007F]+\u002F)" => lambda { |v| v =~ Regexp.new("/(\u002F)|(\u002F[\u0021-\u007F]+\u002F)/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :users, Array,
         required: true,
         callbacks: {
           "users is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :virtual_mfa_device_name, String,
         callbacks: {
           "virtual_mfa_device_name is not a String" => lambda { |v| v.is_a? String },
           "virtual_mfa_device_name needs to be 1..226 characters" => lambda { |v| v.length >= 1 && v.length <= 226 },
           "virtual_mfa_device_name must match pattern [\w+=,.@-]+" => lambda { |v| v =~ Regexp.new("/[\w+=,.@-]+/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::IAM::VirtualMFADevice"
rest_api_document "/AWS::IAM::VirtualMFADevice"

rest_property_map({
  path:                    "Path",
  tags:                    "Tags",
  users:                   "Users",
  virtual_mfa_device_name: "VirtualMfaDeviceName",
})

rest_post_only_properties %i{
  base32_string_seed path virtual_mfa_device_name
}
