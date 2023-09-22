# Import API specifics
use "awscc_base"

resource_name :aws_events_event_bus
provides :aws_events_event_bus, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource type definition for AWS::Events::EventBus
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :event_source_name, String,
         callbacks: {
           "event_source_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           If you are creating a partner event bus, this specifies the partner event source that the new event bus will be matched with.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the event bus.
         DESCRIPTION

property :policy, [Hash, String],
         description: <<~'DESCRIPTION'
           A JSON string that describes the permission policy statement for the event bus.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Any tags assigned to the event bus.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Events::EventBus"
rest_api_document "/AWS::Events::EventBus"

rest_property_map({
  event_source_name: "EventSourceName",
  name:              "Name",
  policy:            "Policy",
  tags:              "Tags",
})

rest_post_only_properties %i{
  name
}
