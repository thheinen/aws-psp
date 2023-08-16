# Import API specifics
use "awscc_base"

resource_name :aws_cloudformation_stack
provides :aws_cloudformation_stack, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::CloudFormation::Stack resource nests a stack as a resource in a top-level template.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :capabilities, Array,
         callbacks: {
           "capabilities is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
         },
         description: ""

property :disable_rollback, [TrueClass, FalseClass],
         callbacks: {
           "disable_rollback is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :enable_termination_protection, [TrueClass, FalseClass],
         callbacks: {
           "enable_termination_protection is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :notification_ar_ns, Array,
         callbacks: {
           "notification_ar_ns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :parameters, Hash,
         callbacks: {
           "parameters is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :role_arn, String,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :stack_name, String,
         required: true,
         callbacks: {
           "stack_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :stack_policy_body, Hash,
         callbacks: {
           "stack_policy_body is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :stack_policy_url, String,
         callbacks: {
           "stack_policy_url is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :stack_status_reason, String,
         callbacks: {
           "stack_status_reason is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :template_body, Hash,
         callbacks: {
           "template_body is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :template_url, String,
         callbacks: {
           "template_url is not a String" => lambda { |v| v.is_a? String },
           "template_url needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
         },
         description: ""

property :timeout_in_minutes, Integer,
         callbacks: {
           "timeout_in_minutes is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::CloudFormation::Stack"
rest_api_document "/AWS::CloudFormation::Stack"

rest_property_map({
  capabilities:                  "Capabilities",
  description:                   "Description",
  disable_rollback:              "DisableRollback",
  enable_termination_protection: "EnableTerminationProtection",
  notification_ar_ns:            "NotificationARNs",
  parameters:                    "Parameters",
  role_arn:                      "RoleARN",
  stack_name:                    "StackName",
  stack_policy_body:             "StackPolicyBody",
  stack_policy_url:              "StackPolicyURL",
  stack_status_reason:           "StackStatusReason",
  tags:                          "Tags",
  template_body:                 "TemplateBody",
  template_url:                  "TemplateURL",
  timeout_in_minutes:            "TimeoutInMinutes",
})

rest_post_only_properties %i{
  stack_name
}
