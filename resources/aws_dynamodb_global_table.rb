# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_dynamodb_global_table
provides :aws_dynamodb_global_table, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Version: None. Resource Type definition for AWS::DynamoDB::GlobalTable
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :attribute_definitions, Array,
         required: true,
         callbacks: {
           "attribute_definitions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :billing_mode, String,
         callbacks: {
           "billing_mode is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :global_secondary_indexes, Array,
         callbacks: {
           "global_secondary_indexes is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :key_schema, Array,
         required: true,
         callbacks: {
           "key_schema is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :local_secondary_indexes, Array,
         callbacks: {
           "local_secondary_indexes is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :replicas, Array,
         required: true,
         callbacks: {
           "replicas is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :sse_specification, Hash,
         callbacks: {
           "Subproperty `SSEEnabled` is not a Boolean" => lambda { |v| v[:SSEEnabled].is_a? Boolean },
           "Subproperty `SSEType` is not a String" => lambda { |v| v[:SSEType].is_a? String },
         },
         description: ""

property :stream_specification, Hash,
         callbacks: {
           "Subproperty `StreamViewType` is not a String" => lambda { |v| v[:StreamViewType].is_a? String },
         },
         description: ""

property :table_name, String,
         callbacks: {
           "table_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :time_to_live_specification, Hash,
         callbacks: {
           "Subproperty `AttributeName` is not a String" => lambda { |v| v[:AttributeName].is_a? String },
           "Subproperty `Enabled` is not a Boolean" => lambda { |v| v[:Enabled].is_a? Boolean },
         },
         description: ""

property :write_provisioned_throughput_settings, Hash,
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::DynamoDB::GlobalTable"
rest_api_document "/AWS::DynamoDB::GlobalTable"

rest_property_map({
  attribute_definitions:                 "AttributeDefinitions",
  billing_mode:                          "BillingMode",
  global_secondary_indexes:              "GlobalSecondaryIndexes",
  key_schema:                            "KeySchema",
  local_secondary_indexes:               "LocalSecondaryIndexes",
  replicas:                              "Replicas",
  sse_specification:                     "SSESpecification",
  stream_specification:                  "StreamSpecification",
  table_name:                            "TableName",
  time_to_live_specification:            "TimeToLiveSpecification",
  write_provisioned_throughput_settings: "WriteProvisionedThroughputSettings",
})

rest_post_only_properties %i{
  key_schema local_secondary_indexes table_name
}
