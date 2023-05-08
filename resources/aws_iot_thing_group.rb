# Import API specifics
use "awscc_base"

resource_name :aws_iot_thing_group
provides :aws_iot_thing_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::IoT::ThingGroup
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :parent_group_name, String,
         callbacks: {
           "parent_group_name is not a String" => lambda { |v| v.is_a? String },
           "parent_group_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "parent_group_name must match pattern [a-zA-Z0-9:_-]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9:_-]+/") },
         },
         description: ""

property :query_string, String,
         callbacks: {
           "query_string is not a String" => lambda { |v| v.is_a? String },
           "query_string needs to be 1..1000 characters" => lambda { |v| v.length >= 1 && v.length <= 1000 },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

property :thing_group_name, String,
         callbacks: {
           "thing_group_name is not a String" => lambda { |v| v.is_a? String },
           "thing_group_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "thing_group_name must match pattern [a-zA-Z0-9:_-]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9:_-]+/") },
         },
         description: ""

property :thing_group_properties, Hash,
         callbacks: {
           "Subproperty `ThingGroupDescription` is not a String" => lambda { |v| v[:ThingGroupDescription].is_a? String },
           "Subproperty `ThingGroupDescription` must match pattern [\p{Graph}\x20]*" => lambda { |v| v[:ThingGroupDescription] =~ Regexp.new("/[\p{Graph}\x20]*/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::IoT::ThingGroup"
rest_api_document "/AWS::IoT::ThingGroup"

rest_property_map({
  parent_group_name:      "ParentGroupName",
  query_string:           "QueryString",
  tags:                   "Tags",
  thing_group_name:       "ThingGroupName",
  thing_group_properties: "ThingGroupProperties",
})

rest_post_only_properties %i{
  parent_group_name thing_group_name
}
