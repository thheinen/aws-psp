# Import API specifics
use "awscc_base"

resource_name :aws_iot_topic_rule
provides :aws_iot_topic_rule, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::IoT::TopicRule
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :rule_name, String,
         callbacks: {
           "rule_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :topic_rule_payload, Hash,
         required: true,
         callbacks: {
           "Subproperty `RuleDisabled` is not a Boolean" => lambda { |v| v[:RuleDisabled].is_a? Boolean },
           "Subproperty `Description` is not a String" => lambda { |v| v[:Description].is_a? String },
           "Subproperty `AwsIotSqlVersion` is not a String" => lambda { |v| v[:AwsIotSqlVersion].is_a? String },
           "Subproperty `Actions` is not a Array" => lambda { |v| v[:Actions].is_a? Array },
           "Subproperty `Sql` is not a String" => lambda { |v| v[:Sql].is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::IoT::TopicRule"
rest_api_document "/AWS::IoT::TopicRule"

rest_property_map({
  rule_name:          "RuleName",
  tags:               "Tags",
  topic_rule_payload: "TopicRulePayload",
})

rest_post_only_properties %i{
  rule_name
}
