# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_inspector_v2_filter
provides :aws_inspector_v2_filter, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Inspector Filter resource schema
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..512 characters" => lambda { |v| v.length >= 1 && v.length <= 512 },
         },
         description: <<~'DESCRIPTION'
           Findings filter description.
         DESCRIPTION

property :filter_action, Hash,
         required: true,
         callbacks: {
           "filter_action is not a String" => lambda { |v| v.is_a? String },
           "filter_actionis not one of `NONE`, `SUPPRESS`" => lambda { |v| %w{NONE SUPPRESS}.include? v },
         },
         description: <<~'DESCRIPTION'
           Findings filter action.
         DESCRIPTION

property :filter_criteria, Hash,
         required: true,
         description: <<~'DESCRIPTION'
           Findings filter criteria.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
         },
         description: <<~'DESCRIPTION'
           Findings filter name.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::InspectorV2::Filter"
rest_api_document "/AWS::InspectorV2::Filter"

rest_property_map({
  description:     "Description",
  filter_action:   "FilterAction",
  filter_criteria: "FilterCriteria",
  name:            "Name",
})

