# Import API specifics
use "awscc_base"

resource_name :aws_iot_mitigation_action
provides :aws_iot_mitigation_action, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Mitigation actions can be used to take actions to mitigate issues that were found in an Audit finding or Detect violation.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :action_name, String,
         callbacks: {
           "action_name is not a String" => lambda { |v| v.is_a? String },
           "action_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "action_name must match pattern [a-zA-Z0-9:_-]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9:_-]+/") },
         },
         description: "A unique identifier for the mitigation action."

property :action_params, Hash,
         required: true,
         description: ""

property :role_arn, String,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "An array of key-value pairs to apply to this resource."

# API URLs and mappings
rest_api_collection "/AWS::IoT::MitigationAction"
rest_api_document "/AWS::IoT::MitigationAction"

rest_property_map({
  action_name:   "ActionName",
  action_params: "ActionParams",
  role_arn:      "RoleArn",
  tags:          "Tags",
})

rest_post_only_properties %i{
  action_name
}
