# Import API specifics
use "awscc_base"

resource_name :aws_ce_cost_category
provides :aws_ce_cost_category, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Cost Category enables you to map your cost and usage into meaningful categories. You can use Cost Category to organize your costs using a rule-based engine.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :default_value, String,
         callbacks: {
           "default_value is not a String" => lambda { |v| v.is_a? String },
           "default_value needs to be 1..50 characters" => lambda { |v| v.length >= 1 && v.length <= 50 },
         },
         description: "The default value for the cost category"

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..50 characters" => lambda { |v| v.length >= 1 && v.length <= 50 },
         },
         description: ""

property :rule_version, String,
         required: true,
         callbacks: {
           "rule_version is not a String" => lambda { |v| v.is_a? String },
           "rule_versionis not one of `CostCategoryExpression.v1`" => lambda { |v| %w{CostCategoryExpression.v1}.include? v },
         },
         description: ""

property :rules, String,
         required: true,
         callbacks: {
           "rules is not a String" => lambda { |v| v.is_a? String },
         },
         description: "JSON array format of Expression in Billing and Cost Management API"

property :split_charge_rules, String,
         callbacks: {
           "split_charge_rules is not a String" => lambda { |v| v.is_a? String },
         },
         description: "Json array format of CostCategorySplitChargeRule in Billing and Cost Management API"

# API URLs and mappings
rest_api_collection "/AWS::CE::CostCategory"
rest_api_document "/AWS::CE::CostCategory"

rest_property_map({
  default_value:      "DefaultValue",
  name:               "Name",
  rule_version:       "RuleVersion",
  rules:              "Rules",
  split_charge_rules: "SplitChargeRules",
})

rest_post_only_properties %i{
  name
}
