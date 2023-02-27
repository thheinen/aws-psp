# Import API specifics
use "awscc_base"

resource_name :aws_ivs_chat_room
provides :aws_ivs_chat_room, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource type definition for AWS::IVSChat::Room.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :logging_configuration_identifiers, Array,
         callbacks: {
           "logging_configuration_identifiers is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Array of logging configuration identifiers attached to the room.
         DESCRIPTION

property :maximum_message_length, Integer,
         callbacks: {
           "maximum_message_length is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The maximum number of characters in a single message.
         DESCRIPTION

property :maximum_message_rate_per_second, Integer,
         callbacks: {
           "maximum_message_rate_per_second is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The maximum number of messages per second that can be sent to the room.
         DESCRIPTION

property :message_review_handler, Hash,
         callbacks: {
           "Subproperty `FallbackResult` is not a String" => lambda { |v| v[:FallbackResult].is_a? String },
           "Subproperty `FallbackResult`is not one of `ALLOW`, `DENY`" => lambda { |v| %w{ALLOW DENY}.include? v[:FallbackResult] },
           "Subproperty `Uri` is not a String" => lambda { |v| v[:Uri].is_a? String },
           "Subproperty `Uri` needs to be 0..170 characters" => lambda { |v| v[:Uri].length >= 0 && v[:Uri].length <= 170 },
           "Subproperty `Uri` must match pattern ^$|^arn:aws:lambda:[a-z0-9-]+:[0-9]{12}:function:.+" => lambda { |v| v[:Uri] =~ Regexp.new("/^$|^arn:aws:lambda:[a-z0-9-]+:[0-9]{12}:function:.+/") },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 0..128 characters" => lambda { |v| v.length >= 0 && v.length <= 128 },
           "name must match pattern ^[a-zA-Z0-9-_]*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9-_]*$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the room. The value does not need to be unique.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IVSChat::Room"
rest_api_document "/AWS::IVSChat::Room"

rest_property_map({
  logging_configuration_identifiers: "LoggingConfigurationIdentifiers",
  maximum_message_length:            "MaximumMessageLength",
  maximum_message_rate_per_second:   "MaximumMessageRatePerSecond",
  message_review_handler:            "MessageReviewHandler",
  name:                              "Name",
  tags:                              "Tags",
})

