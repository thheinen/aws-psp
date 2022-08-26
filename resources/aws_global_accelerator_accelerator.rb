# Import API specifics
use "awscc_base"

resource_name :aws_global_accelerator_accelerator
provides :aws_global_accelerator_accelerator, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::GlobalAccelerator::Accelerator
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :enabled, [TrueClass, FalseClass],
         callbacks: {
           "enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: "Indicates whether an accelerator is enabled. The value is true or false."

property :ip_address_type, String,
         callbacks: {
           "ip_address_type is not a String" => lambda { |v| v.is_a? String },
           "ip_address_typeis not one of `IPV4`, `IPV6`" => lambda { |v| %w{IPV4 IPV6}.include? v },
         },
         description: "IP Address type."

property :ip_addresses, Array,
         callbacks: {
           "ip_addresses is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The IP addresses from BYOIP Prefix pool."

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "name must match pattern ^[a-zA-Z0-9_-]{0,64}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_-]{0,64}$/") },
         },
         description: "Name of accelerator."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::GlobalAccelerator::Accelerator"
rest_api_document "/AWS::GlobalAccelerator::Accelerator"

rest_property_map({
  enabled:         "Enabled",
  ip_address_type: "IpAddressType",
  ip_addresses:    "IpAddresses",
  name:            "Name",
  tags:            "Tags",
})

