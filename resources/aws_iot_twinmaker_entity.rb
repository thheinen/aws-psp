# Import API specifics
use "awscc_base"

resource_name :aws_iot_twinmaker_entity
provides :aws_iot_twinmaker_entity, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::IoTTwinMaker::Entity
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :components, Hash,
         callbacks: {
           "components is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           A map that sets information about a component type.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..512 characters" => lambda { |v| v.length >= 0 && v.length <= 512 },
         },
         description: <<~'DESCRIPTION'
           The description of the entity.
         DESCRIPTION

property :entity_id, String,
         callbacks: {
           "entity_id is not a String" => lambda { |v| v.is_a? String },
           "entity_id needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "entity_id must match pattern [0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}|^[a-zA-Z0-9][a-zA-Z_\-0-9.:]*[a-zA-Z0-9]+" => lambda { |v| v =~ Regexp.new("/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}|^[a-zA-Z0-9][a-zA-Z_\-0-9.:]*[a-zA-Z0-9]+/") },
         },
         description: <<~'DESCRIPTION'
           The ID of the entity.
         DESCRIPTION

property :entity_name, String,
         required: true,
         callbacks: {
           "entity_name is not a String" => lambda { |v| v.is_a? String },
           "entity_name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "entity_name must match pattern [a-zA-Z_0-9-.][a-zA-Z_0-9-. ]*[a-zA-Z0-9]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z_0-9-.][a-zA-Z_0-9-. ]*[a-zA-Z0-9]+/") },
         },
         description: <<~'DESCRIPTION'
           The name of the entity.
         DESCRIPTION

property :parent_entity_id, String,
         callbacks: {
           "parent_entity_id is not a String" => lambda { |v| v.is_a? String },
           "parent_entity_id needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "parent_entity_id must match pattern \$ROOT|^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}|^[a-zA-Z0-9][a-zA-Z_\-0-9.:]*[a-zA-Z0-9]+" => lambda { |v| v =~ Regexp.new("/\$ROOT|^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}|^[a-zA-Z0-9][a-zA-Z_\-0-9.:]*[a-zA-Z0-9]+/") },
         },
         description: <<~'DESCRIPTION'
           The ID of the parent entity.
         DESCRIPTION

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           A key-value pair to associate with a resource.
         DESCRIPTION

property :workspace_id, String,
         required: true,
         callbacks: {
           "workspace_id is not a String" => lambda { |v| v.is_a? String },
           "workspace_id needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "workspace_id must match pattern [a-zA-Z_0-9][a-zA-Z_\-0-9]*[a-zA-Z0-9]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z_0-9][a-zA-Z_\-0-9]*[a-zA-Z0-9]+/") },
         },
         description: <<~'DESCRIPTION'
           The ID of the workspace.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IoTTwinMaker::Entity"
rest_api_document "/AWS::IoTTwinMaker::Entity"

rest_property_map({
  components:       "Components",
  description:      "Description",
  entity_id:        "EntityId",
  entity_name:      "EntityName",
  parent_entity_id: "ParentEntityId",
  tags:             "Tags",
  workspace_id:     "WorkspaceId",
})

rest_post_only_properties %i{
  entity_id workspace_id
}
