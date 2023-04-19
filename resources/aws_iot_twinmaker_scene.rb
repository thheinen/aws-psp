# Import API specifics
use "awscc_base"

resource_name :aws_iot_twinmaker_scene
provides :aws_iot_twinmaker_scene, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::IoTTwinMaker::Scene
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :capabilities, Array,
         callbacks: {
           "capabilities is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of capabilities that the scene uses to render.
         DESCRIPTION

property :content_location, String,
         required: true,
         callbacks: {
           "content_location is not a String" => lambda { |v| v.is_a? String },
           "content_location needs to be 0..256 characters" => lambda { |v| v.length >= 0 && v.length <= 256 },
           "content_location must match pattern [sS]3://[A-Za-z0-9._/-]+" => lambda { |v| v =~ Regexp.new("/[sS]3://[A-Za-z0-9._/-]+/") },
         },
         description: <<~'DESCRIPTION'
           The relative path that specifies the location of the content definition file.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..512 characters" => lambda { |v| v.length >= 0 && v.length <= 512 },
         },
         description: <<~'DESCRIPTION'
           The description of the scene.
         DESCRIPTION

property :scene_id, String,
         required: true,
         callbacks: {
           "scene_id is not a String" => lambda { |v| v.is_a? String },
           "scene_id needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "scene_id must match pattern [a-zA-Z_0-9][a-zA-Z_\-0-9]*[a-zA-Z0-9]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z_0-9][a-zA-Z_\-0-9]*[a-zA-Z0-9]+/") },
         },
         description: <<~'DESCRIPTION'
           The ID of the scene.
         DESCRIPTION

property :scene_metadata, Hash,
         callbacks: {
           "scene_metadata is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           A key-value pair of scene metadata for the scene.
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
           The ID of the scene.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IoTTwinMaker::Scene"
rest_api_document "/AWS::IoTTwinMaker::Scene"

rest_property_map({
  capabilities:     "Capabilities",
  content_location: "ContentLocation",
  description:      "Description",
  scene_id:         "SceneId",
  scene_metadata:   "SceneMetadata",
  tags:             "Tags",
  workspace_id:     "WorkspaceId",
})

rest_post_only_properties %i{
  scene_id workspace_id
}
