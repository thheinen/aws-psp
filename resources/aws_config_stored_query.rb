# Import API specifics
use "awscc_base"

resource_name :aws_config_stored_query
provides :aws_config_stored_query, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Config::StoredQuery
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :query_description, String,
         callbacks: {
           "query_description is not a String" => lambda { |v| v.is_a? String },
           "query_description needs to be 0..256 characters" => lambda { |v| v.length >= 0 && v.length <= 256 },
           "query_description must match pattern [\s\S]*" => lambda { |v| v =~ Regexp.new("/[\s\S]*/") },
         },
         description: ""

property :query_expression, String,
         required: true,
         callbacks: {
           "query_expression is not a String" => lambda { |v| v.is_a? String },
           "query_expression needs to be 1..4096 characters" => lambda { |v| v.length >= 1 && v.length <= 4096 },
           "query_expression must match pattern [\s\S]*" => lambda { |v| v =~ Regexp.new("/[\s\S]*/") },
         },
         description: ""

property :query_name, String,
         required: true,
         callbacks: {
           "query_name is not a String" => lambda { |v| v.is_a? String },
           "query_name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "query_name must match pattern ^[a-zA-Z0-9-_]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9-_]+$/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The tags for the stored query."

# API URLs and mappings
rest_api_collection "/AWS::Config::StoredQuery"
rest_api_document "/AWS::Config::StoredQuery"

rest_property_map({
  query_description: "QueryDescription",
  query_expression:  "QueryExpression",
  query_name:        "QueryName",
  tags:              "Tags",
})

rest_post_only_properties %i{
  query_name
}
