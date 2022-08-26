# Import API specifics
use "awscc_base"

resource_name :aws_ec2_networkinsights_access_scope_analysis
provides :aws_ec2_networkinsights_access_scope_analysis, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::EC2::NetworkInsightsAccessScopeAnalysis
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :networkinsights_access_scope_id, String,
         required: true,
         callbacks: {
           "networkinsights_access_scope_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::EC2::NetworkInsightsAccessScopeAnalysis"
rest_api_document "/AWS::EC2::NetworkInsightsAccessScopeAnalysis"

rest_property_map({
  networkinsights_access_scope_id: "NetworkInsightsAccessScopeId",
  tags:                            "Tags",
})

rest_post_only_properties %i{
  networkinsights_access_scope_id
}
