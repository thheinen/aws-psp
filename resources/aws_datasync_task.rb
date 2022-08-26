# Import API specifics
use "awscc_base"

resource_name :aws_datasync_task
provides :aws_datasync_task, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::DataSync::Task.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :cloudwatch_log_group_arn, String,
         callbacks: {
           "cloudwatch_log_group_arn is not a String" => lambda { |v| v.is_a? String },
           "cloudwatch_log_group_arn must match pattern ^arn:(aws|aws-cn|aws-us-gov|aws-iso|aws-iso-b):logs:[a-z\-0-9]*:[0-9]{12}:log-group:([^:\*]*)(:\*)?$" => lambda { |v| v =~ Regexp.new("/^arn:(aws|aws-cn|aws-us-gov|aws-iso|aws-iso-b):logs:[a-z\-0-9]*:[0-9]{12}:log-group:([^:\*]*)(:\*)?$/") },
         },
         description: "The ARN of the Amazon CloudWatch log group that is used to monitor and log events in the task."

property :destination_location_arn, String,
         required: true,
         callbacks: {
           "destination_location_arn is not a String" => lambda { |v| v.is_a? String },
           "destination_location_arn must match pattern ^arn:(aws|aws-cn|aws-us-gov|aws-iso|aws-iso-b):datasync:[a-z\-0-9]+:[0-9]{12}:location/loc-[0-9a-z]{17}$" => lambda { |v| v =~ Regexp.new("/^arn:(aws|aws-cn|aws-us-gov|aws-iso|aws-iso-b):datasync:[a-z\-0-9]+:[0-9]{12}:location/loc-[0-9a-z]{17}$/") },
         },
         description: "The ARN of an AWS storage resource's location."

property :excludes, Array,
         callbacks: {
           "excludes is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :includes, Array,
         callbacks: {
           "includes is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "name must match pattern ^[a-zA-Z0-9\s+=._:@/-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9\s+=._:@/-]+$/") },
         },
         description: "The name of a task. This value is a text reference that is used to identify the task in the console."

property :options, Hash,
         callbacks: {
           "Subproperty `Atime` is not a String" => lambda { |v| v[:Atime].is_a? String },
           "Subproperty `Atime`is not one of `NONE`, `BEST_EFFORT`" => lambda { |v| %w{NONE BEST_EFFORT}.include? v[:Atime] },
           "Subproperty `BytesPerSecond` is not a Integer" => lambda { |v| v[:BytesPerSecond].is_a? Integer },
           "Subproperty `Gid` is not a String" => lambda { |v| v[:Gid].is_a? String },
           "Subproperty `Gid`is not one of `NONE`, `INT_VALUE`, `NAME`, `BOTH`" => lambda { |v| %w{NONE INT_VALUE NAME BOTH}.include? v[:Gid] },
           "Subproperty `LogLevel` is not a String" => lambda { |v| v[:LogLevel].is_a? String },
           "Subproperty `LogLevel`is not one of `OFF`, `BASIC`, `TRANSFER`" => lambda { |v| %w{OFF BASIC TRANSFER}.include? v[:LogLevel] },
           "Subproperty `Mtime` is not a String" => lambda { |v| v[:Mtime].is_a? String },
           "Subproperty `Mtime`is not one of `NONE`, `PRESERVE`" => lambda { |v| %w{NONE PRESERVE}.include? v[:Mtime] },
           "Subproperty `OverwriteMode` is not a String" => lambda { |v| v[:OverwriteMode].is_a? String },
           "Subproperty `OverwriteMode`is not one of `ALWAYS`, `NEVER`" => lambda { |v| %w{ALWAYS NEVER}.include? v[:OverwriteMode] },
           "Subproperty `PosixPermissions` is not a String" => lambda { |v| v[:PosixPermissions].is_a? String },
           "Subproperty `PosixPermissions`is not one of `NONE`, `PRESERVE`" => lambda { |v| %w{NONE PRESERVE}.include? v[:PosixPermissions] },
           "Subproperty `PreserveDeletedFiles` is not a String" => lambda { |v| v[:PreserveDeletedFiles].is_a? String },
           "Subproperty `PreserveDeletedFiles`is not one of `PRESERVE`, `REMOVE`" => lambda { |v| %w{PRESERVE REMOVE}.include? v[:PreserveDeletedFiles] },
           "Subproperty `PreserveDevices` is not a String" => lambda { |v| v[:PreserveDevices].is_a? String },
           "Subproperty `PreserveDevices`is not one of `NONE`, `PRESERVE`" => lambda { |v| %w{NONE PRESERVE}.include? v[:PreserveDevices] },
           "Subproperty `SecurityDescriptorCopyFlags` is not a String" => lambda { |v| v[:SecurityDescriptorCopyFlags].is_a? String },
           "Subproperty `SecurityDescriptorCopyFlags`is not one of `NONE`, `OWNER_DACL`, `OWNER_DACL_SACL`" => lambda { |v| %w{NONE OWNER_DACL OWNER_DACL_SACL}.include? v[:SecurityDescriptorCopyFlags] },
           "Subproperty `TaskQueueing` is not a String" => lambda { |v| v[:TaskQueueing].is_a? String },
           "Subproperty `TaskQueueing`is not one of `ENABLED`, `DISABLED`" => lambda { |v| %w{ENABLED DISABLED}.include? v[:TaskQueueing] },
           "Subproperty `TransferMode` is not a String" => lambda { |v| v[:TransferMode].is_a? String },
           "Subproperty `TransferMode`is not one of `CHANGED`, `ALL`" => lambda { |v| %w{CHANGED ALL}.include? v[:TransferMode] },
           "Subproperty `Uid` is not a String" => lambda { |v| v[:Uid].is_a? String },
           "Subproperty `Uid`is not one of `NONE`, `INT_VALUE`, `NAME`, `BOTH`" => lambda { |v| %w{NONE INT_VALUE NAME BOTH}.include? v[:Uid] },
           "Subproperty `VerifyMode` is not a String" => lambda { |v| v[:VerifyMode].is_a? String },
           "Subproperty `VerifyMode`is not one of `POINT_IN_TIME_CONSISTENT`, `ONLY_FILES_TRANSFERRED`, `NONE`" => lambda { |v| %w{POINT_IN_TIME_CONSISTENT ONLY_FILES_TRANSFERRED NONE}.include? v[:VerifyMode] },
           "Subproperty `ObjectTags` is not a String" => lambda { |v| v[:ObjectTags].is_a? String },
           "Subproperty `ObjectTags`is not one of `PRESERVE`, `NONE`" => lambda { |v| %w{PRESERVE NONE}.include? v[:ObjectTags] },
         },
         description: ""

property :schedule, Hash,
         callbacks: {
           "Subproperty `ScheduleExpression` is not a String" => lambda { |v| v[:ScheduleExpression].is_a? String },
           "Subproperty `ScheduleExpression` must match pattern ^[a-zA-Z0-9\ \_\*\?\,\|\^\-\/\#\s\(\)\+]*$" => lambda { |v| v[:ScheduleExpression] =~ Regexp.new("/^[a-zA-Z0-9\ \_\*\?\,\|\^\-\/\#\s\(\)\+]*$/") },
         },
         description: ""

property :source_location_arn, String,
         required: true,
         callbacks: {
           "source_location_arn is not a String" => lambda { |v| v.is_a? String },
           "source_location_arn must match pattern ^arn:(aws|aws-cn|aws-us-gov|aws-iso|aws-iso-b):datasync:[a-z\-0-9]+:[0-9]{12}:location/loc-[0-9a-z]{17}$" => lambda { |v| v =~ Regexp.new("/^arn:(aws|aws-cn|aws-us-gov|aws-iso|aws-iso-b):datasync:[a-z\-0-9]+:[0-9]{12}:location/loc-[0-9a-z]{17}$/") },
         },
         description: "The ARN of the source location for the task."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "An array of key-value pairs to apply to this resource."

# API URLs and mappings
rest_api_collection "/AWS::DataSync::Task"
rest_api_document "/AWS::DataSync::Task"

rest_property_map({
  cloudwatch_log_group_arn: "CloudWatchLogGroupArn",
  destination_location_arn: "DestinationLocationArn",
  excludes:                 "Excludes",
  includes:                 "Includes",
  name:                     "Name",
  options:                  "Options",
  schedule:                 "Schedule",
  source_location_arn:      "SourceLocationArn",
  tags:                     "Tags",
})

rest_post_only_properties %i{
  destination_location_arn source_location_arn
}
