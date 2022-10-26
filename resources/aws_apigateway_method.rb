# Import API specifics
use "awscc_base"

resource_name :aws_apigateway_method
provides :aws_apigateway_method, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ApiGateway::Method
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :api_key_required, [TrueClass, FalseClass],
         callbacks: {
           "api_key_required is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Indicates whether the method requires clients to submit a valid API key.
         DESCRIPTION

property :authorization_scopes, Array,
         callbacks: {
           "authorization_scopes is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of authorization scopes configured on the method.
         DESCRIPTION

property :authorization_type, String,
         callbacks: {
           "authorization_type is not a String" => lambda { |v| v.is_a? String },
           "authorization_typeis not one of `NONE`, `AWS_IAM`, `CUSTOM`, `COGNITO_USER_POOLS`" => lambda { |v| %w{NONE AWS_IAM CUSTOM COGNITO_USER_POOLS}.include? v },
         },
         description: <<~'DESCRIPTION'
           The method's authorization type.
         DESCRIPTION

property :authorizer_id, String,
         callbacks: {
           "authorizer_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The identifier of the authorizer to use on this method.
         DESCRIPTION

property :http_method, String,
         required: true,
         callbacks: {
           "http_method is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The backend system that the method calls when it receives a request.
         DESCRIPTION

property :integration, Hash,
         callbacks: {
           "Subproperty `CacheKeyParameters` is not a Array" => lambda { |v| v[:CacheKeyParameters].is_a? Array },
           "Subproperty `CacheNamespace` is not a String" => lambda { |v| v[:CacheNamespace].is_a? String },
           "Subproperty `ConnectionId` is not a String" => lambda { |v| v[:ConnectionId].is_a? String },
           "Subproperty `ConnectionType` is not a String" => lambda { |v| v[:ConnectionType].is_a? String },
           "Subproperty `ConnectionType`is not one of `INTERNET`, `VPC_LINK`" => lambda { |v| %w{INTERNET VPC_LINK}.include? v[:ConnectionType] },
           "Subproperty `ContentHandling` is not a String" => lambda { |v| v[:ContentHandling].is_a? String },
           "Subproperty `ContentHandling`is not one of `CONVERT_TO_BINARY`, `CONVERT_TO_TEXT`" => lambda { |v| %w{CONVERT_TO_BINARY CONVERT_TO_TEXT}.include? v[:ContentHandling] },
           "Subproperty `Credentials` is not a String" => lambda { |v| v[:Credentials].is_a? String },
           "Subproperty `IntegrationHttpMethod` is not a String" => lambda { |v| v[:IntegrationHttpMethod].is_a? String },
           "Subproperty `IntegrationResponses` is not a Array" => lambda { |v| v[:IntegrationResponses].is_a? Array },
           "Subproperty `PassthroughBehavior` is not a String" => lambda { |v| v[:PassthroughBehavior].is_a? String },
           "Subproperty `PassthroughBehavior`is not one of `WHEN_NO_MATCH`, `WHEN_NO_TEMPLATES`, `NEVER`" => lambda { |v| %w{WHEN_NO_MATCH WHEN_NO_TEMPLATES NEVER}.include? v[:PassthroughBehavior] },
           "Subproperty `RequestParameters` is not a Object" => lambda { |v| v[:RequestParameters].is_a? Object },
           "Subproperty `RequestTemplates` is not a Object" => lambda { |v| v[:RequestTemplates].is_a? Object },
           "Subproperty `TimeoutInMillis` is not a Integer" => lambda { |v| v[:TimeoutInMillis].is_a? Integer },
           "Subproperty `Type` is not a String" => lambda { |v| v[:Type].is_a? String },
           "Subproperty `Type`is not one of `AWS`, `AWS_PROXY`, `HTTP`, `HTTP_PROXY`, `MOCK`" => lambda { |v| %w{AWS AWS_PROXY HTTP HTTP_PROXY MOCK}.include? v[:Type] },
           "Subproperty `Uri` is not a String" => lambda { |v| v[:Uri].is_a? String },
         },
         description: <<~'DESCRIPTION'
           The backend system that the method calls when it receives a request.
         DESCRIPTION

property :method_responses, Array,
         callbacks: {
           "method_responses is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The responses that can be sent to the client who calls the method.
         DESCRIPTION

property :operation_name, String,
         callbacks: {
           "operation_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A friendly operation name for the method.
         DESCRIPTION

property :request_models, Hash,
         callbacks: {
           "request_models is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           The resources that are used for the request's content type. Specify request models as key-value pairs (string-to-string mapping), with a content type as the key and a Model resource name as the value.
         DESCRIPTION

property :request_parameters, Hash,
         callbacks: {
           "request_parameters is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           The request parameters that API Gateway accepts. Specify request parameters as key-value pairs (string-to-Boolean mapping), with a source as the key and a Boolean as the value.
         DESCRIPTION

property :request_validator_id, String,
         callbacks: {
           "request_validator_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the associated request validator.
         DESCRIPTION

property :resource_id, String,
         required: true,
         callbacks: {
           "resource_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of an API Gateway resource.
         DESCRIPTION

property :rest_api_id, String,
         required: true,
         callbacks: {
           "rest_api_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the RestApi resource in which API Gateway creates the method.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ApiGateway::Method"
rest_api_document "/AWS::ApiGateway::Method"

rest_property_map({
  api_key_required:     "ApiKeyRequired",
  authorization_scopes: "AuthorizationScopes",
  authorization_type:   "AuthorizationType",
  authorizer_id:        "AuthorizerId",
  http_method:          "HttpMethod",
  integration:          "Integration",
  method_responses:     "MethodResponses",
  operation_name:       "OperationName",
  request_models:       "RequestModels",
  request_parameters:   "RequestParameters",
  request_validator_id: "RequestValidatorId",
  resource_id:          "ResourceId",
  rest_api_id:          "RestApiId",
})

rest_post_only_properties %i{
  http_method resource_id rest_api_id
}
