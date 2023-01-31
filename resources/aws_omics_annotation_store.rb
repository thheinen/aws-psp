# Import API specifics
use "awscc_base"

resource_name :aws_omics_annotation_store
provides :aws_omics_annotation_store, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::Omics::AnnotationStore Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..500 characters" => lambda { |v| v.length >= 0 && v.length <= 500 },
         },
         description: ""

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name must match pattern ^([a-z]){1}([a-z0-9_]){2,254}" => lambda { |v| v =~ Regexp.new("/^([a-z]){1}([a-z0-9_]){2,254}/") },
         },
         description: ""

property :reference, Hash,
         callbacks: {
           "Subproperty `ReferenceArn` is not a String" => lambda { |v| v[:ReferenceArn].is_a? String },
           "Subproperty `ReferenceArn` needs to be 1..127 characters" => lambda { |v| v[:ReferenceArn].length >= 1 && v[:ReferenceArn].length <= 127 },
           "Subproperty `ReferenceArn` must match pattern ^arn:.+$" => lambda { |v| v[:ReferenceArn] =~ Regexp.new("/^arn:.+$/") },
           "Subproperty `ReferenceArn`is not a valid ARN" => lambda { |v| v[:ReferenceArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: ""

property :sse_config, Hash,
         callbacks: {
           "Subproperty `KeyArn` is not a String" => lambda { |v| v[:KeyArn].is_a? String },
           "Subproperty `KeyArn` needs to be 20..2048 characters" => lambda { |v| v[:KeyArn].length >= 20 && v[:KeyArn].length <= 2048 },
           "Subproperty `KeyArn` must match pattern arn:([^:
           ]*):([^:
           ]*):([^:
           ]*):([0-9]{12}):([^:
           ]*)" => lambda { |v| v[:KeyArn] =~ Regexp.new("/arn:([^:
           ]*):([^:
           ]*):([^:
           ]*):([0-9]{12}):([^:
           ]*)/") },
           "Subproperty `KeyArn`is not a valid ARN" => lambda { |v| v[:KeyArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: ""

property :store_format, Hash,
         required: true,
         callbacks: {
           "store_format is not a String" => lambda { |v| v.is_a? String },
           "store_formatis not one of `GFF`, `TSV`, `VCF`" => lambda { |v| %w{GFF TSV VCF}.include? v },
         },
         description: ""

property :store_options, Hash,
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Omics::AnnotationStore"
rest_api_document "/AWS::Omics::AnnotationStore"

rest_property_map({
  description:   "Description",
  name:          "Name",
  reference:     "Reference",
  sse_config:    "SseConfig",
  store_format:  "StoreFormat",
  store_options: "StoreOptions",
  tags:          "Tags",
})

rest_post_only_properties %i{
  name reference sse_config store_format store_options tags
}
