# Import API specifics
use "awscc_base"

resource_name :aws_apigateway_usage_plan
provides :aws_apigateway_usage_plan, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ApiGateway::UsagePlan
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :api_stages, Array,
         callbacks: {
           "api_stages is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The API stages to associate with this usage plan.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A description of the usage plan.
         DESCRIPTION

property :quota, Hash,
         callbacks: {
           "Subproperty `Limit` is not a Integer" => lambda { |v| v[:Limit].is_a? Integer },
           "Subproperty `Offset` is not a Integer" => lambda { |v| v[:Offset].is_a? Integer },
           "Subproperty `Period` is not a String" => lambda { |v| v[:Period].is_a? String },
         },
         description: <<~'DESCRIPTION'
           Configures the number of requests that users can make within a given interval.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of arbitrary tags (key-value pairs) to associate with the usage plan.
         DESCRIPTION

property :throttle, Hash,
         callbacks: {
           "Subproperty `BurstLimit` is not a Integer" => lambda { |v| v[:BurstLimit].is_a? Integer },
           "Subproperty `RateLimit` is not a Number" => lambda { |v| v[:RateLimit].is_a? Number },
         },
         description: <<~'DESCRIPTION'
           Configures the overall request rate (average requests per second) and burst capacity.
         DESCRIPTION

property :usage_plan_name, String,
         callbacks: {
           "usage_plan_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A name for the usage plan.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ApiGateway::UsagePlan"
rest_api_document "/AWS::ApiGateway::UsagePlan"

rest_property_map({
  api_stages:      "ApiStages",
  description:     "Description",
  quota:           "Quota",
  tags:            "Tags",
  throttle:        "Throttle",
  usage_plan_name: "UsagePlanName",
})

