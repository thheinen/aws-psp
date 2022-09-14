# Import API specifics
use "awscc_base"

resource_name :aws_evidently_launch
provides :aws_evidently_launch, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Evidently::Launch.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..160 characters" => lambda { |v| v.length >= 0 && v.length <= 160 },
         },
         description: ""

property :execution_status, Hash,
         callbacks: {
           "Subproperty `Status` is not a String" => lambda { |v| v[:Status].is_a? String },
           "Subproperty `DesiredState` is not a String" => lambda { |v| v[:DesiredState].is_a? String },
           "Subproperty `Reason` is not a String" => lambda { |v| v[:Reason].is_a? String },
         },
         description: <<~'DESCRIPTION'
           Start or Stop Launch Launch. Default is not started.
         DESCRIPTION

property :groups, Array,
         required: true,
         callbacks: {
           "groups is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :metric_monitors, Array,
         callbacks: {
           "metric_monitors is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..127 characters" => lambda { |v| v.length >= 1 && v.length <= 127 },
           "name must match pattern [-a-zA-Z0-9._]*" => lambda { |v| v =~ Regexp.new("/[-a-zA-Z0-9._]*/") },
         },
         description: ""

property :project, String,
         required: true,
         callbacks: {
           "project is not a String" => lambda { |v| v.is_a? String },
           "project needs to be 0..2048 characters" => lambda { |v| v.length >= 0 && v.length <= 2048 },
           "project must match pattern ([-a-zA-Z0-9._]*)|(arn:[^:]*:[^:]*:[^:]*:[^:]*:project/[-a-zA-Z0-9._]*)" => lambda { |v| v =~ Regexp.new("/([-a-zA-Z0-9._]*)|(arn:[^:]*:[^:]*:[^:]*:[^:]*:project/[-a-zA-Z0-9._]*)/") },
         },
         description: ""

property :randomization_salt, String,
         callbacks: {
           "randomization_salt is not a String" => lambda { |v| v.is_a? String },
           "randomization_salt needs to be 0..127 characters" => lambda { |v| v.length >= 0 && v.length <= 127 },
           "randomization_salt must match pattern .*" => lambda { |v| v =~ Regexp.new("/.*/") },
         },
         description: ""

property :scheduled_splits_config, Array,
         required: true,
         callbacks: {
           "scheduled_splits_config is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Evidently::Launch"
rest_api_document "/AWS::Evidently::Launch"

rest_property_map({
  description:             "Description",
  execution_status:        "ExecutionStatus",
  groups:                  "Groups",
  metric_monitors:         "MetricMonitors",
  name:                    "Name",
  project:                 "Project",
  randomization_salt:      "RandomizationSalt",
  scheduled_splits_config: "ScheduledSplitsConfig",
  tags:                    "Tags",
})

rest_post_only_properties %i{
  name project
}
