# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_ec2_prefix_list
provides :aws_ec2_prefix_list, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema of AWS::EC2::PrefixList Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :address_family, String,
         required: true,
         callbacks: {
           "address_family is not a String" => lambda { |v| v.is_a? String },
           "address_familyis not one of `IPv4`, `IPv6`" => lambda { |v| %w{IPv4 IPv6}.include? v },
         },
         description: <<~'DESCRIPTION'
           Ip Version of Prefix List.
         DESCRIPTION

property :entries, Array,
         callbacks: {
           "entries is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Entries of Prefix List.
         DESCRIPTION

property :max_entries, Integer,
         required: true,
         callbacks: {
           "max_entries is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           Max Entries of Prefix List.
         DESCRIPTION

property :prefix_list_name, String,
         required: true,
         callbacks: {
           "prefix_list_name is not a String" => lambda { |v| v.is_a? String },
           "prefix_list_name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           Name of Prefix List.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Tags for Prefix List
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::PrefixList"
rest_api_document "/AWS::EC2::PrefixList"

rest_property_map({
  address_family:   "AddressFamily",
  entries:          "Entries",
  max_entries:      "MaxEntries",
  prefix_list_name: "PrefixListName",
  tags:             "Tags",
})

