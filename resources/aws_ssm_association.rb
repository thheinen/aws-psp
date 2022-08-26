# Import API specifics
use "awscc_base"

resource_name :aws_ssm_association
provides :aws_ssm_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::SSM::Association resource associates an SSM document in AWS Systems Manager with EC2 instances that contain a configuration agent to process the document.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :apply_only_at_cron_interval, [TrueClass, FalseClass],
         callbacks: {
           "apply_only_at_cron_interval is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :association_name, String,
         callbacks: {
           "association_name is not a String" => lambda { |v| v.is_a? String },
           "association_name must match pattern ^[a-zA-Z0-9_\-.]{3,128}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_\-.]{3,128}$/") },
         },
         description: "The name of the association."

property :automation_target_parameter_name, String,
         callbacks: {
           "automation_target_parameter_name is not a String" => lambda { |v| v.is_a? String },
           "automation_target_parameter_name needs to be 1..50 characters" => lambda { |v| v.length >= 1 && v.length <= 50 },
         },
         description: ""

property :calendar_names, Array,
         callbacks: {
           "calendar_names is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :compliance_severity, String,
         callbacks: {
           "compliance_severity is not a String" => lambda { |v| v.is_a? String },
           "compliance_severityis not one of `CRITICAL`, `HIGH`, `MEDIUM`, `LOW`, `UNSPECIFIED`" => lambda { |v| %w{CRITICAL HIGH MEDIUM LOW UNSPECIFIED}.include? v },
         },
         description: ""

property :document_version, String,
         callbacks: {
           "document_version is not a String" => lambda { |v| v.is_a? String },
           "document_version must match pattern ([$]LATEST|[$]DEFAULT|^[1-9][0-9]*$)" => lambda { |v| v =~ Regexp.new("/([$]LATEST|[$]DEFAULT|^[1-9][0-9]*$)/") },
         },
         description: "The version of the SSM document to associate with the target."

property :instance_id, String,
         callbacks: {
           "instance_id is not a String" => lambda { |v| v.is_a? String },
           "instance_id must match pattern (^i-(\w{8}|\w{17})$)|(^mi-\w{17}$)" => lambda { |v| v =~ Regexp.new("/(^i-(\w{8}|\w{17})$)|(^mi-\w{17}$)/") },
         },
         description: "The ID of the instance that the SSM document is associated with."

property :max_concurrency, String,
         callbacks: {
           "max_concurrency is not a String" => lambda { |v| v.is_a? String },
           "max_concurrency must match pattern ^([1-9][0-9]{0,6}|[1-9][0-9]%|[1-9]%|100%)$" => lambda { |v| v =~ Regexp.new("/^([1-9][0-9]{0,6}|[1-9][0-9]%|[1-9]%|100%)$/") },
         },
         description: ""

property :max_errors, String,
         callbacks: {
           "max_errors is not a String" => lambda { |v| v.is_a? String },
           "max_errors must match pattern ^([1-9][0-9]{0,6}|[0]|[1-9][0-9]%|[0-9]%|100%)$" => lambda { |v| v =~ Regexp.new("/^([1-9][0-9]{0,6}|[0]|[1-9][0-9]%|[0-9]%|100%)$/") },
         },
         description: ""

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name must match pattern ^[a-zA-Z0-9_\-.:/]{3,200}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_\-.:/]{3,200}$/") },
         },
         description: "The name of the SSM document."

property :output_location, Hash,
         description: ""

property :parameters, Hash,
         callbacks: {
           "parameters is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: "Parameter values that the SSM document uses at runtime."

property :schedule_expression, String,
         callbacks: {
           "schedule_expression is not a String" => lambda { |v| v.is_a? String },
           "schedule_expression needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
         },
         description: "A Cron or Rate expression that specifies when the association is applied to the target."

property :schedule_offset, Integer,
         callbacks: {
           "schedule_offset is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :sync_compliance, String,
         callbacks: {
           "sync_compliance is not a String" => lambda { |v| v.is_a? String },
           "sync_complianceis not one of `AUTO`, `MANUAL`" => lambda { |v| %w{AUTO MANUAL}.include? v },
         },
         description: ""

property :targets, Array,
         callbacks: {
           "targets is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The targets that the SSM document sends commands to."

property :wait_for_success_timeout_seconds, Integer,
         callbacks: {
           "wait_for_success_timeout_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::SSM::Association"
rest_api_document "/AWS::SSM::Association"

rest_property_map({
  apply_only_at_cron_interval:      "ApplyOnlyAtCronInterval",
  association_name:                 "AssociationName",
  automation_target_parameter_name: "AutomationTargetParameterName",
  calendar_names:                   "CalendarNames",
  compliance_severity:              "ComplianceSeverity",
  document_version:                 "DocumentVersion",
  instance_id:                      "InstanceId",
  max_concurrency:                  "MaxConcurrency",
  max_errors:                       "MaxErrors",
  name:                             "Name",
  output_location:                  "OutputLocation",
  parameters:                       "Parameters",
  schedule_expression:              "ScheduleExpression",
  schedule_offset:                  "ScheduleOffset",
  sync_compliance:                  "SyncCompliance",
  targets:                          "Targets",
  wait_for_success_timeout_seconds: "WaitForSuccessTimeoutSeconds",
})

