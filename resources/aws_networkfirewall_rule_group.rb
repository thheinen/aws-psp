# Import API specifics
use "awscc_base"

resource_name :aws_networkfirewall_rule_group
provides :aws_networkfirewall_rule_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource type definition for AWS::NetworkFirewall::RuleGroup
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :capacity, Integer,
         required: true,
         callbacks: {
           "capacity is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..512 characters" => lambda { |v| v.length >= 1 && v.length <= 512 },
           "description must match pattern ^.*$" => lambda { |v| v =~ Regexp.new("/^.*$/") },
         },
         description: ""

property :rule_group, Hash,
         description: ""

property :rule_group_name, String,
         required: true,
         callbacks: {
           "rule_group_name is not a String" => lambda { |v| v.is_a? String },
           "rule_group_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "rule_group_name must match pattern ^[a-zA-Z0-9-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9-]+$/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :type, String,
         required: true,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
           "typeis not one of `STATELESS`, `STATEFUL`" => lambda { |v| %w{STATELESS STATEFUL}.include? v },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::NetworkFirewall::RuleGroup"
rest_api_document "/AWS::NetworkFirewall::RuleGroup"

rest_property_map({
  capacity:        "Capacity",
  description:     "Description",
  rule_group:      "RuleGroup",
  rule_group_name: "RuleGroupName",
  tags:            "Tags",
  type:            "Type",
})

rest_post_only_properties %i{
  capacity rule_group_name type
}
