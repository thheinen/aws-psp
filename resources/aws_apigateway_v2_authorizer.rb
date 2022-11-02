# Import API specifics
use "awscc_base"

resource_name :aws_apigateway_v2_authorizer
provides :aws_apigateway_v2_authorizer, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ApiGatewayV2::Authorizer
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

property :authorizer_credentials_arn, String,
         callbacks: {
           "authorizer_credentials_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :authorizer_payload_format_version, String,
         callbacks: {
           "authorizer_payload_format_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :authorizer_result_ttl_in_seconds, Integer,
         callbacks: {
           "authorizer_result_ttl_in_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :authorizer_type, String,
         required: true,
         callbacks: {
           "authorizer_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :authorizer_uri, String,
         callbacks: {
           "authorizer_uri is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :enable_simple_responses, [TrueClass, FalseClass],
         callbacks: {
           "enable_simple_responses is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :identity_source, Array,
         callbacks: {
           "identity_source is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :identity_validation_expression, String,
         callbacks: {
           "identity_validation_expression is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :jwt_configuration, Hash,
         callbacks: {
           "Subproperty `Issuer` is not a String" => lambda { |v| v[:Issuer].is_a? String },
           "Subproperty `Audience` is not a Array" => lambda { |v| v[:Audience].is_a? Array },
         },
         description: ""

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::ApiGatewayV2::Authorizer"
rest_api_document "/AWS::ApiGatewayV2::Authorizer"

rest_property_map({
  api_id:                            "ApiId",
  authorizer_credentials_arn:        "AuthorizerCredentialsArn",
  authorizer_payload_format_version: "AuthorizerPayloadFormatVersion",
  authorizer_result_ttl_in_seconds:  "AuthorizerResultTtlInSeconds",
  authorizer_type:                   "AuthorizerType",
  authorizer_uri:                    "AuthorizerUri",
  enable_simple_responses:           "EnableSimpleResponses",
  identity_source:                   "IdentitySource",
  identity_validation_expression:    "IdentityValidationExpression",
  jwt_configuration:                 "JwtConfiguration",
  name:                              "Name",
})

rest_post_only_properties %i{
  api_id
}
