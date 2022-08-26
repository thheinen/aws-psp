# Import API specifics
use "awscc_base"

resource_name :aws_iot_events_input
provides :aws_iot_events_input, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::IoTEvents::Input resource creates an input. To monitor your devices and processes, they must have a way to get telemetry data into AWS IoT Events. This is done by sending messages as *inputs* to AWS IoT Events. For more information, see [How to Use AWS IoT Events](https://docs.aws.amazon.com/iotevents/latest/developerguide/how-to-use-iotevents.html) in the *AWS IoT Events Developer Guide*.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :input_definition, Hash,
         required: true,
         callbacks: {
           "Subproperty `Attributes` is not a Array" => lambda { |v| v[:Attributes].is_a? Array },
         },
         description: ""

property :input_description, String,
         callbacks: {
           "input_description is not a String" => lambda { |v| v.is_a? String },
           "input_description needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
         },
         description: "A brief description of the input."

property :input_name, String,
         callbacks: {
           "input_name is not a String" => lambda { |v| v.is_a? String },
           "input_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "input_name must match pattern ^[a-zA-Z][a-zA-Z0-9_]*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z][a-zA-Z0-9_]*$/") },
         },
         description: "The name of the input."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
            For more information, see [Tag](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-resource-tags.html).
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IoTEvents::Input"
rest_api_document "/AWS::IoTEvents::Input"

rest_property_map({
  input_definition:  "InputDefinition",
  input_description: "InputDescription",
  input_name:        "InputName",
  tags:              "Tags",
})

rest_post_only_properties %i{
  input_name
}
