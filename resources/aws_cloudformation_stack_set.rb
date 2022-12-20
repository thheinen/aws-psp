# Import API specifics
use "awscc_base"

resource_name :aws_cloudformation_stack_set
provides :aws_cloudformation_stack_set, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  StackSet as a resource provides one-click experience for provisioning a StackSet and StackInstances
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :administration_role_arn, String,
         callbacks: {
           "administration_role_arn is not a String" => lambda { |v| v.is_a? String },
           "administration_role_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Number (ARN) of the IAM role to use to create this stack set. Specify an IAM role only if you are using customized administrator roles to control which users or groups can manage specific stack sets within the same administrator account.
         DESCRIPTION

property :auto_deployment, Hash,
         callbacks: {
           "Subproperty `Enabled` is not a Boolean" => lambda { |v| v[:Enabled].is_a? Boolean },
           "Subproperty `RetainStacksOnAccountRemoval` is not a Boolean" => lambda { |v| v[:RetainStacksOnAccountRemoval].is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Describes whether StackSets automatically deploys to AWS Organizations accounts that are added to the target organization or organizational unit (OU). Specify only if PermissionModel is SERVICE_MANAGED.
         DESCRIPTION

property :call_as, String,
         callbacks: {
           "call_as is not a String" => lambda { |v| v.is_a? String },
           "call_asis not one of `SELF`, `DELEGATED_ADMIN`" => lambda { |v| %w{SELF DELEGATED_ADMIN}.include? v },
         },
         description: <<~'DESCRIPTION'
           Specifies the AWS account that you are acting from. By default, SELF is specified. For self-managed permissions, specify SELF; for service-managed permissions, if you are signed in to the organization's management account, specify SELF. If you are signed in to a delegated administrator account, specify DELEGATED_ADMIN.
         DESCRIPTION

property :capabilities, Array,
         callbacks: {
           "capabilities is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           In some cases, you must explicitly acknowledge that your stack set template contains certain capabilities in order for AWS CloudFormation to create the stack set and related stack instances.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
         },
         description: <<~'DESCRIPTION'
           A description of the stack set. You can use the description to identify the stack set's purpose or other important information.
         DESCRIPTION

property :execution_role_name, String,
         callbacks: {
           "execution_role_name is not a String" => lambda { |v| v.is_a? String },
           "execution_role_name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
         },
         description: <<~'DESCRIPTION'
           The name of the IAM execution role to use to create the stack set. If you do not specify an execution role, AWS CloudFormation uses the AWSCloudFormationStackSetExecutionRole role for the stack set operation.
         DESCRIPTION

property :managed_execution, Hash,
         description: <<~'DESCRIPTION'
           Describes whether StackSets performs non-conflicting operations concurrently and queues conflicting operations.
         DESCRIPTION

property :operation_preferences, Hash,
         callbacks: {
           "Subproperty `FailureToleranceCount` is not a Integer" => lambda { |v| v[:FailureToleranceCount].is_a? Integer },
           "Subproperty `FailureTolerancePercentage` is not a Integer" => lambda { |v| v[:FailureTolerancePercentage].is_a? Integer },
           "Subproperty `MaxConcurrentCount` is not a Integer" => lambda { |v| v[:MaxConcurrentCount].is_a? Integer },
           "Subproperty `MaxConcurrentPercentage` is not a Integer" => lambda { |v| v[:MaxConcurrentPercentage].is_a? Integer },
           "Subproperty `RegionOrder` is not a Array" => lambda { |v| v[:RegionOrder].is_a? Array },
         },
         description: ""

property :parameters, Array,
         callbacks: {
           "parameters is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The input parameters for the stack set template.
         DESCRIPTION

property :permission_model, String,
         required: true,
         callbacks: {
           "permission_model is not a String" => lambda { |v| v.is_a? String },
           "permission_modelis not one of `SERVICE_MANAGED`, `SELF_MANAGED`" => lambda { |v| %w{SERVICE_MANAGED SELF_MANAGED}.include? v },
         },
         description: <<~'DESCRIPTION'
           Describes how the IAM roles required for stack set operations are created. By default, SELF-MANAGED is specified.
         DESCRIPTION

property :stack_instances_group, Array,
         callbacks: {
           "stack_instances_group is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A group of stack instances with parameters in some specific accounts and regions.
         DESCRIPTION

property :stack_set_name, String,
         required: true,
         callbacks: {
           "stack_set_name is not a String" => lambda { |v| v.is_a? String },
           "stack_set_name must match pattern ^[a-zA-Z][a-zA-Z0-9\-]{0,127}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z][a-zA-Z0-9\-]{0,127}$/") },
         },
         description: <<~'DESCRIPTION'
           The name to associate with the stack set. The name must be unique in the Region where you create your stack set.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The key-value pairs to associate with this stack set and the stacks created from it. AWS CloudFormation also propagates these tags to supported resources that are created in the stacks. A maximum number of 50 tags can be specified.
         DESCRIPTION

property :template_body, String,
         callbacks: {
           "template_body is not a String" => lambda { |v| v.is_a? String },
           "template_body needs to be 1..51200 characters" => lambda { |v| v.length >= 1 && v.length <= 51200 },
         },
         description: <<~'DESCRIPTION'
           The structure that contains the template body, with a minimum length of 1 byte and a maximum length of 51,200 bytes.
         DESCRIPTION

property :template_url, String,
         callbacks: {
           "template_url is not a String" => lambda { |v| v.is_a? String },
           "template_url needs to be 1..5120 characters" => lambda { |v| v.length >= 1 && v.length <= 5120 },
         },
         description: <<~'DESCRIPTION'
           Location of file containing the template body. The URL must point to a template (max size: 460,800 bytes) that is located in an Amazon S3 bucket.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::CloudFormation::StackSet"
rest_api_document "/AWS::CloudFormation::StackSet"

rest_property_map({
  administration_role_arn: "AdministrationRoleARN",
  auto_deployment:         "AutoDeployment",
  call_as:                 "CallAs",
  capabilities:            "Capabilities",
  description:             "Description",
  execution_role_name:     "ExecutionRoleName",
  managed_execution:       "ManagedExecution",
  operation_preferences:   "OperationPreferences",
  parameters:              "Parameters",
  permission_model:        "PermissionModel",
  stack_instances_group:   "StackInstancesGroup",
  stack_set_name:          "StackSetName",
  tags:                    "Tags",
  template_body:           "TemplateBody",
  template_url:            "TemplateURL",
})

rest_post_only_properties %i{
  permission_model stack_set_name
}
