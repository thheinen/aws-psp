# Import API specifics
use "awscc_base"

resource_name :aws_customer_profiles_event_stream
provides :aws_customer_profiles_event_stream, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  An Event Stream resource of Amazon Connect Customer Profiles
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :domain_name, String,
         required: true,
         callbacks: {
           "domain_name is not a String" => lambda { |v| v.is_a? String },
           "domain_name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "domain_name must match pattern ^[a-zA-Z0-9_-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_-]+$/") },
         },
         description: <<~'DESCRIPTION'
           The unique name of the domain.
         DESCRIPTION

property :event_stream_name, String,
         required: true,
         callbacks: {
           "event_stream_name is not a String" => lambda { |v| v.is_a? String },
           "event_stream_name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "event_stream_name must match pattern ^[a-zA-Z0-9_-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_-]+$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the event stream.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags used to organize, track, or control access for this resource.
         DESCRIPTION

property :uri, Hash,
         required: true,
         callbacks: {
           "uri is not a String" => lambda { |v| v.is_a? String },
           "uri needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::CustomerProfiles::EventStream"
rest_api_document "/AWS::CustomerProfiles::EventStream"

rest_property_map({
  domain_name:       "DomainName",
  event_stream_name: "EventStreamName",
  tags:              "Tags",
  uri:               "Uri",
})

rest_post_only_properties %i{
  domain_name event_stream_name uri
}
