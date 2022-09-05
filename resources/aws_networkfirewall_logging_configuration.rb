# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_networkfirewall_logging_configuration
provides :aws_networkfirewall_logging_configuration, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource type definition for AWS::NetworkFirewall::LoggingConfiguration
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :firewall_arn, Hash,
         required: true,
         callbacks: {
           "firewall_arn is not a String" => lambda { |v| v.is_a? String },
           "firewall_arn needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "firewall_arn must match pattern ^arn:aws.*$" => lambda { |v| v =~ Regexp.new("/^arn:aws.*$/") },
         },
         description: ""

property :firewall_name, String,
         callbacks: {
           "firewall_name is not a String" => lambda { |v| v.is_a? String },
           "firewall_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "firewall_name must match pattern ^[a-zA-Z0-9-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9-]+$/") },
         },
         description: ""

property :logging_configuration, Hash,
         required: true,
         callbacks: {
           "Subproperty `LogDestinationConfigs` is not a Array" => lambda { |v| v[:LogDestinationConfigs].is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::NetworkFirewall::LoggingConfiguration"
rest_api_document "/AWS::NetworkFirewall::LoggingConfiguration"

rest_property_map({
  firewall_arn:          "FirewallArn",
  firewall_name:         "FirewallName",
  logging_configuration: "LoggingConfiguration",
})

rest_post_only_properties %i{
  firewall_arn firewall_name
}
