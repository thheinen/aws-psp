# Import API specifics
use "awscc_base"

resource_name :aws_route53_resolver_resolver_query_logging_config_association
provides :aws_route53_resolver_resolver_query_logging_config_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::Route53Resolver::ResolverQueryLoggingConfigAssociation.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :resolver_query_log_config_id, String,
         callbacks: {
           "resolver_query_log_config_id is not a String" => lambda { |v| v.is_a? String },
           "resolver_query_log_config_id needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
         },
         description: "ResolverQueryLogConfigId"

property :resource_id, String,
         callbacks: {
           "resource_id is not a String" => lambda { |v| v.is_a? String },
           "resource_id needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
         },
         description: "ResourceId"

# API URLs and mappings
rest_api_collection "/AWS::Route53Resolver::ResolverQueryLoggingConfigAssociation"
rest_api_document "/AWS::Route53Resolver::ResolverQueryLoggingConfigAssociation"

rest_property_map({
  resolver_query_log_config_id: "ResolverQueryLogConfigId",
  resource_id:                  "ResourceId",
})

rest_post_only_properties %i{
  resolver_query_log_config_id resource_id
}
