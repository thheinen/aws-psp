# Import API specifics
use "awscc_base"

resource_name :aws_iot_thing
provides :aws_iot_thing, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::IoT::Thing
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :attribute_payload, Hash,
         callbacks: {
           "Subproperty `Attributes` is not a Object" => lambda { |v| v[:Attributes].is_a? Object },
         },
         description: ""

property :thing_name, String,
         callbacks: {
           "thing_name is not a String" => lambda { |v| v.is_a? String },
           "thing_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "thing_name must match pattern [a-zA-Z0-9:_-]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9:_-]+/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::IoT::Thing"
rest_api_document "/AWS::IoT::Thing"

rest_property_map({
  attribute_payload: "AttributePayload",
  thing_name:        "ThingName",
})

rest_post_only_properties %i{
  thing_name
}
