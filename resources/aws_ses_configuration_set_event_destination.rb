# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_ses_configuration_set_event_destination
provides :aws_ses_configuration_set_event_destination, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SES::ConfigurationSetEventDestination
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :configuration_set_name, String,
         required: true,
         callbacks: {
           "configuration_set_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the configuration set that contains the event destination.
         DESCRIPTION

property :event_destination, Hash,
         required: true,
         callbacks: {
           "Subproperty `Name` is not a String" => lambda { |v| v[:Name].is_a? String },
           "Subproperty `Name` must match pattern ^[a-zA-Z0-9_-]{0,64}$" => lambda { |v| v[:Name] =~ Regexp.new("/^[a-zA-Z0-9_-]{0,64}$/") },
           "Subproperty `Enabled` is not a Boolean" => lambda { |v| v[:Enabled].is_a? Boolean },
           "Subproperty `MatchingEventTypes` is not a Array" => lambda { |v| v[:MatchingEventTypes].is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The event destination object.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SES::ConfigurationSetEventDestination"
rest_api_document "/AWS::SES::ConfigurationSetEventDestination"

rest_property_map({
  configuration_set_name: "ConfigurationSetName",
  event_destination:      "EventDestination",
})

rest_post_only_properties %i{
  configuration_set_name
}
