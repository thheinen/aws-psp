# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_location_tracker_consumer
provides :aws_location_tracker_consumer, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::Location::TrackerConsumer Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :consumer_arn, String,
         required: true,
         callbacks: {
           "consumer_arn is not a String" => lambda { |v| v.is_a? String },
           "consumer_arn must match pattern ^arn(:[a-z0-9]+([.-][a-z0-9]+)*){2}(:([a-z0-9]+([.-][a-z0-9]+)*)?){2}:([^/].*)?$" => lambda { |v| v =~ Regexp.new("/^arn(:[a-z0-9]+([.-][a-z0-9]+)*){2}(:([a-z0-9]+([.-][a-z0-9]+)*)?){2}:([^/].*)?$/") },
         },
         description: ""

property :tracker_name, String,
         required: true,
         callbacks: {
           "tracker_name is not a String" => lambda { |v| v.is_a? String },
           "tracker_name needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "tracker_name must match pattern ^[-._\w]+$" => lambda { |v| v =~ Regexp.new("/^[-._\w]+$/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Location::TrackerConsumer"
rest_api_document "/AWS::Location::TrackerConsumer"

rest_property_map({
  consumer_arn: "ConsumerArn",
  tracker_name: "TrackerName",
})

rest_post_only_properties %i{
  consumer_arn tracker_name
}
