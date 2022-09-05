# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_elasticloadbalancingv2_listener_rule
provides :aws_elasticloadbalancingv2_listener_rule, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ElasticLoadBalancingV2::ListenerRule
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :actions, Array,
         required: true,
         callbacks: {
           "actions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :conditions, Array,
         required: true,
         callbacks: {
           "conditions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :listener_arn, String,
         required: true,
         callbacks: {
           "listener_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :priority, Integer,
         required: true,
         callbacks: {
           "priority is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::ElasticLoadBalancingV2::ListenerRule"
rest_api_document "/AWS::ElasticLoadBalancingV2::ListenerRule"

rest_property_map({
  actions:      "Actions",
  conditions:   "Conditions",
  listener_arn: "ListenerArn",
  priority:     "Priority",
})

rest_post_only_properties %i{
  listener_arn
}
