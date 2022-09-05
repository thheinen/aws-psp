# Import API specifics
use "awscc_base"

resource_name :aws_route53resolver_resolver_query_logging_config
provides :aws_route53resolver_resolver_query_logging_config, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::Route53Resolver::ResolverQueryLoggingConfig.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :destination_arn, String,
         callbacks: {
           "destination_arn is not a String" => lambda { |v| v.is_a? String },
           "destination_arn needs to be 1..600 characters" => lambda { |v| v.length >= 1 && v.length <= 600 },
         },
         description: <<~'DESCRIPTION'
           destination arn
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "name must match pattern (?!^[0-9]+$)([a-zA-Z0-9\-_' ']+)" => lambda { |v| v =~ Regexp.new("/(?!^[0-9]+$)([a-zA-Z0-9\-_' ']+)/") },
         },
         description: <<~'DESCRIPTION'
           ResolverQueryLogConfigName
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Route53Resolver::ResolverQueryLoggingConfig"
rest_api_document "/AWS::Route53Resolver::ResolverQueryLoggingConfig"

rest_property_map({
  destination_arn: "DestinationArn",
  name:            "Name",
})

rest_post_only_properties %i{
  destination_arn name
}
