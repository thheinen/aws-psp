# Import API specifics
use "awscc_base"

resource_name :aws_iot_dimension
provides :aws_iot_dimension, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  A dimension can be used to limit the scope of a metric used in a security profile for AWS IoT Device Defender.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "name must match pattern [a-zA-Z0-9:_-]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9:_-]+/") },
         },
         description: "A unique identifier for the dimension."

property :string_values, Array,
         required: true,
         callbacks: {
           "string_values is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "Specifies the value or list of values for the dimension."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "Metadata that can be used to manage the dimension."

property :type, String,
         required: true,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
           "typeis not one of `TOPIC_FILTER`" => lambda { |v| %w{TOPIC_FILTER}.include? v },
         },
         description: "Specifies the type of the dimension."

# API URLs and mappings
rest_api_collection "/AWS::IoT::Dimension"
rest_api_document "/AWS::IoT::Dimension"

rest_property_map({
  name:          "Name",
  string_values: "StringValues",
  tags:          "Tags",
  type:          "Type",
})

rest_post_only_properties %i{
  name type
}
