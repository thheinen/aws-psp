# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_logs_log_stream
provides :aws_logs_log_stream, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Logs::LogStream
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :log_group_name, String,
         required: true,
         callbacks: {
           "log_group_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the log group where the log stream is created.
         DESCRIPTION

property :log_stream_name, String,
         callbacks: {
           "log_stream_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the log stream. The name must be unique wihtin the log group.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Logs::LogStream"
rest_api_document "/AWS::Logs::LogStream"

rest_property_map({
  log_group_name:  "LogGroupName",
  log_stream_name: "LogStreamName",
})

rest_post_only_properties %i{
  log_group_name log_stream_name
}
