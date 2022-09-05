# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_route53resolver_resolver_rule
provides :aws_route53resolver_resolver_rule, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Route53Resolver::ResolverRule
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :domain_name, String,
         required: true,
         callbacks: {
           "domain_name is not a String" => lambda { |v| v.is_a? String },
           "domain_name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
         },
         description: <<~'DESCRIPTION'
           DNS queries for this domain name are forwarded to the IP addresses that are specified in TargetIps
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 0..64 characters" => lambda { |v| v.length >= 0 && v.length <= 64 },
         },
         description: <<~'DESCRIPTION'
           The name for the Resolver rule
         DESCRIPTION

property :resolver_endpoint_id, String,
         callbacks: {
           "resolver_endpoint_id is not a String" => lambda { |v| v.is_a? String },
           "resolver_endpoint_id needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
         },
         description: <<~'DESCRIPTION'
           The ID of the endpoint that the rule is associated with.
         DESCRIPTION

property :rule_type, String,
         required: true,
         callbacks: {
           "rule_type is not a String" => lambda { |v| v.is_a? String },
           "rule_typeis not one of `FORWARD`, `SYSTEM`, `RECURSIVE`" => lambda { |v| %w{FORWARD SYSTEM RECURSIVE}.include? v },
         },
         description: <<~'DESCRIPTION'
           When you want to forward DNS queries for specified domain name to resolvers on your network, specify FORWARD. When you have a forwarding rule to forward DNS queries for a domain to your network and you want Resolver to process queries for a subdomain of that domain, specify SYSTEM.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

property :target_ips, Array,
         callbacks: {
           "target_ips is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array that contains the IP addresses and ports that an outbound endpoint forwards DNS queries to. Typically, these are the IP addresses of DNS resolvers on your network. Specify IPv4 addresses. IPv6 is not supported.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Route53Resolver::ResolverRule"
rest_api_document "/AWS::Route53Resolver::ResolverRule"

rest_property_map({
  domain_name:          "DomainName",
  name:                 "Name",
  resolver_endpoint_id: "ResolverEndpointId",
  rule_type:            "RuleType",
  tags:                 "Tags",
  target_ips:           "TargetIps",
})

rest_post_only_properties %i{
  domain_name rule_type
}
