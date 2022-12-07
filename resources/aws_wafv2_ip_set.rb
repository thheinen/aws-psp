# Import API specifics
use "awscc_base"

resource_name :aws_wafv2_ip_set
provides :aws_wafv2_ip_set, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Contains a list of IP addresses. This can be either IPV4 or IPV6. The list will be mutually
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :addresses, Array,
         required: true,
         callbacks: {
           "addresses is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           List of IPAddresses.
         DESCRIPTION

property :description, Hash,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description must match pattern ^[a-zA-Z0-9=:#@/\-,.][a-zA-Z0-9+=:#@/\-,.\s]+[a-zA-Z0-9+=:#@/\-,.]{1,256}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9=:#@/\-,.][a-zA-Z0-9+=:#@/\-,.\s]+[a-zA-Z0-9+=:#@/\-,.]{1,256}$/") },
         },
         description: ""

property :ip_address_version, Hash,
         required: true,
         callbacks: {
           "ip_address_version is not a String" => lambda { |v| v.is_a? String },
           "ip_address_versionis not one of `IPV4`, `IPV6`" => lambda { |v| %w{IPV4 IPV6}.include? v },
         },
         description: ""

property :name, Hash,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name must match pattern ^[0-9A-Za-z_-]{1,128}$" => lambda { |v| v =~ Regexp.new("/^[0-9A-Za-z_-]{1,128}$/") },
         },
         description: ""

property :scope, Hash,
         required: true,
         callbacks: {
           "scope is not a String" => lambda { |v| v.is_a? String },
           "scopeis not one of `CLOUDFRONT`, `REGIONAL`" => lambda { |v| %w{CLOUDFRONT REGIONAL}.include? v },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::WAFv2::IPSet"
rest_api_document "/AWS::WAFv2::IPSet"

rest_property_map({
  addresses:          "Addresses",
  description:        "Description",
  ip_address_version: "IPAddressVersion",
  name:               "Name",
  scope:              "Scope",
  tags:               "Tags",
})

rest_post_only_properties %i{
  name scope
}
