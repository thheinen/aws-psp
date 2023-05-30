# Import API specifics
use "awscc_base"

resource_name :aws_apigateway_v2_route_response
provides :aws_apigateway_v2_route_response, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ApiGatewayV2::RouteResponse
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :api_id, String,
         required: true,
         callbacks: {
           "api_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :model_selection_expression, String,
         callbacks: {
           "model_selection_expression is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :response_models, Hash,
         callbacks: {
           "response_models is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :response_parameters, Hash,
         description: ""

property :route_id, String,
         required: true,
         callbacks: {
           "route_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :route_response_key, String,
         required: true,
         callbacks: {
           "route_response_key is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::ApiGatewayV2::RouteResponse"
rest_api_document "/AWS::ApiGatewayV2::RouteResponse"

rest_property_map({
  api_id:                     "ApiId",
  model_selection_expression: "ModelSelectionExpression",
  response_models:            "ResponseModels",
  response_parameters:        "ResponseParameters",
  route_id:                   "RouteId",
  route_response_key:         "RouteResponseKey",
})

rest_post_only_properties %i{
  api_id route_id
}
