# Import API specifics
use "awscc_base"

resource_name :aws_timestream_scheduled_query
provides :aws_timestream_scheduled_query, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::Timestream::ScheduledQuery resource creates a Timestream Scheduled Query.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :client_token, Hash,
         callbacks: {
           "client_token is not a String" => lambda { |v| v.is_a? String },
           "client_token needs to be 32..128 characters" => lambda { |v| v.length >= 32 && v.length <= 128 },
         },
         description: ""

property :error_report_configuration, Hash,
         required: true,
         description: ""

property :kms_key_id, Hash,
         callbacks: {
           "kms_key_id is not a String" => lambda { |v| v.is_a? String },
           "kms_key_id needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
         },
         description: ""

property :notification_configuration, Hash,
         required: true,
         description: ""

property :query_string, Hash,
         required: true,
         callbacks: {
           "query_string is not a String" => lambda { |v| v.is_a? String },
           "query_string needs to be 1..262144 characters" => lambda { |v| v.length >= 1 && v.length <= 262144 },
         },
         description: ""

property :schedule_configuration, Hash,
         required: true,
         description: ""

property :scheduled_query_execution_role_arn, Hash,
         required: true,
         callbacks: {
           "scheduled_query_execution_role_arn is not a String" => lambda { |v| v.is_a? String },
           "scheduled_query_execution_role_arn needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
         },
         description: ""

property :scheduled_query_name, Hash,
         callbacks: {
           "scheduled_query_name is not a String" => lambda { |v| v.is_a? String },
           "scheduled_query_name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "scheduled_query_name must match pattern [a-zA-Z0-9_.-]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9_.-]+/") },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :target_configuration, Hash,
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Timestream::ScheduledQuery"
rest_api_document "/AWS::Timestream::ScheduledQuery"

rest_property_map({
  client_token:                       "ClientToken",
  error_report_configuration:         "ErrorReportConfiguration",
  kms_key_id:                         "KmsKeyId",
  notification_configuration:         "NotificationConfiguration",
  query_string:                       "QueryString",
  schedule_configuration:             "ScheduleConfiguration",
  scheduled_query_execution_role_arn: "ScheduledQueryExecutionRoleArn",
  scheduled_query_name:               "ScheduledQueryName",
  tags:                               "Tags",
  target_configuration:               "TargetConfiguration",
})

rest_post_only_properties %i{
  client_token error_report_configuration kms_key_id notification_configuration query_string schedule_configuration scheduled_query_execution_role_arn scheduled_query_name target_configuration
}
