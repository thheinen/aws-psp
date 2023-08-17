# Import API specifics
use "awscc_base"

resource_name :aws_entity_resolution_schema_mapping
provides :aws_entity_resolution_schema_mapping, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  SchemaMapping defined in AWS Entity Resolution service
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
           The description of the SchemaMapping
         DESCRIPTION

property :mapped_input_fields, Hash,
         required: true,
         callbacks: {
           "mapped_input_fields is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The SchemaMapping attributes input
         DESCRIPTION

property :schema_name, Hash,
         required: true,
         callbacks: {
           "schema_name is not a String" => lambda { |v| v.is_a? String },
           "schema_name needs to be 0..255 characters" => lambda { |v| v.length >= 0 && v.length <= 255 },
           "schema_name must match pattern ^[a-zA-Z_0-9-]*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z_0-9-]*$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the SchemaMapping
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::EntityResolution::SchemaMapping"
rest_api_document "/AWS::EntityResolution::SchemaMapping"

rest_property_map({
  description:         "Description",
  mapped_input_fields: "MappedInputFields",
  schema_name:         "SchemaName",
  tags:                "Tags",
})

rest_post_only_properties %i{
  description mapped_input_fields schema_name
}
