# Import API specifics
use "awscc_base"

resource_name :aws_ses_configuration_set
provides :aws_ses_configuration_set, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::SES::ConfigurationSet.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :delivery_options, Hash,
         callbacks: {
           "Subproperty `TlsPolicy` is not a String" => lambda { |v| v[:TlsPolicy].is_a? String },
           "Subproperty `TlsPolicy` must match pattern REQUIRE|OPTIONAL" => lambda { |v| v[:TlsPolicy] =~ Regexp.new("/REQUIRE|OPTIONAL/") },
           "Subproperty `SendingPoolName` is not a String" => lambda { |v| v[:SendingPoolName].is_a? String },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name must match pattern ^[a-zA-Z0-9_-]{1,64}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_-]{1,64}$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the configuration set.
         DESCRIPTION

property :reputation_options, Hash,
         callbacks: {
           "Subproperty `ReputationMetricsEnabled` is not a Boolean" => lambda { |v| v[:ReputationMetricsEnabled].is_a? Boolean },
         },
         description: ""

property :sending_options, Hash,
         callbacks: {
           "Subproperty `SendingEnabled` is not a Boolean" => lambda { |v| v[:SendingEnabled].is_a? Boolean },
         },
         description: ""

property :suppression_options, Hash,
         callbacks: {
           "Subproperty `SuppressedReasons` is not a Array" => lambda { |v| v[:SuppressedReasons].is_a? Array },
         },
         description: ""

property :tracking_options, Hash,
         callbacks: {
           "Subproperty `CustomRedirectDomain` is not a String" => lambda { |v| v[:CustomRedirectDomain].is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::SES::ConfigurationSet"
rest_api_document "/AWS::SES::ConfigurationSet"

rest_property_map({
  delivery_options:    "DeliveryOptions",
  name:                "Name",
  reputation_options:  "ReputationOptions",
  sending_options:     "SendingOptions",
  suppression_options: "SuppressionOptions",
  tracking_options:    "TrackingOptions",
})

rest_post_only_properties %i{
  name
}
