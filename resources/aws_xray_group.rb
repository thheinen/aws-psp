# Import API specifics
use "awscc_base"

resource_name :aws_xray_group
provides :aws_xray_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  This schema provides construct and validation rules for AWS-XRay Group resource parameters.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :filter_expression, String,
         callbacks: {
           "filter_expression is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The filter expression defining criteria by which to group traces."

property :group_name, String,
         callbacks: {
           "group_name is not a String" => lambda { |v| v.is_a? String },
           "group_name needs to be 1..32 characters" => lambda { |v| v.length >= 1 && v.length <= 32 },
         },
         description: "The case-sensitive name of the new group. Names must be unique."

property :insights_configuration, Hash,
         callbacks: {
           "Subproperty `InsightsEnabled` is not a Boolean" => lambda { |v| v[:InsightsEnabled].is_a? Boolean },
           "Subproperty `NotificationsEnabled` is not a Boolean" => lambda { |v| v[:NotificationsEnabled].is_a? Boolean },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::XRay::Group"
rest_api_document "/AWS::XRay::Group"

rest_property_map({
  filter_expression:      "FilterExpression",
  group_name:             "GroupName",
  insights_configuration: "InsightsConfiguration",
  tags:                   "Tags",
})

