# Import API specifics
use "awscc_base"

resource_name :aws_evidently_experiment
provides :aws_evidently_experiment, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Evidently::Experiment.
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

property :metric_goals, Array,
         required: true,
         callbacks: {
           "metric_goals is not a Array" => lambda { |v| v.is_a? Array },
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

property :online_ab_config, Hash,
         required: true,
         callbacks: {
           "Subproperty `ControlTreatmentName` is not a String" => lambda { |v| v[:ControlTreatmentName].is_a? String },
           "Subproperty `ControlTreatmentName` needs to be 1..127 characters" => lambda { |v| v[:ControlTreatmentName].length >= 1 && v[:ControlTreatmentName].length <= 127 },
           "Subproperty `ControlTreatmentName` must match pattern [-a-zA-Z0-9._]*" => lambda { |v| v[:ControlTreatmentName] =~ Regexp.new("/[-a-zA-Z0-9._]*/") },
           "Subproperty `TreatmentWeights` is not a Array" => lambda { |v| v[:TreatmentWeights].is_a? Array },
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

property :remove_segment, [TrueClass, FalseClass],
         callbacks: {
           "remove_segment is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :running_status, Hash,
         callbacks: {
           "Subproperty `Status` is not a String" => lambda { |v| v[:Status].is_a? String },
           "Subproperty `AnalysisCompleteTime` is not a String" => lambda { |v| v[:AnalysisCompleteTime].is_a? String },
           "Subproperty `Reason` is not a String" => lambda { |v| v[:Reason].is_a? String },
           "Subproperty `DesiredState` is not a String" => lambda { |v| v[:DesiredState].is_a? String },
           "Subproperty `DesiredState` must match pattern ^(CANCELLED|COMPLETED)" => lambda { |v| v[:DesiredState] =~ Regexp.new("/^(CANCELLED|COMPLETED)/") },
         },
         description: "Start Experiment. Default is False"

property :sampling_rate, Integer,
         callbacks: {
           "sampling_rate is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :segment, String,
         callbacks: {
           "segment is not a String" => lambda { |v| v.is_a? String },
           "segment needs to be 0..2048 characters" => lambda { |v| v.length >= 0 && v.length <= 2048 },
           "segment must match pattern ([-a-zA-Z0-9._]*)|(arn:[^:]*:[^:]*:[^:]*:[^:]*:segment/[-a-zA-Z0-9._]*)" => lambda { |v| v =~ Regexp.new("/([-a-zA-Z0-9._]*)|(arn:[^:]*:[^:]*:[^:]*:[^:]*:segment/[-a-zA-Z0-9._]*)/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "An array of key-value pairs to apply to this resource."

property :treatments, Array,
         required: true,
         callbacks: {
           "treatments is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Evidently::Experiment"
rest_api_document "/AWS::Evidently::Experiment"

rest_property_map({
  description:        "Description",
  metric_goals:       "MetricGoals",
  name:               "Name",
  online_ab_config:   "OnlineAbConfig",
  project:            "Project",
  randomization_salt: "RandomizationSalt",
  remove_segment:     "RemoveSegment",
  running_status:     "RunningStatus",
  sampling_rate:      "SamplingRate",
  segment:            "Segment",
  tags:               "Tags",
  treatments:         "Treatments",
})

rest_post_only_properties %i{
  name project
}
