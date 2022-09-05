# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_ecr_pull_through_cache_rule
provides :aws_ecr_pull_through_cache_rule, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::ECR::PullThroughCacheRule resource configures the upstream registry configuration details for an Amazon Elastic Container Registry (Amazon Private ECR) pull-through cache.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :ecr_repository_prefix, String,
         callbacks: {
           "ecr_repository_prefix is not a String" => lambda { |v| v.is_a? String },
           "ecr_repository_prefix needs to be 2..20 characters" => lambda { |v| v.length >= 2 && v.length <= 20 },
           "ecr_repository_prefix must match pattern ^([a-z0-9]+(?:[._-][a-z0-9]+)*)$" => lambda { |v| v =~ Regexp.new("/^([a-z0-9]+(?:[._-][a-z0-9]+)*)$/") },
         },
         description: <<~'DESCRIPTION'
           The ECRRepositoryPrefix is a custom alias for upstream registry url.
         DESCRIPTION

property :upstream_registry_url, String,
         callbacks: {
           "upstream_registry_url is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The upstreamRegistryUrl is the endpoint of upstream registry url of the public repository to be cached
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ECR::PullThroughCacheRule"
rest_api_document "/AWS::ECR::PullThroughCacheRule"

rest_property_map({
  ecr_repository_prefix: "EcrRepositoryPrefix",
  upstream_registry_url: "UpstreamRegistryUrl",
})

rest_post_only_properties %i{
  ecr_repository_prefix upstream_registry_url
}
