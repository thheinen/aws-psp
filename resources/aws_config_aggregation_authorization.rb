# Import API specifics
use "awscc_base"

resource_name :aws_config_aggregation_authorization
provides :aws_config_aggregation_authorization, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Config::AggregationAuthorization
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :authorized_account_id, String,
         required: true,
         callbacks: {
           "authorized_account_id is not a String" => lambda { |v| v.is_a? String },
           "authorized_account_id must match pattern ^\d{12}$" => lambda { |v| v =~ Regexp.new("/^\d{12}$/") },
         },
         description: "The 12-digit account ID of the account authorized to aggregate data."

property :authorized_aws_region, String,
         required: true,
         callbacks: {
           "authorized_aws_region is not a String" => lambda { |v| v.is_a? String },
           "authorized_aws_region needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
         },
         description: "The region authorized to collect aggregated data."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The tags for the AggregationAuthorization."

# API URLs and mappings
rest_api_collection "/AWS::Config::AggregationAuthorization"
rest_api_document "/AWS::Config::AggregationAuthorization"

rest_property_map({
  authorized_account_id: "AuthorizedAccountId",
  authorized_aws_region: "AuthorizedAwsRegion",
  tags:                  "Tags",
})

rest_post_only_properties %i{
  authorized_account_id authorized_aws_region
}
