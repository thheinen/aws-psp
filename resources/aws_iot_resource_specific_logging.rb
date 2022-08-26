# Import API specifics
use "awscc_base"

resource_name :aws_iot_resource_specific_logging
provides :aws_iot_resource_specific_logging, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource-specific logging allows you to specify a logging level for a specific thing group.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :log_level, String,
         required: true,
         callbacks: {
           "log_level is not a String" => lambda { |v| v.is_a? String },
           "log_levelis not one of `ERROR`, `WARN`, `INFO`, `DEBUG`, `DISABLED`" => lambda { |v| %w{ERROR WARN INFO DEBUG DISABLED}.include? v },
         },
         description: "The log level for a specific target. Valid values are: ERROR, WARN, INFO, DEBUG, or DISABLED."

property :target_name, String,
         required: true,
         callbacks: {
           "target_name is not a String" => lambda { |v| v.is_a? String },
           "target_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "target_name must match pattern [a-zA-Z0-9.:_-]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9.:_-]+/") },
         },
         description: "The target name."

property :target_type, String,
         required: true,
         callbacks: {
           "target_type is not a String" => lambda { |v| v.is_a? String },
           "target_typeis not one of `THING_GROUP`, `CLIENT_ID`, `SOURCE_IP`, `PRINCIPAL_ID`" => lambda { |v| %w{THING_GROUP CLIENT_ID SOURCE_IP PRINCIPAL_ID}.include? v },
         },
         description: "The target type. Value must be THING_GROUP, CLIENT_ID, SOURCE_IP, PRINCIPAL_ID."

# API URLs and mappings
rest_api_collection "/AWS::IoT::ResourceSpecificLogging"
rest_api_document "/AWS::IoT::ResourceSpecificLogging"

rest_property_map({
  log_level:   "LogLevel",
  target_name: "TargetName",
  target_type: "TargetType",
})

rest_post_only_properties %i{
  target_name target_type
}
