# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_glue_schema_version_metadata
provides :aws_glue_schema_version_metadata, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  This resource adds Key-Value metadata to a Schema version of Glue Schema Registry.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :key, String,
         required: true,
         callbacks: {
           "key is not a String" => lambda { |v| v.is_a? String },
           "key needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
         },
         description: <<~'DESCRIPTION'
           Metadata key
         DESCRIPTION

property :schema_version_id, String,
         required: true,
         callbacks: {
           "schema_version_id is not a String" => lambda { |v| v.is_a? String },
           "schema_version_id must match pattern [a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}" => lambda { |v| v =~ Regexp.new("/[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}/") },
         },
         description: <<~'DESCRIPTION'
           Represents the version ID associated with the schema version.
         DESCRIPTION

property :value, String,
         required: true,
         callbacks: {
           "value is not a String" => lambda { |v| v.is_a? String },
           "value needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
         },
         description: <<~'DESCRIPTION'
           Metadata value
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Glue::SchemaVersionMetadata"
rest_api_document "/AWS::Glue::SchemaVersionMetadata"

rest_property_map({
  key:               "Key",
  schema_version_id: "SchemaVersionId",
  value:             "Value",
})

rest_post_only_properties %i{
  key schema_version_id value
}
