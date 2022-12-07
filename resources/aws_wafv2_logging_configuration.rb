# Import API specifics
use "awscc_base"

resource_name :aws_wafv2_logging_configuration
provides :aws_wafv2_logging_configuration, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  A WAFv2 Logging Configuration Resource Provider
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :log_destination_configs, Array,
         required: true,
         callbacks: {
           "log_destination_configs is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Names (ARNs) of the logging destinations that you want to associate with the web ACL.
         DESCRIPTION

property :logging_filter, Hash,
         callbacks: {
           "Subproperty `DefaultBehavior` is not a String" => lambda { |v| v[:DefaultBehavior].is_a? String },
           "Subproperty `DefaultBehavior`is not one of `KEEP`, `DROP`" => lambda { |v| %w{KEEP DROP}.include? v[:DefaultBehavior] },
           "Subproperty `Filters` is not a Array" => lambda { |v| v[:Filters].is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Filtering that specifies which web requests are kept in the logs and which are dropped. You can filter on the rule action and on the web request labels that were applied by matching rules during web ACL evaluation.
         DESCRIPTION

property :redacted_fields, Array,
         callbacks: {
           "redacted_fields is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The parts of the request that you want to keep out of the logs. For example, if you redact the HEADER field, the HEADER field in the firehose will be xxx.
         DESCRIPTION

property :resource_arn, String,
         required: true,
         callbacks: {
           "resource_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the web ACL that you want to associate with LogDestinationConfigs.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::WAFv2::LoggingConfiguration"
rest_api_document "/AWS::WAFv2::LoggingConfiguration"

rest_property_map({
  log_destination_configs: "LogDestinationConfigs",
  logging_filter:          "LoggingFilter",
  redacted_fields:         "RedactedFields",
  resource_arn:            "ResourceArn",
})

rest_post_only_properties %i{
  resource_arn
}
