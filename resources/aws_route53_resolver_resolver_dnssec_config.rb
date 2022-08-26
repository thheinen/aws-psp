# Import API specifics
use "awscc_base"

resource_name :aws_route53_resolver_resolver_dnssec_config
provides :aws_route53_resolver_resolver_dnssec_config, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::Route53Resolver::ResolverDNSSECConfig.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :resource_id, String,
         callbacks: {
           "resource_id is not a String" => lambda { |v| v.is_a? String },
           "resource_id needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
         },
         description: "ResourceId"

# API URLs and mappings
rest_api_collection "/AWS::Route53Resolver::ResolverDNSSECConfig"
rest_api_document "/AWS::Route53Resolver::ResolverDNSSECConfig"

rest_property_map({
  resource_id: "ResourceId",
})

rest_post_only_properties %i{
  resource_id
}
