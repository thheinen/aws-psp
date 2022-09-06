# Import API specifics
use "awscc_base"

resource_name :aws_cloudtrail_trail
provides :aws_cloudtrail_trail, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Creates a trail that specifies the settings for delivery of log data to an Amazon S3 bucket. A maximum of five trails can exist in a region, irrespective of the region in which they were created.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :cloudwatch_logs_log_group_arn, String,
         callbacks: {
           "cloudwatch_logs_log_group_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies a log group name using an Amazon Resource Name (ARN), a unique identifier that represents the log group to which CloudTrail logs will be delivered. Not required unless you specify CloudWatchLogsRoleArn.
         DESCRIPTION

property :cloudwatch_logs_role_arn, String,
         callbacks: {
           "cloudwatch_logs_role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies the role for the CloudWatch Logs endpoint to assume to write to a user's log group.
         DESCRIPTION

property :enable_log_file_validation, [TrueClass, FalseClass],
         callbacks: {
           "enable_log_file_validation is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Specifies whether log file validation is enabled. The default is false.
         DESCRIPTION

property :event_selectors, Array,
         callbacks: {
           "event_selectors is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Use event selectors to further specify the management and data event settings for your trail. By default, trails created without specific event selectors will be configured to log all read and write management events, and no data events. When an event occurs in your account, CloudTrail evaluates the event selector for all trails. For each trail, if the event matches any event selector, the trail processes and logs the event. If the event doesn't match any event selector, the trail doesn't log the event. You can configure up to five event selectors for a trail.
         DESCRIPTION

property :include_global_service_events, [TrueClass, FalseClass],
         callbacks: {
           "include_global_service_events is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Specifies whether the trail is publishing events from global services such as IAM to the log files.
         DESCRIPTION

property :insight_selectors, Array,
         callbacks: {
           "insight_selectors is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Lets you enable Insights event logging by specifying the Insights selectors that you want to enable on an existing trail.
         DESCRIPTION

property :is_logging, [TrueClass, FalseClass],
         required: true,
         callbacks: {
           "is_logging is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Whether the CloudTrail is currently logging AWS API calls.
         DESCRIPTION

property :is_multi_region_trail, [TrueClass, FalseClass],
         callbacks: {
           "is_multi_region_trail is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Specifies whether the trail applies only to the current region or to all regions. The default is false. If the trail exists only in the current region and this value is set to true, shadow trails (replications of the trail) will be created in the other regions. If the trail exists in all regions and this value is set to false, the trail will remain in the region where it was created, and its shadow trails in other regions will be deleted. As a best practice, consider using trails that log events in all regions.
         DESCRIPTION

property :is_organization_trail, [TrueClass, FalseClass],
         callbacks: {
           "is_organization_trail is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Specifies whether the trail is created for all accounts in an organization in AWS Organizations, or only for the current AWS account. The default is false, and cannot be true unless the call is made on behalf of an AWS account that is the master account for an organization in AWS Organizations.
         DESCRIPTION

property :kms_key_id, String,
         callbacks: {
           "kms_key_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies the KMS key ID to use to encrypt the logs delivered by CloudTrail. The value can be an alias name prefixed by 'alias/', a fully specified ARN to an alias, a fully specified ARN to a key, or a globally unique identifier.
         DESCRIPTION

property :s3_bucket_name, String,
         required: true,
         callbacks: {
           "s3_bucket_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies the name of the Amazon S3 bucket designated for publishing log files. See Amazon S3 Bucket Naming Requirements.
         DESCRIPTION

property :s3_key_prefix, String,
         callbacks: {
           "s3_key_prefix is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies the Amazon S3 key prefix that comes after the name of the bucket you have designated for log file delivery. For more information, see Finding Your CloudTrail Log Files. The maximum length is 200 characters.
         DESCRIPTION

property :sns_topic_name, String,
         callbacks: {
           "sns_topic_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies the name of the Amazon SNS topic defined for notification of log file delivery. The maximum length is 256 characters.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :trail_name, String,
         callbacks: {
           "trail_name is not a String" => lambda { |v| v.is_a? String },
           "trail_name needs to be 3..128 characters" => lambda { |v| v.length >= 3 && v.length <= 128 },
           "trail_name must match pattern (^[a-zA-Z0-9]$)|(^[a-zA-Z0-9]([a-zA-Z0-9\._-])*[a-zA-Z0-9]$)" => lambda { |v| v =~ Regexp.new("/(^[a-zA-Z0-9]$)|(^[a-zA-Z0-9]([a-zA-Z0-9\._-])*[a-zA-Z0-9]$)/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::CloudTrail::Trail"
rest_api_document "/AWS::CloudTrail::Trail"

rest_property_map({
  cloudwatch_logs_log_group_arn: "CloudWatchLogsLogGroupArn",
  cloudwatch_logs_role_arn:      "CloudWatchLogsRoleArn",
  enable_log_file_validation:    "EnableLogFileValidation",
  event_selectors:               "EventSelectors",
  include_global_service_events: "IncludeGlobalServiceEvents",
  insight_selectors:             "InsightSelectors",
  is_logging:                    "IsLogging",
  is_multi_region_trail:         "IsMultiRegionTrail",
  is_organization_trail:         "IsOrganizationTrail",
  kms_key_id:                    "KMSKeyId",
  s3_bucket_name:                "S3BucketName",
  s3_key_prefix:                 "S3KeyPrefix",
  sns_topic_name:                "SnsTopicName",
  tags:                          "Tags",
  trail_name:                    "TrailName",
})

rest_post_only_properties %i{
  trail_name
}
