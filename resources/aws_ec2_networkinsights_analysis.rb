# Import API specifics
use "awscc_base"

resource_name :aws_ec2_networkinsights_analysis
provides :aws_ec2_networkinsights_analysis, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::EC2::NetworkInsightsAnalysis
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :additional_accounts, Array,
         callbacks: {
           "additional_accounts is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :filter_in_arns, Array,
         callbacks: {
           "filter_in_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :networkinsights_path_id, String,
         required: true,
         callbacks: {
           "networkinsights_path_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::EC2::NetworkInsightsAnalysis"
rest_api_document "/AWS::EC2::NetworkInsightsAnalysis"

rest_property_map({
  additional_accounts:     "AdditionalAccounts",
  filter_in_arns:          "FilterInArns",
  networkinsights_path_id: "NetworkInsightsPathId",
  tags:                    "Tags",
})

rest_post_only_properties %i{
  filter_in_arns networkinsights_path_id
}
