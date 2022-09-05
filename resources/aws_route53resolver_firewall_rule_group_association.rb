# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_route53resolver_firewall_rule_group_association
provides :aws_route53resolver_firewall_rule_group_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::Route53Resolver::FirewallRuleGroupAssociation.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :firewall_rule_group_id, String,
         required: true,
         callbacks: {
           "firewall_rule_group_id is not a String" => lambda { |v| v.is_a? String },
           "firewall_rule_group_id needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
         },
         description: <<~'DESCRIPTION'
           FirewallRuleGroupId
         DESCRIPTION

property :mutation_protection, String,
         callbacks: {
           "mutation_protection is not a String" => lambda { |v| v.is_a? String },
           "mutation_protectionis not one of `ENABLED`, `DISABLED`" => lambda { |v| %w{ENABLED DISABLED}.include? v },
         },
         description: <<~'DESCRIPTION'
           MutationProtectionStatus
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 0..64 characters" => lambda { |v| v.length >= 0 && v.length <= 64 },
           "name must match pattern (?!^[0-9]+$)([a-zA-Z0-9\-_' ']+)" => lambda { |v| v =~ Regexp.new("/(?!^[0-9]+$)([a-zA-Z0-9\-_' ']+)/") },
         },
         description: <<~'DESCRIPTION'
           FirewallRuleGroupAssociationName
         DESCRIPTION

property :priority, Integer,
         required: true,
         callbacks: {
           "priority is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           Priority
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Tags
         DESCRIPTION

property :vpc_id, String,
         required: true,
         callbacks: {
           "vpc_id is not a String" => lambda { |v| v.is_a? String },
           "vpc_id needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
         },
         description: <<~'DESCRIPTION'
           VpcId
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Route53Resolver::FirewallRuleGroupAssociation"
rest_api_document "/AWS::Route53Resolver::FirewallRuleGroupAssociation"

rest_property_map({
  firewall_rule_group_id: "FirewallRuleGroupId",
  mutation_protection:    "MutationProtection",
  name:                   "Name",
  priority:               "Priority",
  tags:                   "Tags",
  vpc_id:                 "VpcId",
})

rest_post_only_properties %i{
  firewall_rule_group_id vpc_id
}
