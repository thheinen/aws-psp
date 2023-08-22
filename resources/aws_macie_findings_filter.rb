# Import API specifics
use "awscc_base"

resource_name :aws_macie_findings_filter
provides :aws_macie_findings_filter, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Macie FindingsFilter resource schema.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :action, Hash,
         callbacks: {
           "action is not a String" => lambda { |v| v.is_a? String },
           "actionis not one of `ARCHIVE`, `NOOP`" => lambda { |v| %w{ARCHIVE NOOP}.include? v },
         },
         description: <<~'DESCRIPTION'
           Findings filter action.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Findings filter description
         DESCRIPTION

property :finding_criteria, Hash,
         required: true,
         description: <<~'DESCRIPTION'
           Findings filter criteria.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Findings filter name
         DESCRIPTION

property :position, Integer,
         callbacks: {
           "position is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           Findings filter position.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A collection of tags associated with a resource
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Macie::FindingsFilter"
rest_api_document "/AWS::Macie::FindingsFilter"

rest_property_map({
  action:           "Action",
  description:      "Description",
  finding_criteria: "FindingCriteria",
  name:             "Name",
  position:         "Position",
  tags:             "Tags",
})

