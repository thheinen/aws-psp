# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_logs_log_group
provides :aws_logs_log_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::Logs::LogGroup
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :kms_key_id, String,
         callbacks: {
           "kms_key_id is not a String" => lambda { |v| v.is_a? String },
           "kms_key_id must match pattern ^arn:[a-z0-9-]+:kms:[a-z0-9-]+:\d{12}:(key|alias)/.+\Z" => lambda { |v| v =~ Regexp.new("/^arn:[a-z0-9-]+:kms:[a-z0-9-]+:\d{12}:(key|alias)/.+\Z/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the CMK to use when encrypting log data.
         DESCRIPTION

property :log_group_name, String,
         callbacks: {
           "log_group_name is not a String" => lambda { |v| v.is_a? String },
           "log_group_name needs to be 1..512 characters" => lambda { |v| v.length >= 1 && v.length <= 512 },
           "log_group_name must match pattern ^[.\-_/#A-Za-z0-9]{1,512}\Z" => lambda { |v| v =~ Regexp.new("/^[.\-_/#A-Za-z0-9]{1,512}\Z/") },
         },
         description: <<~'DESCRIPTION'
           The name of the log group. If you don't specify a name, AWS CloudFormation generates a unique ID for the log group.
         DESCRIPTION

property :retention_in_days, Integer,
         callbacks: {
           "retention_in_days is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of days to retain the log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Logs::LogGroup"
rest_api_document "/AWS::Logs::LogGroup"

rest_property_map({
  kms_key_id:        "KmsKeyId",
  log_group_name:    "LogGroupName",
  retention_in_days: "RetentionInDays",
  tags:              "Tags",
})

rest_post_only_properties %i{
  log_group_name
}
