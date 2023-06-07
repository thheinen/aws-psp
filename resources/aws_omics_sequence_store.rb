# Import API specifics
use "awscc_base"

resource_name :aws_omics_sequence_store
provides :aws_omics_sequence_store, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::Omics::SequenceStore Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "description must match pattern ^[\p{L}||\p{M}||\p{Z}||\p{S}||\p{N}||\p{P}]+$" => lambda { |v| v =~ Regexp.new("/^[\p{L}||\p{M}||\p{Z}||\p{S}||\p{N}||\p{P}]+$/") },
         },
         description: <<~'DESCRIPTION'
           A description for the store.
         DESCRIPTION

property :fallback_location, String,
         callbacks: {
           "fallback_location is not a String" => lambda { |v| v.is_a? String },
           "fallback_location must match pattern ^s3:\/\/([a-z0-9][a-z0-9-.]{1,61}[a-z0-9])\/?((.{1,1024})\/)?$" => lambda { |v| v =~ Regexp.new("/^s3:\/\/([a-z0-9][a-z0-9-.]{1,61}[a-z0-9])\/?((.{1,1024})\/)?$/") },
         },
         description: <<~'DESCRIPTION'
           An S3 URI representing the bucket and folder to store failed read set uploads.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..127 characters" => lambda { |v| v.length >= 1 && v.length <= 127 },
           "name must match pattern ^[\p{L}||\p{M}||\p{Z}||\p{S}||\p{N}||\p{P}]+$" => lambda { |v| v =~ Regexp.new("/^[\p{L}||\p{M}||\p{Z}||\p{S}||\p{N}||\p{P}]+$/") },
         },
         description: <<~'DESCRIPTION'
           A name for the store.
         DESCRIPTION

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

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Omics::SequenceStore"
rest_api_document "/AWS::Omics::SequenceStore"

rest_property_map({
  description:       "Description",
  fallback_location: "FallbackLocation",
  name:              "Name",
  sse_config:        "SseConfig",
  tags:              "Tags",
})

rest_post_only_properties %i{
  description fallback_location name sse_config tags
}
