# Import API specifics
use "awscc_base"

resource_name :aws_entity_resolution_matching_workflow
provides :aws_entity_resolution_matching_workflow, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  MatchingWorkflow defined in AWS Entity Resolution service
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, Hash,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..255 characters" => lambda { |v| v.length >= 0 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           The description of the MatchingWorkflow
         DESCRIPTION

property :input_source_config, Array,
         required: true,
         callbacks: {
           "input_source_config is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :output_source_config, Array,
         required: true,
         callbacks: {
           "output_source_config is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :resolution_techniques, Hash,
         required: true,
         callbacks: {
           "Subproperty `ResolutionType` is not a String" => lambda { |v| v[:ResolutionType].is_a? String },
           "Subproperty `ResolutionType`is not one of `RULE_MATCHING`, `ML_MATCHING`" => lambda { |v| %w{RULE_MATCHING ML_MATCHING}.include? v[:ResolutionType] },
         },
         description: ""

property :role_arn, String,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
           "role_arn must match pattern ^arn:(aws|aws-us-gov|aws-cn):iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+$" => lambda { |v| v =~ Regexp.new("/^arn:(aws|aws-us-gov|aws-cn):iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+$/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :workflow_name, Hash,
         required: true,
         callbacks: {
           "workflow_name is not a String" => lambda { |v| v.is_a? String },
           "workflow_name needs to be 0..255 characters" => lambda { |v| v.length >= 0 && v.length <= 255 },
           "workflow_name must match pattern ^[a-zA-Z_0-9-]*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z_0-9-]*$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the MatchingWorkflow
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EntityResolution::MatchingWorkflow"
rest_api_document "/AWS::EntityResolution::MatchingWorkflow"

rest_property_map({
  description:           "Description",
  input_source_config:   "InputSourceConfig",
  output_source_config:  "OutputSourceConfig",
  resolution_techniques: "ResolutionTechniques",
  role_arn:              "RoleArn",
  tags:                  "Tags",
  workflow_name:         "WorkflowName",
})

rest_post_only_properties %i{
  workflow_name
}
