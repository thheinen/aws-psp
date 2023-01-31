# Import API specifics
use "awscc_base"

resource_name :aws_omics_workflow
provides :aws_omics_workflow, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::Omics::Workflow Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :definition_uri, String,
         callbacks: {
           "definition_uri is not a String" => lambda { |v| v.is_a? String },
           "definition_uri needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "definition_uri must match pattern ^[\p{L}||\p{M}||\p{Z}||\p{S}||\p{N}||\p{P}]+$" => lambda { |v| v =~ Regexp.new("/^[\p{L}||\p{M}||\p{Z}||\p{S}||\p{N}||\p{P}]+$/") },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "description must match pattern ^[\p{L}||\p{M}||\p{Z}||\p{S}||\p{N}||\p{P}]+$" => lambda { |v| v =~ Regexp.new("/^[\p{L}||\p{M}||\p{Z}||\p{S}||\p{N}||\p{P}]+$/") },
         },
         description: ""

property :engine, Hash,
         callbacks: {
           "engine is not a String" => lambda { |v| v.is_a? String },
           "engine needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "engineis not one of `WDL`, `NEXTFLOW`" => lambda { |v| %w{WDL NEXTFLOW}.include? v },
         },
         description: ""

property :main, String,
         callbacks: {
           "main is not a String" => lambda { |v| v.is_a? String },
           "main needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "main must match pattern ^[\p{L}||\p{M}||\p{Z}||\p{S}||\p{N}||\p{P}]+$" => lambda { |v| v =~ Regexp.new("/^[\p{L}||\p{M}||\p{Z}||\p{S}||\p{N}||\p{P}]+$/") },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "name must match pattern ^[\p{L}||\p{M}||\p{Z}||\p{S}||\p{N}||\p{P}]+$" => lambda { |v| v =~ Regexp.new("/^[\p{L}||\p{M}||\p{Z}||\p{S}||\p{N}||\p{P}]+$/") },
         },
         description: ""

property :parameter_template, Hash,
         callbacks: {
           "parameter_template is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :storage_capacity, Number,
         callbacks: {
           "storage_capacity is not a Number" => lambda { |v| v.is_a? Number },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Omics::Workflow"
rest_api_document "/AWS::Omics::Workflow"

rest_property_map({
  definition_uri:     "DefinitionUri",
  description:        "Description",
  engine:             "Engine",
  main:               "Main",
  name:               "Name",
  parameter_template: "ParameterTemplate",
  storage_capacity:   "StorageCapacity",
  tags:               "Tags",
})

rest_post_only_properties %i{
  definition_uri engine main parameter_template storage_capacity
}
