# Import API specifics
use "awscc_base"

resource_name :aws_iot_twinmaker_component_type
provides :aws_iot_twinmaker_component_type, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::IoTTwinMaker::ComponentType
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :component_type_id, String,
         required: true,
         callbacks: {
           "component_type_id is not a String" => lambda { |v| v.is_a? String },
           "component_type_id needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "component_type_id must match pattern [a-zA-Z_\.\-0-9:]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z_\.\-0-9:]+/") },
         },
         description: "The ID of the component type."

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..512 characters" => lambda { |v| v.length >= 0 && v.length <= 512 },
         },
         description: "The description of the component type."

property :extends_from, Array,
         callbacks: {
           "extends_from is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "Specifies the parent component type to extend."

property :functions, Hash,
         callbacks: {
           "functions is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: "a Map of functions in the component type. Each function's key must be unique to this map."

property :is_singleton, [TrueClass, FalseClass],
         callbacks: {
           "is_singleton is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A Boolean value that specifies whether an entity can have more than one component of this type.

         DESCRIPTION

property :property_definitions, Hash,
         callbacks: {
           "property_definitions is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: "An map of the property definitions in the component type. Each property definition's key must be unique to this map."

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: "A map of key-value pairs to associate with a resource."

property :workspace_id, String,
         required: true,
         callbacks: {
           "workspace_id is not a String" => lambda { |v| v.is_a? String },
           "workspace_id needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "workspace_id must match pattern [a-zA-Z_0-9][a-zA-Z_\-0-9]*[a-zA-Z0-9]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z_0-9][a-zA-Z_\-0-9]*[a-zA-Z0-9]+/") },
         },
         description: "The ID of the workspace that contains the component type."

# API URLs and mappings
rest_api_collection "/AWS::IoTTwinMaker::ComponentType"
rest_api_document "/AWS::IoTTwinMaker::ComponentType"

rest_property_map({
  component_type_id:    "ComponentTypeId",
  description:          "Description",
  extends_from:         "ExtendsFrom",
  functions:            "Functions",
  is_singleton:         "IsSingleton",
  property_definitions: "PropertyDefinitions",
  tags:                 "Tags",
  workspace_id:         "WorkspaceId",
})

rest_post_only_properties %i{
  component_type_id workspace_id
}
