# Import API specifics
use "awscc_base"

resource_name :aws_cloudtrail_channel
provides :aws_cloudtrail_channel, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  A channel receives events from a specific source (such as an on-premises storage solution or application, or a partner event data source), and delivers the events to one or more event data stores. You use channels to ingest events into CloudTrail from sources outside AWS.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :destinations, Array,
         callbacks: {
           "destinations is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           One or more resources to which events arriving through a channel are logged and stored.
         DESCRIPTION

property :name, Hash,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 3..128 characters" => lambda { |v| v.length >= 3 && v.length <= 128 },
           "name must match pattern (^[a-zA-Z0-9._\-]+$)" => lambda { |v| v =~ Regexp.new("/(^[a-zA-Z0-9._\-]+$)/") },
         },
         description: ""

property :source, String,
         callbacks: {
           "source is not a String" => lambda { |v| v.is_a? String },
           "source needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "source must match pattern (.*)" => lambda { |v| v =~ Regexp.new("/(.*)/") },
         },
         description: <<~'DESCRIPTION'
           The ARN of an on-premises storage solution or application, or a partner event source.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::CloudTrail::Channel"
rest_api_document "/AWS::CloudTrail::Channel"

rest_property_map({
  destinations: "Destinations",
  name:         "Name",
  source:       "Source",
  tags:         "Tags",
})

rest_post_only_properties %i{
  source
}
