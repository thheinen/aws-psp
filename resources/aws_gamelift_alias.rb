# Import API specifics
use "awscc_base"

resource_name :aws_gamelift_alias
provides :aws_gamelift_alias, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::GameLift::Alias resource creates an alias for an Amazon GameLift (GameLift) fleet destination.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
         },
         description: "A human-readable description of the alias."

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
           "name must match pattern .*\S.*" => lambda { |v| v =~ Regexp.new("/.*\S.*/") },
         },
         description: "A descriptive label that is associated with an alias. Alias names do not need to be unique."

property :routing_strategy, Hash,
         required: true,
         callbacks: {
           "Subproperty `Message` is not a String" => lambda { |v| v[:Message].is_a? String },
           "Subproperty `FleetId` is not a String" => lambda { |v| v[:FleetId].is_a? String },
           "Subproperty `FleetId` must match pattern ^fleet-\S+" => lambda { |v| v[:FleetId] =~ Regexp.new("/^fleet-\S+/") },
           "Subproperty `Type` is not a String" => lambda { |v| v[:Type].is_a? String },
           "Subproperty `Type`is not one of `SIMPLE`, `TERMINAL`" => lambda { |v| %w{SIMPLE TERMINAL}.include? v[:Type] },
         },
         description: "A routing configuration that specifies where traffic is directed for this alias, such as to a fleet or to a message."

# API URLs and mappings
rest_api_collection "/AWS::GameLift::Alias"
rest_api_document "/AWS::GameLift::Alias"

rest_property_map({
  description:      "Description",
  name:             "Name",
  routing_strategy: "RoutingStrategy",
})

