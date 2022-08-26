# Import API specifics
use "awscc_base"

resource_name :aws_glue_schema
provides :aws_glue_schema, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  This resource represents a schema of Glue Schema Registry.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :checkpoint_version, Hash,
         callbacks: {
           "Subproperty `IsLatest` is not a Boolean" => lambda { |v| v[:IsLatest].is_a? Boolean },
           "Subproperty `VersionNumber` is not a Integer" => lambda { |v| v[:VersionNumber].is_a? Integer },
         },
         description: ""

property :compatibility, String,
         required: true,
         callbacks: {
           "compatibility is not a String" => lambda { |v| v.is_a? String },
           "compatibilityis not one of `NONE`, `DISABLED`, `BACKWARD`, `BACKWARD_ALL`, `FORWARD`, `FORWARD_ALL`, `FULL`, `FULL_ALL`" => lambda { |v| %w{NONE DISABLED BACKWARD BACKWARD_ALL FORWARD FORWARD_ALL FULL FULL_ALL}.include? v },
         },
         description: "Compatibility setting for the schema."

property :data_format, String,
         required: true,
         callbacks: {
           "data_format is not a String" => lambda { |v| v.is_a? String },
           "data_formatis not one of `AVRO`, `JSON`, `PROTOBUF`" => lambda { |v| %w{AVRO JSON PROTOBUF}.include? v },
         },
         description: "Data format name to use for the schema. Accepted values: 'AVRO', 'JSON', 'PROTOBUF'"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..1000 characters" => lambda { |v| v.length >= 0 && v.length <= 1000 },
         },
         description: "A description of the schema. If description is not provided, there will not be any default value for this."

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: "Name of the schema."

property :registry, Hash,
         callbacks: {
           "Subproperty `Name` is not a String" => lambda { |v| v[:Name].is_a? String },
           "Subproperty `Name` needs to be 1..255 characters" => lambda { |v| v[:Name].length >= 1 && v[:Name].length <= 255 },
           "Subproperty `Arn` is not a String" => lambda { |v| v[:Arn].is_a? String },
           "Subproperty `Arn` must match pattern arn:(aws|aws-us-gov|aws-cn):glue:.*" => lambda { |v| v[:Arn] =~ Regexp.new("/arn:(aws|aws-us-gov|aws-cn):glue:.*/") },
           "Subproperty `Arn`is not a valid ARN" => lambda { |v| v[:Arn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: ""

property :schema_definition, String,
         required: true,
         callbacks: {
           "schema_definition is not a String" => lambda { |v| v.is_a? String },
           "schema_definition needs to be 1..170000 characters" => lambda { |v| v.length >= 1 && v.length <= 170000 },
         },
         description: "Definition for the initial schema version in plain-text."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "List of tags to tag the schema"

# API URLs and mappings
rest_api_collection "/AWS::Glue::Schema"
rest_api_document "/AWS::Glue::Schema"

rest_property_map({
  checkpoint_version: "CheckpointVersion",
  compatibility:      "Compatibility",
  data_format:        "DataFormat",
  description:        "Description",
  name:               "Name",
  registry:           "Registry",
  schema_definition:  "SchemaDefinition",
  tags:               "Tags",
})

rest_post_only_properties %i{
  data_format name registry schema_definition
}
