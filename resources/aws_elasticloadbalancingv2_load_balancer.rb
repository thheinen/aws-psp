# Import API specifics
use "awscc_base"

resource_name :aws_elasticloadbalancingv2_load_balancer
provides :aws_elasticloadbalancingv2_load_balancer, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ElasticLoadBalancingV2::LoadBalancer
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :ip_address_type, String,
         callbacks: {
           "ip_address_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 (for IPv4 addresses) and dualstack (for IPv4 and IPv6 addresses).
         DESCRIPTION

property :load_balancer_attributes, Array,
         callbacks: {
           "load_balancer_attributes is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The load balancer attributes.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the load balancer.
         DESCRIPTION

property :scheme, String,
         callbacks: {
           "scheme is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The nodes of an Internet-facing load balancer have public IP addresses. The DNS name of an Internet-facing load balancer is publicly resolvable to the public IP addresses of the nodes. Therefore, Internet-facing load balancers can route requests from clients over the internet. The nodes of an internal load balancer have only private IP addresses. The DNS name of an internal load balancer is publicly resolvable to the private IP addresses of the nodes. Therefore, internal load balancers can route requests only from clients with access to the VPC for the load balancer. The default is an Internet-facing load balancer.
         DESCRIPTION

property :security_groups, Array,
         callbacks: {
           "security_groups is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The IDs of the security groups for the load balancer.
         DESCRIPTION

property :subnet_mappings, Array,
         callbacks: {
           "subnet_mappings is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The IDs of the public subnets. You can specify only one subnet per Availability Zone. You must specify either subnets or subnet mappings, but not both.
         DESCRIPTION

property :subnets, Array,
         callbacks: {
           "subnets is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The IDs of the public subnets. You can specify only one subnet per Availability Zone. You must specify either subnets or subnet mappings, but not both. To specify an Elastic IP address, specify subnet mappings instead of subnets.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags to assign to the load balancer.
         DESCRIPTION

property :type, String,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The type of load balancer. The default is application.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ElasticLoadBalancingV2::LoadBalancer"
rest_api_document "/AWS::ElasticLoadBalancingV2::LoadBalancer"

rest_property_map({
  ip_address_type:          "IpAddressType",
  load_balancer_attributes: "LoadBalancerAttributes",
  name:                     "Name",
  scheme:                   "Scheme",
  security_groups:          "SecurityGroups",
  subnet_mappings:          "SubnetMappings",
  subnets:                  "Subnets",
  tags:                     "Tags",
  type:                     "Type",
})

rest_post_only_properties %i{
  name scheme type
}
