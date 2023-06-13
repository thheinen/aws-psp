# Import API specifics
use "awscc_base"

resource_name :aws_clean_rooms_configured_table
provides :aws_clean_rooms_configured_table, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Represents a table that can be associated with collaborations
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :allowed_columns, Array,
         required: true,
         callbacks: {
           "allowed_columns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :analysis_method, Hash,
         required: true,
         callbacks: {
           "analysis_method is not a String" => lambda { |v| v.is_a? String },
           "analysis_methodis not one of `DIRECT_QUERY`" => lambda { |v| %w{DIRECT_QUERY}.include? v },
         },
         description: ""

property :analysis_rules, Array,
         callbacks: {
           "analysis_rules is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description must match pattern ^[\u0020-\uD7FF\uE000-\uFFFD\uD800\uDBFF-\uDC00\uDFFF\t\r\n]*$" => lambda { |v| v =~ Regexp.new("/^[\u0020-\uD7FF\uE000-\uFFFD\uD800\uDBFF-\uDC00\uDFFF\t\r\n]*$/") },
         },
         description: ""

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "name must match pattern ^(?!\s*$)[\u0020-\uD7FF\uE000-\uFFFD\uD800\uDBFF-\uDC00\uDFFF\t]*$" => lambda { |v| v =~ Regexp.new("/^(?!\s*$)[\u0020-\uD7FF\uE000-\uFFFD\uD800\uDBFF-\uDC00\uDFFF\t]*$/") },
         },
         description: ""

property :table_reference, Hash,
         required: true,
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An arbitrary set of tags (key-value pairs) for this cleanrooms collaboration.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::CleanRooms::ConfiguredTable"
rest_api_document "/AWS::CleanRooms::ConfiguredTable"

rest_property_map({
  allowed_columns: "AllowedColumns",
  analysis_method: "AnalysisMethod",
  analysis_rules:  "AnalysisRules",
  description:     "Description",
  name:            "Name",
  table_reference: "TableReference",
  tags:            "Tags",
})

rest_post_only_properties %i{
  allowed_columns analysis_method table_reference
}
