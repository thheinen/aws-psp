# Import API specifics
use "awscc_base"

resource_name :aws_events_endpoint
provides :aws_events_endpoint, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Events::Endpoint.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description must match pattern .*" => lambda { |v| v =~ Regexp.new("/.*/") },
         },
         description: ""

property :event_buses, Hash,
         required: true,
         callbacks: {
           "event_buses is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "name must match pattern ^[\.\-_A-Za-z0-9]+$" => lambda { |v| v =~ Regexp.new("/^[\.\-_A-Za-z0-9]+$/") },
         },
         description: ""

property :replication_config, Hash,
         description: ""

property :role_arn, String,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
           "role_arn needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "role_arn must match pattern ^arn:aws[a-z-]*:iam::\d{12}:role\/[\w+=,.@/-]+$" => lambda { |v| v =~ Regexp.new("/^arn:aws[a-z-]*:iam::\d{12}:role\/[\w+=,.@/-]+$/") },
         },
         description: ""

property :routing_config, Hash,
         required: true,
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Events::Endpoint"
rest_api_document "/AWS::Events::Endpoint"

rest_property_map({
  description:        "Description",
  event_buses:        "EventBuses",
  name:               "Name",
  replication_config: "ReplicationConfig",
  role_arn:           "RoleArn",
  routing_config:     "RoutingConfig",
})

rest_post_only_properties %i{
  name
}
