# Import API specifics
use "awscc_base"

resource_name :aws_sagemaker_monitoring_schedule
provides :aws_sagemaker_monitoring_schedule, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SageMaker::MonitoringSchedule
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :endpoint_name, Hash,
         callbacks: {
           "endpoint_name is not a String" => lambda { |v| v.is_a? String },
           "endpoint_name must match pattern ^[a-zA-Z0-9](-*[a-zA-Z0-9])*" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9](-*[a-zA-Z0-9])*/") },
         },
         description: ""

property :failure_reason, String,
         callbacks: {
           "failure_reason is not a String" => lambda { |v| v.is_a? String },
           "failure_reason needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
         },
         description: "Contains the reason a monitoring job failed, if it failed."

property :last_monitoring_execution_summary, Hash,
         callbacks: {
           "Subproperty `CreationTime` is not a String" => lambda { |v| v[:CreationTime].is_a? String },
           "Subproperty `FailureReason` is not a String" => lambda { |v| v[:FailureReason].is_a? String },
           "Subproperty `LastModifiedTime` is not a String" => lambda { |v| v[:LastModifiedTime].is_a? String },
           "Subproperty `MonitoringExecutionStatus` is not a String" => lambda { |v| v[:MonitoringExecutionStatus].is_a? String },
           "Subproperty `MonitoringExecutionStatus`is not one of `Pending`, `Completed`, `CompletedWithViolations`, `InProgress`, `Failed`, `Stopping`, `Stopped`" => lambda { |v| %w{Pending Completed CompletedWithViolations InProgress Failed Stopping Stopped}.include? v[:MonitoringExecutionStatus] },
           "Subproperty `ProcessingJobArn` is not a String" => lambda { |v| v[:ProcessingJobArn].is_a? String },
           "Subproperty `ProcessingJobArn` must match pattern aws[a-z\-]*:sagemaker:[a-z0-9\-]*:[0-9]{12}:processing-job/.*" => lambda { |v| v[:ProcessingJobArn] =~ Regexp.new("/aws[a-z\-]*:sagemaker:[a-z0-9\-]*:[0-9]{12}:processing-job/.*/") },
           "Subproperty `ProcessingJobArn`is not a valid ARN" => lambda { |v| v[:ProcessingJobArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `ScheduledTime` is not a String" => lambda { |v| v[:ScheduledTime].is_a? String },
         },
         description: "Describes metadata on the last execution to run, if there was one."

property :monitoring_schedule_config, Hash,
         required: true,
         callbacks: {
           "Subproperty `MonitoringJobDefinitionName` is not a String" => lambda { |v| v[:MonitoringJobDefinitionName].is_a? String },
           "Subproperty `MonitoringJobDefinitionName` needs to be 1..63 characters" => lambda { |v| v[:MonitoringJobDefinitionName].length >= 1 && v[:MonitoringJobDefinitionName].length <= 63 },
           "Subproperty `MonitoringJobDefinitionName` must match pattern ^[a-zA-Z0-9](-*[a-zA-Z0-9])*$" => lambda { |v| v[:MonitoringJobDefinitionName] =~ Regexp.new("/^[a-zA-Z0-9](-*[a-zA-Z0-9])*$/") },
         },
         description: ""

property :monitoring_schedule_name, Hash,
         required: true,
         callbacks: {
           "monitoring_schedule_name is not a String" => lambda { |v| v.is_a? String },
           "monitoring_schedule_name must match pattern ^[a-zA-Z0-9](-*[a-zA-Z0-9])*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9](-*[a-zA-Z0-9])*$/") },
         },
         description: ""

property :monitoring_schedule_status, String,
         callbacks: {
           "monitoring_schedule_status is not a String" => lambda { |v| v.is_a? String },
           "monitoring_schedule_statusis not one of `Pending`, `Failed`, `Scheduled`, `Stopped`" => lambda { |v| %w{Pending Failed Scheduled Stopped}.include? v },
         },
         description: "The status of a schedule job."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "An array of key-value pairs to apply to this resource."

# API URLs and mappings
rest_api_collection "/AWS::SageMaker::MonitoringSchedule"
rest_api_document "/AWS::SageMaker::MonitoringSchedule"

rest_property_map({
  endpoint_name:                     "EndpointName",
  failure_reason:                    "FailureReason",
  last_monitoring_execution_summary: "LastMonitoringExecutionSummary",
  monitoring_schedule_config:        "MonitoringScheduleConfig",
  monitoring_schedule_name:          "MonitoringScheduleName",
  monitoring_schedule_status:        "MonitoringScheduleStatus",
  tags:                              "Tags",
})

rest_post_only_properties %i{
  monitoring_schedule_name
}
