# Import API specifics
use "awscc_base"

resource_name :aws_athena_named_query
provides :aws_athena_named_query, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::Athena::NamedQuery
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :database, String,
         required: true,
         callbacks: {
           "database is not a String" => lambda { |v| v.is_a? String },
           "database needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: "The database to which the query belongs."

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
         },
         description: "The query description."

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
         },
         description: "The query name."

property :query_string, String,
         required: true,
         callbacks: {
           "query_string is not a String" => lambda { |v| v.is_a? String },
           "query_string needs to be 1..262144 characters" => lambda { |v| v.length >= 1 && v.length <= 262144 },
         },
         description: "The contents of the query with all query statements."

property :work_group, String,
         callbacks: {
           "work_group is not a String" => lambda { |v| v.is_a? String },
           "work_group needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
         },
         description: "The name of the workgroup that contains the named query."

# API URLs and mappings
rest_api_collection "/AWS::Athena::NamedQuery"
rest_api_document "/AWS::Athena::NamedQuery"

rest_property_map({
  database:     "Database",
  description:  "Description",
  name:         "Name",
  query_string: "QueryString",
  work_group:   "WorkGroup",
})

rest_post_only_properties %i{
  database description name query_string work_group
}
