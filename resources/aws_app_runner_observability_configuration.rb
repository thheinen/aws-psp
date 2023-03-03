# Import API specifics
use "awscc_base"

resource_name :aws_app_runner_observability_configuration
provides :aws_app_runner_observability_configuration, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::AppRunner::ObservabilityConfiguration resource  is an AWS App Runner resource type that specifies an App Runner observability configuration
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :observability_configuration_name, String,
         callbacks: {
           "observability_configuration_name is not a String" => lambda { |v| v.is_a? String },
           "observability_configuration_name needs to be 4..32 characters" => lambda { |v| v.length >= 4 && v.length <= 32 },
           "observability_configuration_name must match pattern [A-Za-z0-9][A-Za-z0-9\-_]{3,31}" => lambda { |v| v =~ Regexp.new("/[A-Za-z0-9][A-Za-z0-9\-_]{3,31}/") },
         },
         description: <<~'DESCRIPTION'
           A name for the observability configuration. When you use it for the first time in an AWS Region, App Runner creates revision number 1 of this name. When you use the same name in subsequent calls, App Runner creates incremental revisions of the configuration.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of metadata items that you can associate with your observability configuration resource. A tag is a key-value pair.
         DESCRIPTION

property :trace_configuration, Hash,
         callbacks: {
           "Subproperty `Vendor` is not a String" => lambda { |v| v[:Vendor].is_a? String },
           "Subproperty `Vendor`is not one of `AWSXRAY`" => lambda { |v| %w{AWSXRAY}.include? v[:Vendor] },
         },
         description: <<~'DESCRIPTION'
           The configuration of the tracing feature within this observability configuration. If you don't specify it, App Runner doesn't enable tracing.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::AppRunner::ObservabilityConfiguration"
rest_api_document "/AWS::AppRunner::ObservabilityConfiguration"

rest_property_map({
  observability_configuration_name: "ObservabilityConfigurationName",
  tags:                             "Tags",
  trace_configuration:              "TraceConfiguration",
})

rest_post_only_properties %i{
  observability_configuration_name tags trace_configuration
}
