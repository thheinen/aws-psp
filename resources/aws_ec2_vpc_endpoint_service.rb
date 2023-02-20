# Import API specifics
use "awscc_base"

resource_name :aws_ec2_vpc_endpoint_service
provides :aws_ec2_vpc_endpoint_service, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::VPCEndpointService
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :acceptance_required, [TrueClass, FalseClass],
         callbacks: {
           "acceptance_required is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :contributor_insights_enabled, [TrueClass, FalseClass],
         callbacks: {
           "contributor_insights_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :gateway_load_balancer_arns, Array,
         callbacks: {
           "gateway_load_balancer_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :network_load_balancer_arns, Array,
         callbacks: {
           "network_load_balancer_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :payer_responsibility, String,
         callbacks: {
           "payer_responsibility is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::EC2::VPCEndpointService"
rest_api_document "/AWS::EC2::VPCEndpointService"

rest_property_map({
  acceptance_required:          "AcceptanceRequired",
  contributor_insights_enabled: "ContributorInsightsEnabled",
  gateway_load_balancer_arns:   "GatewayLoadBalancerArns",
  network_load_balancer_arns:   "NetworkLoadBalancerArns",
  payer_responsibility:         "PayerResponsibility",
})

