# Import API specifics
use "awscc_base"

resource_name :aws_game_cast_stream_group
provides :aws_game_cast_stream_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::GameCast::StreamGroup Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :default_application, Hash,
         callbacks: {
           "Subproperty `Id` is not a String" => lambda { |v| v[:Id].is_a? String },
           "Subproperty `Id` needs to be 1..32 characters" => lambda { |v| v[:Id].length >= 1 && v[:Id].length <= 32 },
           "Subproperty `Id` must match pattern ^[a-zA-Z0-9-]+$" => lambda { |v| v[:Id] =~ Regexp.new("/^[a-zA-Z0-9-]+$/") },
         },
         description: ""

property :description, String,
         required: true,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
           "description must match pattern ^[a-zA-Z0-9-_\s]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9-_\s]+$/") },
         },
         description: <<~'DESCRIPTION'
           Descriptive label for the resource, not a unique ID.
         DESCRIPTION

property :desired_capacity, Integer,
         callbacks: {
           "desired_capacity is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           DesiredCapacity is the target number of stream sessions customer sets.
         DESCRIPTION

property :stream_class, Hash,
         callbacks: {
           "stream_class is not a String" => lambda { |v| v.is_a? String },
           "stream_classis not one of `HIGH`, `ULTRA`, `gen4a_high`, `gen4a_ultra`" => lambda { |v| %w{HIGH ULTRA gen4a_high gen4a_ultra}.include? v },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::GameCast::StreamGroup"
rest_api_document "/AWS::GameCast::StreamGroup"

rest_property_map({
  default_application: "DefaultApplication",
  description:         "Description",
  desired_capacity:    "DesiredCapacity",
  stream_class:        "StreamClass",
  tags:                "Tags",
})

rest_post_only_properties %i{
  default_application/id stream_class
}
