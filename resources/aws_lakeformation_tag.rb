# Import API specifics
use "awscc_base"

resource_name :aws_lakeformation_tag
provides :aws_lakeformation_tag, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  A resource schema representing a Lake Formation Tag.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :catalog_id, Hash,
         callbacks: {
           "catalog_id is not a String" => lambda { |v| v.is_a? String },
           "catalog_id needs to be 12..12 characters" => lambda { |v| v.length >= 12 && v.length <= 12 },
         },
         description: "The identifier for the Data Catalog. By default, the account ID. The Data Catalog is the persistent metadata store. It contains database definitions, table definitions, and other control information to manage your Lake Formation environment."

property :tag_key, Hash,
         required: true,
         callbacks: {
           "tag_key is not a String" => lambda { |v| v.is_a? String },
           "tag_key needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "tag_key must match pattern ^([{a-zA-Z}{\s}{0-9}_.:\/=+\-@%]*)$" => lambda { |v| v =~ Regexp.new("/^([{a-zA-Z}{\s}{0-9}_.:\/=+\-@%]*)$/") },
         },
         description: "The key-name for the LF-tag."

property :tag_values, Hash,
         required: true,
         callbacks: {
           "tag_values is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "A list of possible values an attribute can take."

# API URLs and mappings
rest_api_collection "/AWS::LakeFormation::Tag"
rest_api_document "/AWS::LakeFormation::Tag"

rest_property_map({
  catalog_id: "CatalogId",
  tag_key:    "TagKey",
  tag_values: "TagValues",
})

rest_post_only_properties %i{
  catalog_id tag_key
}
