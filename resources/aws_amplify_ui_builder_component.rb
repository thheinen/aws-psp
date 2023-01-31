# Import API specifics
use "awscc_base"

resource_name :aws_amplify_ui_builder_component
provides :aws_amplify_ui_builder_component, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::AmplifyUIBuilder::Component Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :app_id, String,
         callbacks: {
           "app_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :binding_properties, Hash,
         required: true,
         callbacks: {
           "binding_properties is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :children, Array,
         callbacks: {
           "children is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :collection_properties, Hash,
         callbacks: {
           "collection_properties is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :component_type, String,
         required: true,
         callbacks: {
           "component_type is not a String" => lambda { |v| v.is_a? String },
           "component_type needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: ""

property :environment_name, String,
         callbacks: {
           "environment_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :events, Hash,
         callbacks: {
           "events is not a Object" => lambda { |v| v.is_a? Object },
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

property :overrides, Hash,
         required: true,
         callbacks: {
           "overrides is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :properties, Hash,
         required: true,
         callbacks: {
           "properties is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :schema_version, String,
         callbacks: {
           "schema_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :source_id, String,
         callbacks: {
           "source_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :variants, Array,
         required: true,
         callbacks: {
           "variants is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::AmplifyUIBuilder::Component"
rest_api_document "/AWS::AmplifyUIBuilder::Component"

rest_property_map({
  app_id:                "AppId",
  binding_properties:    "BindingProperties",
  children:              "Children",
  collection_properties: "CollectionProperties",
  component_type:        "ComponentType",
  environment_name:      "EnvironmentName",
  events:                "Events",
  name:                  "Name",
  overrides:             "Overrides",
  properties:            "Properties",
  schema_version:        "SchemaVersion",
  source_id:             "SourceId",
  tags:                  "Tags",
  variants:              "Variants",
})

rest_post_only_properties %i{
  tags
}
