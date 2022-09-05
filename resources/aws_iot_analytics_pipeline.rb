# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_iot_analytics_pipeline
provides :aws_iot_analytics_pipeline, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::IoTAnalytics::Pipeline
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :pipeline_activities, Array,
         required: true,
         callbacks: {
           "pipeline_activities is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :pipeline_name, String,
         callbacks: {
           "pipeline_name is not a String" => lambda { |v| v.is_a? String },
           "pipeline_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "pipeline_name must match pattern [a-zA-Z0-9_]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9_]+/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::IoTAnalytics::Pipeline"
rest_api_document "/AWS::IoTAnalytics::Pipeline"

rest_property_map({
  pipeline_activities: "PipelineActivities",
  pipeline_name:       "PipelineName",
  tags:                "Tags",
})

rest_post_only_properties %i{
  pipeline_name
}
