# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_glue_schema_version
provides :aws_glue_schema_version, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  This resource represents an individual schema version of a schema defined in Glue Schema Registry.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :schema, Hash,
         required: true,
         callbacks: {
           "Subproperty `SchemaArn` is not a String" => lambda { |v| v[:SchemaArn].is_a? String },
           "Subproperty `SchemaArn` must match pattern arn:(aws|aws-us-gov|aws-cn):glue:.*" => lambda { |v| v[:SchemaArn] =~ Regexp.new("/arn:(aws|aws-us-gov|aws-cn):glue:.*/") },
           "Subproperty `SchemaArn`is not a valid ARN" => lambda { |v| v[:SchemaArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `SchemaName` is not a String" => lambda { |v| v[:SchemaName].is_a? String },
           "Subproperty `SchemaName` needs to be 1..255 characters" => lambda { |v| v[:SchemaName].length >= 1 && v[:SchemaName].length <= 255 },
           "Subproperty `RegistryName` is not a String" => lambda { |v| v[:RegistryName].is_a? String },
           "Subproperty `RegistryName` needs to be 1..255 characters" => lambda { |v| v[:RegistryName].length >= 1 && v[:RegistryName].length <= 255 },
         },
         description: ""

property :schema_definition, String,
         required: true,
         callbacks: {
           "schema_definition is not a String" => lambda { |v| v.is_a? String },
           "schema_definition needs to be 1..170000 characters" => lambda { |v| v.length >= 1 && v.length <= 170000 },
         },
         description: <<~'DESCRIPTION'
           Complete definition of the schema in plain-text.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Glue::SchemaVersion"
rest_api_document "/AWS::Glue::SchemaVersion"

rest_property_map({
  schema:            "Schema",
  schema_definition: "SchemaDefinition",
})

rest_post_only_properties %i{
  schema schema_definition
}
