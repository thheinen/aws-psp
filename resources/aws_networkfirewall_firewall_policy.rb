# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_networkfirewall_firewall_policy
provides :aws_networkfirewall_firewall_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource type definition for AWS::NetworkFirewall::FirewallPolicy
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..512 characters" => lambda { |v| v.length >= 1 && v.length <= 512 },
           "description must match pattern ^.*$" => lambda { |v| v =~ Regexp.new("/^.*$/") },
         },
         description: ""

property :firewall_policy, Hash,
         required: true,
         callbacks: {
           "Subproperty `StatelessDefaultActions` is not a Array" => lambda { |v| v[:StatelessDefaultActions].is_a? Array },
           "Subproperty `StatelessFragmentDefaultActions` is not a Array" => lambda { |v| v[:StatelessFragmentDefaultActions].is_a? Array },
           "Subproperty `StatelessCustomActions` is not a Array" => lambda { |v| v[:StatelessCustomActions].is_a? Array },
           "Subproperty `StatelessRuleGroupReferences` is not a Array" => lambda { |v| v[:StatelessRuleGroupReferences].is_a? Array },
           "Subproperty `StatefulRuleGroupReferences` is not a Array" => lambda { |v| v[:StatefulRuleGroupReferences].is_a? Array },
           "Subproperty `StatefulDefaultActions` is not a Array" => lambda { |v| v[:StatefulDefaultActions].is_a? Array },
         },
         description: ""

property :firewall_policy_name, String,
         required: true,
         callbacks: {
           "firewall_policy_name is not a String" => lambda { |v| v.is_a? String },
           "firewall_policy_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "firewall_policy_name must match pattern ^[a-zA-Z0-9-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9-]+$/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::NetworkFirewall::FirewallPolicy"
rest_api_document "/AWS::NetworkFirewall::FirewallPolicy"

rest_property_map({
  description:          "Description",
  firewall_policy:      "FirewallPolicy",
  firewall_policy_name: "FirewallPolicyName",
  tags:                 "Tags",
})

rest_post_only_properties %i{
  firewall_policy_name
}
