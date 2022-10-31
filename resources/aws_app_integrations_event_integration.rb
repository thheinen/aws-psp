# Import API specifics
use "awscc_base"

resource_name :aws_app_integrations_event_integration
provides :aws_app_integrations_event_integration, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::AppIntegrations::EventIntegration
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..1000 characters" => lambda { |v| v.length >= 1 && v.length <= 1000 },
         },
         description: <<~'DESCRIPTION'
           The event integration description.
         DESCRIPTION

property :event_bridge_bus, String,
         required: true,
         callbacks: {
           "event_bridge_bus is not a String" => lambda { |v| v.is_a? String },
           "event_bridge_bus needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "event_bridge_bus must match pattern ^[a-zA-Z0-9/\._\-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9/\._\-]+$/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Eventbridge bus for the event integration.
         DESCRIPTION

property :event_filter, Hash,
         required: true,
         callbacks: {
           "Subproperty `Source` is not a String" => lambda { |v| v[:Source].is_a? String },
           "Subproperty `Source` needs to be 1..256 characters" => lambda { |v| v[:Source].length >= 1 && v[:Source].length <= 256 },
           "Subproperty `Source` must match pattern ^aws\.partner\/.*$" => lambda { |v| v[:Source] =~ Regexp.new("/^aws\.partner\/.*$/") },
         },
         description: <<~'DESCRIPTION'
           The EventFilter (source) associated with the event integration.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "name must match pattern ^[a-zA-Z0-9/\._\-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9/\._\-]+$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the event integration.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags (keys and values) associated with the event integration.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::AppIntegrations::EventIntegration"
rest_api_document "/AWS::AppIntegrations::EventIntegration"

rest_property_map({
  description:      "Description",
  event_bridge_bus: "EventBridgeBus",
  event_filter:     "EventFilter",
  name:             "Name",
  tags:             "Tags",
})

rest_post_only_properties %i{
  event_bridge_bus event_filter name
}
