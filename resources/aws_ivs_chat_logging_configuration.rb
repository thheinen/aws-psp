# Import API specifics
use "awscc_base"

resource_name :aws_ivs_chat_logging_configuration
provides :aws_ivs_chat_logging_configuration, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource type definition for AWS::IVSChat::LoggingConfiguration.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :destination_configuration, Hash,
         required: true,
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 0..128 characters" => lambda { |v| v.length >= 0 && v.length <= 128 },
           "name must match pattern ^[a-zA-Z0-9-_]*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9-_]*$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the logging configuration. The value does not need to be unique.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IVSChat::LoggingConfiguration"
rest_api_document "/AWS::IVSChat::LoggingConfiguration"

rest_property_map({
  destination_configuration: "DestinationConfiguration",
  name:                      "Name",
  tags:                      "Tags",
})

