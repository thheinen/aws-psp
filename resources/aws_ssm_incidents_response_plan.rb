# Import API specifics
use "awscc_base"

resource_name :aws_ssm_incidents_response_plan
provides :aws_ssm_incidents_response_plan, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource type definition for AWS::SSMIncidents::ResponsePlan
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :actions, Array,
         callbacks: {
           "actions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The list of actions.
         DESCRIPTION

property :chat_channel, Hash,
         description: ""

property :display_name, String,
         callbacks: {
           "display_name is not a String" => lambda { |v| v.is_a? String },
           "display_name needs to be 1..200 characters" => lambda { |v| v.length >= 1 && v.length <= 200 },
         },
         description: <<~'DESCRIPTION'
           The display name of the response plan.
         DESCRIPTION

property :engagements, Array,
         callbacks: {
           "engagements is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The list of engagements to use.
         DESCRIPTION

property :incident_template, Hash,
         required: true,
         callbacks: {
           "Subproperty `DedupeString` is not a String" => lambda { |v| v[:DedupeString].is_a? String },
           "Subproperty `DedupeString` needs to be 1..1000 characters" => lambda { |v| v[:DedupeString].length >= 1 && v[:DedupeString].length <= 1000 },
           "Subproperty `Impact` is not a Integer" => lambda { |v| v[:Impact].is_a? Integer },
           "Subproperty `NotificationTargets` is not a Array" => lambda { |v| v[:NotificationTargets].is_a? Array },
           "Subproperty `Summary` is not a String" => lambda { |v| v[:Summary].is_a? String },
           "Subproperty `Summary` needs to be 1..4000 characters" => lambda { |v| v[:Summary].length >= 1 && v[:Summary].length <= 4000 },
           "Subproperty `Title` is not a String" => lambda { |v| v[:Title].is_a? String },
           "Subproperty `IncidentTags` is not a Array" => lambda { |v| v[:IncidentTags].is_a? Array },
         },
         description: ""

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..200 characters" => lambda { |v| v.length >= 1 && v.length <= 200 },
           "name must match pattern ^[a-zA-Z0-9_-]*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_-]*$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the response plan.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags to apply to the response plan.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SSMIncidents::ResponsePlan"
rest_api_document "/AWS::SSMIncidents::ResponsePlan"

rest_property_map({
  actions:           "Actions",
  chat_channel:      "ChatChannel",
  display_name:      "DisplayName",
  engagements:       "Engagements",
  incident_template: "IncidentTemplate",
  name:              "Name",
  tags:              "Tags",
})

rest_post_only_properties %i{
  name
}
