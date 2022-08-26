# Import API specifics
use "awscc_base"

resource_name :aws_athena_prepared_statement
provides :aws_athena_prepared_statement, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::Athena::PreparedStatement
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
         },
         description: "The description of the prepared statement."

property :query_statement, String,
         required: true,
         callbacks: {
           "query_statement is not a String" => lambda { |v| v.is_a? String },
           "query_statement needs to be 1..262144 characters" => lambda { |v| v.length >= 1 && v.length <= 262144 },
         },
         description: "The query string for the prepared statement."

property :statement_name, String,
         required: true,
         callbacks: {
           "statement_name is not a String" => lambda { |v| v.is_a? String },
           "statement_name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
         },
         description: "The name of the prepared statement."

property :work_group, String,
         required: true,
         callbacks: {
           "work_group is not a String" => lambda { |v| v.is_a? String },
           "work_group needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
         },
         description: "The name of the workgroup to which the prepared statement belongs."

# API URLs and mappings
rest_api_collection "/AWS::Athena::PreparedStatement"
rest_api_document "/AWS::Athena::PreparedStatement"

rest_property_map({
  description:     "Description",
  query_statement: "QueryStatement",
  statement_name:  "StatementName",
  work_group:      "WorkGroup",
})

rest_post_only_properties %i{
  statement_name work_group
}
