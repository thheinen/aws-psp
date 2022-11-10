# Import API specifics
use "awscc_base"

resource_name :aws_networkfirewall_firewall
provides :aws_networkfirewall_firewall, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource type definition for AWS::NetworkFirewall::Firewall
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :delete_protection, [TrueClass, FalseClass],
         callbacks: {
           "delete_protection is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description must match pattern ^.*$" => lambda { |v| v =~ Regexp.new("/^.*$/") },
         },
         description: ""

property :firewall_name, String,
         required: true,
         callbacks: {
           "firewall_name is not a String" => lambda { |v| v.is_a? String },
           "firewall_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "firewall_name must match pattern ^[a-zA-Z0-9-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9-]+$/") },
         },
         description: ""

property :firewall_policy_arn, Hash,
         required: true,
         callbacks: {
           "firewall_policy_arn is not a String" => lambda { |v| v.is_a? String },
           "firewall_policy_arn needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "firewall_policy_arn must match pattern ^arn:aws.*$" => lambda { |v| v =~ Regexp.new("/^arn:aws.*$/") },
         },
         description: ""

property :firewall_policy_change_protection, [TrueClass, FalseClass],
         callbacks: {
           "firewall_policy_change_protection is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :subnet_change_protection, [TrueClass, FalseClass],
         callbacks: {
           "subnet_change_protection is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :subnet_mappings, Array,
         required: true,
         callbacks: {
           "subnet_mappings is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :vpc_id, String,
         required: true,
         callbacks: {
           "vpc_id is not a String" => lambda { |v| v.is_a? String },
           "vpc_id needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "vpc_id must match pattern ^vpc-[0-9a-f]+$" => lambda { |v| v =~ Regexp.new("/^vpc-[0-9a-f]+$/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::NetworkFirewall::Firewall"
rest_api_document "/AWS::NetworkFirewall::Firewall"

rest_property_map({
  delete_protection:                 "DeleteProtection",
  description:                       "Description",
  firewall_name:                     "FirewallName",
  firewall_policy_arn:               "FirewallPolicyArn",
  firewall_policy_change_protection: "FirewallPolicyChangeProtection",
  subnet_change_protection:          "SubnetChangeProtection",
  subnet_mappings:                   "SubnetMappings",
  tags:                              "Tags",
  vpc_id:                            "VpcId",
})

rest_post_only_properties %i{
  firewall_name vpc_id
}
