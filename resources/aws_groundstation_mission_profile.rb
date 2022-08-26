# Import API specifics
use "awscc_base"

resource_name :aws_groundstation_mission_profile
provides :aws_groundstation_mission_profile, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  AWS Ground Station Mission Profile resource type for CloudFormation.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :contact_post_pass_duration_seconds, Integer,
         callbacks: {
           "contact_post_pass_duration_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "Post-pass time needed after the contact."

property :contact_pre_pass_duration_seconds, Integer,
         callbacks: {
           "contact_pre_pass_duration_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "Pre-pass time needed before the contact."

property :dataflow_edges, Array,
         required: true,
         callbacks: {
           "dataflow_edges is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :minimum_viable_contact_duration_seconds, Integer,
         required: true,
         callbacks: {
           "minimum_viable_contact_duration_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "Visibilities with shorter duration than the specified minimum viable contact duration will be ignored when searching for available contacts."

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name must match pattern ^[ a-zA-Z0-9_:-]{1,256}$" => lambda { |v| v =~ Regexp.new("/^[ a-zA-Z0-9_:-]{1,256}$/") },
         },
         description: "A name used to identify a mission profile."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tracking_config_arn, String,
         required: true,
         callbacks: {
           "tracking_config_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::GroundStation::MissionProfile"
rest_api_document "/AWS::GroundStation::MissionProfile"

rest_property_map({
  contact_post_pass_duration_seconds:      "ContactPostPassDurationSeconds",
  contact_pre_pass_duration_seconds:       "ContactPrePassDurationSeconds",
  dataflow_edges:                          "DataflowEdges",
  minimum_viable_contact_duration_seconds: "MinimumViableContactDurationSeconds",
  name:                                    "Name",
  tags:                                    "Tags",
  tracking_config_arn:                     "TrackingConfigArn",
})

