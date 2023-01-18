# Import API specifics
use "awscc_base"

resource_name :aws_route53resolver_firewall_rule_group
provides :aws_route53resolver_firewall_rule_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::Route53Resolver::FirewallRuleGroup.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :firewall_rules, Array,
         callbacks: {
           "firewall_rules is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           FirewallRules
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "name must match pattern (?!^[0-9]+$)([a-zA-Z0-9\-_' ']+)" => lambda { |v| v =~ Regexp.new("/(?!^[0-9]+$)([a-zA-Z0-9\-_' ']+)/") },
         },
         description: <<~'DESCRIPTION'
           FirewallRuleGroupName
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Tags
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Route53Resolver::FirewallRuleGroup"
rest_api_document "/AWS::Route53Resolver::FirewallRuleGroup"

rest_property_map({
  firewall_rules: "FirewallRules",
  name:           "Name",
  tags:           "Tags",
})

rest_post_only_properties %i{
  name
}
