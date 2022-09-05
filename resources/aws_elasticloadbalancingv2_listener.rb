# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_elasticloadbalancingv2_listener
provides :aws_elasticloadbalancingv2_listener, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ElasticLoadBalancingV2::Listener
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :alpn_policy, Array,
         callbacks: {
           "alpn_policy is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :certificates, Array,
         callbacks: {
           "certificates is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :default_actions, Array,
         required: true,
         callbacks: {
           "default_actions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :load_balancer_arn, String,
         required: true,
         callbacks: {
           "load_balancer_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :port, Integer,
         callbacks: {
           "port is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :protocol, String,
         callbacks: {
           "protocol is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :ssl_policy, String,
         callbacks: {
           "ssl_policy is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::ElasticLoadBalancingV2::Listener"
rest_api_document "/AWS::ElasticLoadBalancingV2::Listener"

rest_property_map({
  alpn_policy:       "AlpnPolicy",
  certificates:      "Certificates",
  default_actions:   "DefaultActions",
  load_balancer_arn: "LoadBalancerArn",
  port:              "Port",
  protocol:          "Protocol",
  ssl_policy:        "SslPolicy",
})

rest_post_only_properties %i{
  load_balancer_arn
}
