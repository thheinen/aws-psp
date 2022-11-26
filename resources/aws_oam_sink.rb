# Import API specifics
use "awscc_base"

resource_name :aws_oam_sink
provides :aws_oam_sink, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Oam::Sink
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "name must match pattern ^[a-zA-Z0-9_.-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_.-]+$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the ObservabilityAccessManager Sink.
         DESCRIPTION

property :policy, Hash,
         callbacks: {
           "policy is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           The policy of this ObservabilityAccessManager Sink.
         DESCRIPTION

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           Tags to apply to the sink
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Oam::Sink"
rest_api_document "/AWS::Oam::Sink"

rest_property_map({
  name:   "Name",
  policy: "Policy",
  tags:   "Tags",
})

rest_post_only_properties %i{
  name
}
