# Import API specifics
use "awscc_base"

resource_name :aws_amplify_ui_builder_form
provides :aws_amplify_ui_builder_form, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::AmplifyUIBuilder::Form Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :app_id, String,
         callbacks: {
           "app_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :cta, Hash,
         description: ""

property :data_type, Hash,
         required: true,
         callbacks: {
           "Subproperty `DataTypeName` is not a String" => lambda { |v| v[:DataTypeName].is_a? String },
         },
         description: ""

property :environment_name, String,
         callbacks: {
           "environment_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :fields, Hash,
         required: true,
         callbacks: {
           "fields is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :form_action_type, Hash,
         required: true,
         callbacks: {
           "form_action_type is not a String" => lambda { |v| v.is_a? String },
           "form_action_typeis not one of `create`, `update`" => lambda { |v| %w{create update}.include? v },
         },
         description: ""

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: ""

property :schema_version, String,
         required: true,
         callbacks: {
           "schema_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :sectional_elements, Hash,
         required: true,
         callbacks: {
           "sectional_elements is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :style, Hash,
         required: true,
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::AmplifyUIBuilder::Form"
rest_api_document "/AWS::AmplifyUIBuilder::Form"

rest_property_map({
  app_id:             "AppId",
  cta:                "Cta",
  data_type:          "DataType",
  environment_name:   "EnvironmentName",
  fields:             "Fields",
  form_action_type:   "FormActionType",
  name:               "Name",
  schema_version:     "SchemaVersion",
  sectional_elements: "SectionalElements",
  style:              "Style",
  tags:               "Tags",
})

rest_post_only_properties %i{
  tags
}
