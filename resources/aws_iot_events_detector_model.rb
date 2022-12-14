# Import API specifics
use "awscc_base"

resource_name :aws_iot_events_detector_model
provides :aws_iot_events_detector_model, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::IoTEvents::DetectorModel resource creates a detector model. You create a *detector model* (a model of your equipment or process) using *states*. For each state, you define conditional (Boolean) logic that evaluates the incoming inputs to detect significant events. When an event is detected, it can change the state or trigger custom-built or predefined actions using other AWS services. You can define additional events that trigger actions when entering or exiting a state and, optionally, when a condition is met. For more information, see [How to Use AWS IoT Events](https://docs.aws.amazon.com/iotevents/latest/developerguide/how-to-use-iotevents.html) in the *AWS IoT Events Developer Guide*.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :detector_model_definition, Hash,
         required: true,
         callbacks: {
           "Subproperty `InitialStateName` is not a String" => lambda { |v| v[:InitialStateName].is_a? String },
           "Subproperty `InitialStateName` needs to be 1..128 characters" => lambda { |v| v[:InitialStateName].length >= 1 && v[:InitialStateName].length <= 128 },
           "Subproperty `States` is not a Array" => lambda { |v| v[:States].is_a? Array },
         },
         description: ""

property :detector_model_description, String,
         callbacks: {
           "detector_model_description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A brief description of the detector model.
         DESCRIPTION

property :detector_model_name, String,
         callbacks: {
           "detector_model_name is not a String" => lambda { |v| v.is_a? String },
           "detector_model_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "detector_model_name must match pattern ^[a-zA-Z0-9_-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_-]+$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the detector model.
         DESCRIPTION

property :evaluation_method, String,
         callbacks: {
           "evaluation_method is not a String" => lambda { |v| v.is_a? String },
           "evaluation_methodis not one of `BATCH`, `SERIAL`" => lambda { |v| %w{BATCH SERIAL}.include? v },
         },
         description: <<~'DESCRIPTION'
           Information about the order in which events are evaluated and how actions are executed.
         DESCRIPTION

property :key, String,
         callbacks: {
           "key is not a String" => lambda { |v| v.is_a? String },
           "key needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "key must match pattern ^((`[\w\- ]+`)|([\w\-]+))(\.((`[\w\- ]+`)|([\w\-]+)))*$" => lambda { |v| v =~ Regexp.new("/^((`[\w\- ]+`)|([\w\-]+))(\.((`[\w\- ]+`)|([\w\-]+)))*$/") },
         },
         description: <<~'DESCRIPTION'
           The value used to identify a detector instance. When a device or system sends input, a new detector instance with a unique key value is created. AWS IoT Events can continue to route input to its corresponding detector instance based on this identifying information.
            This parameter uses a JSON-path expression to select the attribute-value pair in the message payload that is used for identification. To route the message to the correct detector instance, the device must send a message payload that contains the same attribute-value.
         DESCRIPTION

property :role_arn, String,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
           "role_arn needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
         },
         description: <<~'DESCRIPTION'
           The ARN of the role that grants permission to AWS IoT Events to perform its operations.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
            For more information, see [Tag](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-resource-tags.html).
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IoTEvents::DetectorModel"
rest_api_document "/AWS::IoTEvents::DetectorModel"

rest_property_map({
  detector_model_definition:  "DetectorModelDefinition",
  detector_model_description: "DetectorModelDescription",
  detector_model_name:        "DetectorModelName",
  evaluation_method:          "EvaluationMethod",
  key:                        "Key",
  role_arn:                   "RoleArn",
  tags:                       "Tags",
})

rest_post_only_properties %i{
  detector_model_name key
}
