# Import API specifics
use "awscc_base"

resource_name :aws_ec2_networkinsights_access_scope
provides :aws_ec2_networkinsights_access_scope, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::EC2::NetworkInsightsAccessScope
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :exclude_paths, Array,
         callbacks: {
           "exclude_paths is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :match_paths, Array,
         callbacks: {
           "match_paths is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::EC2::NetworkInsightsAccessScope"
rest_api_document "/AWS::EC2::NetworkInsightsAccessScope"

rest_property_map({
  exclude_paths: "ExcludePaths",
  match_paths:   "MatchPaths",
  tags:          "Tags",
})

rest_post_only_properties %i{
  exclude_paths match_paths
}
