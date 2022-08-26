# Import API specifics
use "awscc_base"

resource_name :aws_dynamodb_table
provides :aws_dynamodb_table, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Version: None. Resource Type definition for AWS::DynamoDB::Table
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :attribute_definitions, Array,
         callbacks: {
           "attribute_definitions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :billing_mode, String,
         callbacks: {
           "billing_mode is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :contributor_insights_specification, Hash,
         callbacks: {
           "Subproperty `Enabled` is not a Boolean" => lambda { |v| v[:Enabled].is_a? Boolean },
         },
         description: ""

property :global_secondary_indexes, Array,
         callbacks: {
           "global_secondary_indexes is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :import_source_specification, Hash,
         callbacks: {
           "Subproperty `InputFormat` is not a String" => lambda { |v| v[:InputFormat].is_a? String },
           "Subproperty `InputCompressionType` is not a String" => lambda { |v| v[:InputCompressionType].is_a? String },
         },
         description: ""

property :key_schema, Hash,
         required: true,
         description: ""

property :kinesis_stream_specification, Hash,
         callbacks: {
           "Subproperty `StreamArn` is not a String" => lambda { |v| v[:StreamArn].is_a? String },
           "Subproperty `StreamArn`is not a valid ARN" => lambda { |v| v[:StreamArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: ""

property :local_secondary_indexes, Array,
         callbacks: {
           "local_secondary_indexes is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :point_in_time_recovery_specification, Hash,
         callbacks: {
           "Subproperty `PointInTimeRecoveryEnabled` is not a Boolean" => lambda { |v| v[:PointInTimeRecoveryEnabled].is_a? Boolean },
         },
         description: ""

property :provisioned_throughput, Hash,
         callbacks: {
           "Subproperty `ReadCapacityUnits` is not a Integer" => lambda { |v| v[:ReadCapacityUnits].is_a? Integer },
           "Subproperty `WriteCapacityUnits` is not a Integer" => lambda { |v| v[:WriteCapacityUnits].is_a? Integer },
         },
         description: ""

property :sse_specification, Hash,
         callbacks: {
           "Subproperty `KMSMasterKeyId` is not a String" => lambda { |v| v[:KMSMasterKeyId].is_a? String },
           "Subproperty `SSEEnabled` is not a Boolean" => lambda { |v| v[:SSEEnabled].is_a? Boolean },
           "Subproperty `SSEType` is not a String" => lambda { |v| v[:SSEType].is_a? String },
         },
         description: ""

property :stream_specification, Hash,
         callbacks: {
           "Subproperty `StreamViewType` is not a String" => lambda { |v| v[:StreamViewType].is_a? String },
         },
         description: ""

property :table_class, String,
         callbacks: {
           "table_class is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :table_name, String,
         callbacks: {
           "table_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :time_to_live_specification, Hash,
         callbacks: {
           "Subproperty `AttributeName` is not a String" => lambda { |v| v[:AttributeName].is_a? String },
           "Subproperty `Enabled` is not a Boolean" => lambda { |v| v[:Enabled].is_a? Boolean },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::DynamoDB::Table"
rest_api_document "/AWS::DynamoDB::Table"

rest_property_map({
  attribute_definitions:                "AttributeDefinitions",
  billing_mode:                         "BillingMode",
  contributor_insights_specification:   "ContributorInsightsSpecification",
  global_secondary_indexes:             "GlobalSecondaryIndexes",
  import_source_specification:          "ImportSourceSpecification",
  key_schema:                           "KeySchema",
  kinesis_stream_specification:         "KinesisStreamSpecification",
  local_secondary_indexes:              "LocalSecondaryIndexes",
  point_in_time_recovery_specification: "PointInTimeRecoverySpecification",
  provisioned_throughput:               "ProvisionedThroughput",
  sse_specification:                    "SSESpecification",
  stream_specification:                 "StreamSpecification",
  table_class:                          "TableClass",
  table_name:                           "TableName",
  tags:                                 "Tags",
  time_to_live_specification:           "TimeToLiveSpecification",
})

rest_post_only_properties %i{
  import_source_specification table_name
}
