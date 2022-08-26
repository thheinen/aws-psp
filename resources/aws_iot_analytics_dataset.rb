# Import API specifics
use "awscc_base"

resource_name :aws_iot_analytics_dataset
provides :aws_iot_analytics_dataset, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::IoTAnalytics::Dataset
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :actions, Array,
         required: true,
         callbacks: {
           "actions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :content_delivery_rules, Array,
         callbacks: {
           "content_delivery_rules is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :dataset_name, String,
         callbacks: {
           "dataset_name is not a String" => lambda { |v| v.is_a? String },
           "dataset_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "dataset_name must match pattern (^(?!_{2}))(^[a-zA-Z0-9_]+$)" => lambda { |v| v =~ Regexp.new("/(^(?!_{2}))(^[a-zA-Z0-9_]+$)/") },
         },
         description: ""

property :late_data_rules, Array,
         callbacks: {
           "late_data_rules is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :retention_period, Hash,
         callbacks: {
           "Subproperty `NumberOfDays` is not a Integer" => lambda { |v| v[:NumberOfDays].is_a? Integer },
           "Subproperty `Unlimited` is not a Boolean" => lambda { |v| v[:Unlimited].is_a? Boolean },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :triggers, Array,
         callbacks: {
           "triggers is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :versioning_configuration, Hash,
         callbacks: {
           "Subproperty `Unlimited` is not a Boolean" => lambda { |v| v[:Unlimited].is_a? Boolean },
           "Subproperty `MaxVersions` is not a Integer" => lambda { |v| v[:MaxVersions].is_a? Integer },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::IoTAnalytics::Dataset"
rest_api_document "/AWS::IoTAnalytics::Dataset"

rest_property_map({
  actions:                  "Actions",
  content_delivery_rules:   "ContentDeliveryRules",
  dataset_name:             "DatasetName",
  late_data_rules:          "LateDataRules",
  retention_period:         "RetentionPeriod",
  tags:                     "Tags",
  triggers:                 "Triggers",
  versioning_configuration: "VersioningConfiguration",
})

rest_post_only_properties %i{
  dataset_name
}
