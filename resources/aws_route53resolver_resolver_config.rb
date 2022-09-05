# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_route53resolver_resolver_config
provides :aws_route53resolver_resolver_config, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::Route53Resolver::ResolverConfig.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :autodefined_reverse_flag, String,
         required: true,
         callbacks: {
           "autodefined_reverse_flag is not a String" => lambda { |v| v.is_a? String },
           "autodefined_reverse_flagis not one of `DISABLE`" => lambda { |v| %w{DISABLE}.include? v },
         },
         description: <<~'DESCRIPTION'
           Represents the desired status of AutodefinedReverse. The only supported value on creation is DISABLE. Deletion of this resource will return AutodefinedReverse to its default value (ENABLED).
         DESCRIPTION

property :resource_id, String,
         required: true,
         callbacks: {
           "resource_id is not a String" => lambda { |v| v.is_a? String },
           "resource_id needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
         },
         description: <<~'DESCRIPTION'
           ResourceId
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Route53Resolver::ResolverConfig"
rest_api_document "/AWS::Route53Resolver::ResolverConfig"

rest_property_map({
  autodefined_reverse_flag: "AutodefinedReverseFlag",
  resource_id:              "ResourceId",
})

rest_post_only_properties %i{
  autodefined_reverse_flag resource_id
}
