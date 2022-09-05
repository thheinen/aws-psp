# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_cloudfront_realtime_log_config
provides :aws_cloudfront_realtime_log_config, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::CloudFront::RealtimeLogConfig
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :end_points, Array,
         required: true,
         callbacks: {
           "end_points is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :fields, Array,
         required: true,
         callbacks: {
           "fields is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :sampling_rate, Number,
         required: true,
         callbacks: {
           "sampling_rate is not a Number" => lambda { |v| v.is_a? Number },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::CloudFront::RealtimeLogConfig"
rest_api_document "/AWS::CloudFront::RealtimeLogConfig"

rest_property_map({
  end_points:    "EndPoints",
  fields:        "Fields",
  name:          "Name",
  sampling_rate: "SamplingRate",
})

rest_post_only_properties %i{
  name
}
