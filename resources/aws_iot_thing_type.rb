# Import API specifics
use "awscc_base"

resource_name :aws_iot_thing_type
provides :aws_iot_thing_type, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::IoT::ThingType
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :deprecate_thing_type, [TrueClass, FalseClass],
         callbacks: {
           "deprecate_thing_type is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

property :thing_type_name, String,
         callbacks: {
           "thing_type_name is not a String" => lambda { |v| v.is_a? String },
           "thing_type_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "thing_type_name must match pattern [a-zA-Z0-9:_-]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9:_-]+/") },
         },
         description: ""

property :thing_type_properties, Hash,
         callbacks: {
           "Subproperty `SearchableAttributes` is not a Array" => lambda { |v| v[:SearchableAttributes].is_a? Array },
           "Subproperty `ThingTypeDescription` is not a String" => lambda { |v| v[:ThingTypeDescription].is_a? String },
           "Subproperty `ThingTypeDescription` must match pattern [\p{Graph}\x20]*" => lambda { |v| v[:ThingTypeDescription] =~ Regexp.new("/[\p{Graph}\x20]*/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::IoT::ThingType"
rest_api_document "/AWS::IoT::ThingType"

rest_property_map({
  deprecate_thing_type:  "DeprecateThingType",
  tags:                  "Tags",
  thing_type_name:       "ThingTypeName",
  thing_type_properties: "ThingTypeProperties",
})

rest_post_only_properties %i{
  thing_type_name thing_type_properties
}
