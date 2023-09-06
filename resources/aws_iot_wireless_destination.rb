# Import API specifics
use "awscc_base"

resource_name :aws_iot_wireless_destination
provides :aws_iot_wireless_destination, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Destination's resource schema demonstrating some basic constructs and validation rules.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Destination description
         DESCRIPTION

property :expression, String,
         required: true,
         callbacks: {
           "expression is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Destination expression
         DESCRIPTION

property :expression_type, String,
         required: true,
         callbacks: {
           "expression_type is not a String" => lambda { |v| v.is_a? String },
           "expression_typeis not one of `RuleName`, `MqttTopic`, `SnsTopic`" => lambda { |v| %w{RuleName MqttTopic SnsTopic}.include? v },
         },
         description: <<~'DESCRIPTION'
           Must be RuleName
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name must match pattern [a-zA-Z0-9:_-]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9:_-]+/") },
         },
         description: <<~'DESCRIPTION'
           Unique name of destination
         DESCRIPTION

property :role_arn, String,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
           "role_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
         },
         description: <<~'DESCRIPTION'
           AWS role ARN that grants access
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of key-value pairs that contain metadata for the destination.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IoTWireless::Destination"
rest_api_document "/AWS::IoTWireless::Destination"

rest_property_map({
  description:     "Description",
  expression:      "Expression",
  expression_type: "ExpressionType",
  name:            "Name",
  role_arn:        "RoleArn",
  tags:            "Tags",
})

rest_post_only_properties %i{
  name
}
