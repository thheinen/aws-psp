# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_glue_registry
provides :aws_glue_registry, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  This resource creates a Registry for authoring schemas as part of Glue Schema Registry.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..1000 characters" => lambda { |v| v.length >= 0 && v.length <= 1000 },
         },
         description: <<~'DESCRIPTION'
           A description of the registry. If description is not provided, there will not be any default value for this.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           Name of the registry to be created of max length of 255, and may only contain letters, numbers, hyphen, underscore, dollar sign, or hash mark.  No whitespace.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           List of tags to tag the Registry
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Glue::Registry"
rest_api_document "/AWS::Glue::Registry"

rest_property_map({
  description: "Description",
  name:        "Name",
  tags:        "Tags",
})

rest_post_only_properties %i{
  name
}
