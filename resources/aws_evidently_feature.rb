# Import API specifics
use "awscc_base"

resource_name :aws_evidently_feature
provides :aws_evidently_feature, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Evidently::Feature.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :default_variation, String,
         callbacks: {
           "default_variation is not a String" => lambda { |v| v.is_a? String },
           "default_variation needs to be 1..127 characters" => lambda { |v| v.length >= 1 && v.length <= 127 },
           "default_variation must match pattern [-a-zA-Z0-9._]*" => lambda { |v| v =~ Regexp.new("/[-a-zA-Z0-9._]*/") },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..160 characters" => lambda { |v| v.length >= 0 && v.length <= 160 },
         },
         description: ""

property :entity_overrides, Array,
         callbacks: {
           "entity_overrides is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :evaluation_strategy, String,
         callbacks: {
           "evaluation_strategy is not a String" => lambda { |v| v.is_a? String },
           "evaluation_strategyis not one of `ALL_RULES`, `DEFAULT_VARIATION`" => lambda { |v| %w{ALL_RULES DEFAULT_VARIATION}.include? v },
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

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "An array of key-value pairs to apply to this resource."

property :variations, Array,
         required: true,
         callbacks: {
           "variations is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Evidently::Feature"
rest_api_document "/AWS::Evidently::Feature"

rest_property_map({
  default_variation:   "DefaultVariation",
  description:         "Description",
  entity_overrides:    "EntityOverrides",
  evaluation_strategy: "EvaluationStrategy",
  name:                "Name",
  project:             "Project",
  tags:                "Tags",
  variations:          "Variations",
})

rest_post_only_properties %i{
  name project
}
