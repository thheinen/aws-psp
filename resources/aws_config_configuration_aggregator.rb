# Import API specifics
use "awscc_base"

resource_name :aws_config_configuration_aggregator
provides :aws_config_configuration_aggregator, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Config::ConfigurationAggregator
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :account_aggregation_sources, Array,
         callbacks: {
           "account_aggregation_sources is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :configuration_aggregator_name, String,
         callbacks: {
           "configuration_aggregator_name is not a String" => lambda { |v| v.is_a? String },
           "configuration_aggregator_name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "configuration_aggregator_name must match pattern [\w\-]+" => lambda { |v| v =~ Regexp.new("/[\w\-]+/") },
         },
         description: "The name of the aggregator."

property :organization_aggregation_source, Hash,
         callbacks: {
           "Subproperty `AllAwsRegions` is not a Boolean" => lambda { |v| v[:AllAwsRegions].is_a? Boolean },
           "Subproperty `AwsRegions` is not a Array" => lambda { |v| v[:AwsRegions].is_a? Array },
           "Subproperty `RoleArn` is not a String" => lambda { |v| v[:RoleArn].is_a? String },
           "Subproperty `RoleArn`is not a valid ARN" => lambda { |v| v[:RoleArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The tags for the configuration aggregator."

# API URLs and mappings
rest_api_collection "/AWS::Config::ConfigurationAggregator"
rest_api_document "/AWS::Config::ConfigurationAggregator"

rest_property_map({
  account_aggregation_sources:     "AccountAggregationSources",
  configuration_aggregator_name:   "ConfigurationAggregatorName",
  organization_aggregation_source: "OrganizationAggregationSource",
  tags:                            "Tags",
})

rest_post_only_properties %i{
  configuration_aggregator_name
}
