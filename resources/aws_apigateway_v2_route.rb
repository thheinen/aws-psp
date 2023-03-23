# Import API specifics
use "awscc_base"

resource_name :aws_apigateway_v2_route
provides :aws_apigateway_v2_route, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ApiGatewayV2::Route
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

property :api_key_required, [TrueClass, FalseClass],
         callbacks: {
           "api_key_required is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :authorization_scopes, Array,
         callbacks: {
           "authorization_scopes is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :authorization_type, String,
         callbacks: {
           "authorization_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :authorizer_id, String,
         callbacks: {
           "authorizer_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :model_selection_expression, String,
         callbacks: {
           "model_selection_expression is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :operation_name, String,
         callbacks: {
           "operation_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :request_models, Hash,
         callbacks: {
           "request_models is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :request_parameters, Hash,
         callbacks: {
           "request_parameters is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :route_key, String,
         required: true,
         callbacks: {
           "route_key is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :route_response_selection_expression, String,
         callbacks: {
           "route_response_selection_expression is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :target, String,
         callbacks: {
           "target is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::ApiGatewayV2::Route"
rest_api_document "/AWS::ApiGatewayV2::Route"

rest_property_map({
  api_id:                              "ApiId",
  api_key_required:                    "ApiKeyRequired",
  authorization_scopes:                "AuthorizationScopes",
  authorization_type:                  "AuthorizationType",
  authorizer_id:                       "AuthorizerId",
  model_selection_expression:          "ModelSelectionExpression",
  operation_name:                      "OperationName",
  request_models:                      "RequestModels",
  request_parameters:                  "RequestParameters",
  route_key:                           "RouteKey",
  route_response_selection_expression: "RouteResponseSelectionExpression",
  target:                              "Target",
})

rest_post_only_properties %i{
  api_id
}
