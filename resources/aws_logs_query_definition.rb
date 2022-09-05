# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_logs_query_definition
provides :aws_logs_query_definition, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The resource schema for AWSLogs QueryDefinition
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :log_group_names, Array,
         callbacks: {
           "log_group_names is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Optionally define specific log groups as part of your query definition
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "name must match pattern ^([^:*\/]+\/?)*[^:*\/]+$" => lambda { |v| v =~ Regexp.new("/^([^:*\/]+\/?)*[^:*\/]+$/") },
         },
         description: <<~'DESCRIPTION'
           A name for the saved query definition
         DESCRIPTION

property :query_string, String,
         required: true,
         callbacks: {
           "query_string is not a String" => lambda { |v| v.is_a? String },
           "query_string needs to be 1..10000 characters" => lambda { |v| v.length >= 1 && v.length <= 10000 },
         },
         description: <<~'DESCRIPTION'
           The query string to use for this definition
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Logs::QueryDefinition"
rest_api_document "/AWS::Logs::QueryDefinition"

rest_property_map({
  log_group_names: "LogGroupNames",
  name:            "Name",
  query_string:    "QueryString",
})

