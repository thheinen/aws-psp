# Import API specifics
use "awscc_base"

resource_name :aws_budgets_budgets_action
provides :aws_budgets_budgets_action, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  An example resource schema demonstrating some basic constructs and validation rules.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :action_threshold, Hash,
         required: true,
         callbacks: {
           "Subproperty `Value` is not a Number" => lambda { |v| v[:Value].is_a? Number },
           "Subproperty `Type` is not a String" => lambda { |v| v[:Type].is_a? String },
           "Subproperty `Type`is not one of `PERCENTAGE`, `ABSOLUTE_VALUE`" => lambda { |v| %w{PERCENTAGE ABSOLUTE_VALUE}.include? v[:Type] },
         },
         description: ""

property :action_type, String,
         required: true,
         callbacks: {
           "action_type is not a String" => lambda { |v| v.is_a? String },
           "action_typeis not one of `APPLY_IAM_POLICY`, `APPLY_SCP_POLICY`, `RUN_SSM_DOCUMENTS`" => lambda { |v| %w{APPLY_IAM_POLICY APPLY_SCP_POLICY RUN_SSM_DOCUMENTS}.include? v },
         },
         description: ""

property :approval_model, String,
         callbacks: {
           "approval_model is not a String" => lambda { |v| v.is_a? String },
           "approval_modelis not one of `AUTOMATIC`, `MANUAL`" => lambda { |v| %w{AUTOMATIC MANUAL}.include? v },
         },
         description: ""

property :budget_name, String,
         required: true,
         callbacks: {
           "budget_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :definition, Hash,
         required: true,
         description: ""

property :execution_role_arn, String,
         required: true,
         callbacks: {
           "execution_role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :notification_type, String,
         required: true,
         callbacks: {
           "notification_type is not a String" => lambda { |v| v.is_a? String },
           "notification_typeis not one of `ACTUAL`, `FORECASTED`" => lambda { |v| %w{ACTUAL FORECASTED}.include? v },
         },
         description: ""

property :subscribers, Array,
         required: true,
         callbacks: {
           "subscribers is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Budgets::BudgetsAction"
rest_api_document "/AWS::Budgets::BudgetsAction"

rest_property_map({
  action_threshold:   "ActionThreshold",
  action_type:        "ActionType",
  approval_model:     "ApprovalModel",
  budget_name:        "BudgetName",
  definition:         "Definition",
  execution_role_arn: "ExecutionRoleArn",
  notification_type:  "NotificationType",
  subscribers:        "Subscribers",
})

rest_post_only_properties %i{
  action_type budget_name
}
