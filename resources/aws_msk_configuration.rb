# Import API specifics
use "awscc_base"

resource_name :aws_msk_configuration
provides :aws_msk_configuration, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::MSK::Configuration
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :kafka_versions_list, Hash,
         callbacks: {
           "kafka_versions_list is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :server_properties, String,
         required: true,
         callbacks: {
           "server_properties is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::MSK::Configuration"
rest_api_document "/AWS::MSK::Configuration"

rest_property_map({
  description:         "Description",
  kafka_versions_list: "KafkaVersionsList",
  name:                "Name",
  server_properties:   "ServerProperties",
})

rest_post_only_properties %i{
  kafka_versions_list name
}
