# Import API specifics
use "awscc_base"

resource_name :aws_iot_custom_metric
provides :aws_iot_custom_metric, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  A custom metric published by your devices to Device Defender.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :display_name, String,
         callbacks: {
           "display_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Field represents a friendly name in the console for the custom metric; it doesn't have to be unique. Don't use this name as the metric identifier in the device metric report. Can be updated once defined.
         DESCRIPTION

property :metric_name, String,
         callbacks: {
           "metric_name is not a String" => lambda { |v| v.is_a? String },
           "metric_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "metric_name must match pattern [a-zA-Z0-9:_-]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9:_-]+/") },
         },
         description: <<~'DESCRIPTION'
           The name of the custom metric. This will be used in the metric report submitted from the device/thing. Shouldn't begin with aws: . Cannot be updated once defined.
         DESCRIPTION

property :metric_type, String,
         required: true,
         callbacks: {
           "metric_type is not a String" => lambda { |v| v.is_a? String },
           "metric_typeis not one of `string-list`, `ip-address-list`, `number-list`, `number`" => lambda { |v| %w{string-list ip-address-list number-list number}.include? v },
         },
         description: <<~'DESCRIPTION'
           The type of the custom metric. Types include string-list, ip-address-list, number-list, and number.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IoT::CustomMetric"
rest_api_document "/AWS::IoT::CustomMetric"

rest_property_map({
  display_name: "DisplayName",
  metric_name:  "MetricName",
  metric_type:  "MetricType",
  tags:         "Tags",
})

rest_post_only_properties %i{
  metric_name metric_type
}
