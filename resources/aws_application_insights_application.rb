# Import API specifics
use "awscc_base"

resource_name :aws_application_insights_application
provides :aws_application_insights_application, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::ApplicationInsights::Application
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :auto_configuration_enabled, [TrueClass, FalseClass],
         callbacks: {
           "auto_configuration_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           If set to true, application will be configured with recommended monitoring configuration.
         DESCRIPTION

property :component_monitoring_settings, Array,
         callbacks: {
           "component_monitoring_settings is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The monitoring settings of the components.
         DESCRIPTION

property :custom_components, Array,
         callbacks: {
           "custom_components is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The custom grouped components.
         DESCRIPTION

property :cwe_monitor_enabled, [TrueClass, FalseClass],
         callbacks: {
           "cwe_monitor_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Indicates whether Application Insights can listen to CloudWatch events for the application resources.
         DESCRIPTION

property :grouping_type, String,
         callbacks: {
           "grouping_type is not a String" => lambda { |v| v.is_a? String },
           "grouping_typeis not one of `ACCOUNT_BASED`" => lambda { |v| %w{ACCOUNT_BASED}.include? v },
         },
         description: <<~'DESCRIPTION'
           The grouping type of the application
         DESCRIPTION

property :log_pattern_sets, Array,
         callbacks: {
           "log_pattern_sets is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The log pattern sets.
         DESCRIPTION

property :ops_center_enabled, [TrueClass, FalseClass],
         callbacks: {
           "ops_center_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           When set to true, creates opsItems for any problems detected on an application.
         DESCRIPTION

property :ops_item_sns_topic_arn, String,
         callbacks: {
           "ops_item_sns_topic_arn is not a String" => lambda { |v| v.is_a? String },
           "ops_item_sns_topic_arn needs to be 20..300 characters" => lambda { |v| v.length >= 20 && v.length <= 300 },
           "ops_item_sns_topic_arn must match pattern ^arn:aws(-[\w]+)*:[\w\d-]+:([\w\d-]*)?:[\w\d_-]*([:/].+)*$" => lambda { |v| v =~ Regexp.new("/^arn:aws(-[\w]+)*:[\w\d-]+:([\w\d-]*)?:[\w\d_-]*([:/].+)*$/") },
         },
         description: <<~'DESCRIPTION'
           The SNS topic provided to Application Insights that is associated to the created opsItem.
         DESCRIPTION

property :resource_group_name, String,
         required: true,
         callbacks: {
           "resource_group_name is not a String" => lambda { |v| v.is_a? String },
           "resource_group_name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "resource_group_name must match pattern [a-zA-Z0-9.-_]*" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9.-_]*/") },
         },
         description: <<~'DESCRIPTION'
           The name of the resource group.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags of Application Insights application.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ApplicationInsights::Application"
rest_api_document "/AWS::ApplicationInsights::Application"

rest_property_map({
  auto_configuration_enabled:    "AutoConfigurationEnabled",
  component_monitoring_settings: "ComponentMonitoringSettings",
  custom_components:             "CustomComponents",
  cwe_monitor_enabled:           "CWEMonitorEnabled",
  grouping_type:                 "GroupingType",
  log_pattern_sets:              "LogPatternSets",
  ops_center_enabled:            "OpsCenterEnabled",
  ops_item_sns_topic_arn:        "OpsItemSNSTopicArn",
  resource_group_name:           "ResourceGroupName",
  tags:                          "Tags",
})

rest_post_only_properties %i{
  resource_group_name
}
