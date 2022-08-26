# Import API specifics
use "awscc_base"

resource_name :aws_apigateway_authorizer
provides :aws_apigateway_authorizer, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Represents an authorization layer for methods. If enabled on a method, API Gateway will activate the authorizer when a client calls the method.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :auth_type, String,
         callbacks: {
           "auth_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: "Optional customer-defined field, used in OpenAPI imports and exports without functional impact."

property :authorizer_credentials, String,
         callbacks: {
           "authorizer_credentials is not a String" => lambda { |v| v.is_a? String },
         },
         description: "Specifies the required credentials as an IAM role for API Gateway to invoke the authorizer."

property :authorizer_result_ttl_in_seconds, Integer,
         callbacks: {
           "authorizer_result_ttl_in_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "The TTL in seconds of cached authorizer results."

property :authorizer_uri, String,
         callbacks: {
           "authorizer_uri is not a String" => lambda { |v| v.is_a? String },
         },
         description: "Specifies the authorizer's Uniform Resource Identifier (URI)."

property :identity_source, String,
         callbacks: {
           "identity_source is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The identity source for which authorization is requested."

property :identity_validation_expression, String,
         callbacks: {
           "identity_validation_expression is not a String" => lambda { |v| v.is_a? String },
         },
         description: "A validation expression for the incoming identity token."

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The name of the authorizer."

property :provider_ar_ns, Array,
         callbacks: {
           "provider_ar_ns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "A list of the Amazon Cognito user pool ARNs for the COGNITO_USER_POOLS authorizer."

property :rest_api_id, String,
         required: true,
         callbacks: {
           "rest_api_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The identifier of the API."

property :type, String,
         required: true,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The authorizer type."

# API URLs and mappings
rest_api_collection "/AWS::ApiGateway::Authorizer"
rest_api_document "/AWS::ApiGateway::Authorizer"

rest_property_map({
  auth_type:                        "AuthType",
  authorizer_credentials:           "AuthorizerCredentials",
  authorizer_result_ttl_in_seconds: "AuthorizerResultTtlInSeconds",
  authorizer_uri:                   "AuthorizerUri",
  identity_source:                  "IdentitySource",
  identity_validation_expression:   "IdentityValidationExpression",
  name:                             "Name",
  provider_ar_ns:                   "ProviderARNs",
  rest_api_id:                      "RestApiId",
  type:                             "Type",
})

rest_post_only_properties %i{
  rest_api_id
}
