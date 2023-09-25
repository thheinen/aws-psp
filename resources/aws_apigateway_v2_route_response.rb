# Import API specifics
use "awscc_base"

resource_name :aws_apigateway_v2_route_response
provides :aws_apigateway_v2_route_response, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The ``AWS::ApiGatewayV2::RouteResponse`` resource creates a route response for a WebSocket API. For more information, see [Set up Route Responses for a WebSocket API in API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api-route-response.html) in the *API Gateway Developer Guide*.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :api_id, String,
         required: true,
         callbacks: {
           "api_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The API identifier.
         DESCRIPTION

property :model_selection_expression, String,
         callbacks: {
           "model_selection_expression is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The model selection expression for the route response. Supported only for WebSocket APIs.
         DESCRIPTION

property :response_models, Hash,
         callbacks: {
           "response_models is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           The response models for the route response.
         DESCRIPTION

property :response_parameters, Hash,
         description: <<~'DESCRIPTION'
           The route response parameters.
         DESCRIPTION

property :route_id, String,
         required: true,
         callbacks: {
           "route_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The route ID.
         DESCRIPTION

property :route_response_key, String,
         required: true,
         callbacks: {
           "route_response_key is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The route response key.
         DESCRIPTION

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
