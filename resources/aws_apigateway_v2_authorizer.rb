# Import API specifics
use "awscc_base"

resource_name :aws_apigateway_v2_authorizer
provides :aws_apigateway_v2_authorizer, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The ``AWS::ApiGatewayV2::Authorizer`` resource creates an authorizer for a WebSocket API or an HTTP API. To learn more, see [Controlling and managing access to a WebSocket API in API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api-control-access.html) and [Controlling and managing access to an HTTP API in API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-access-control.html) in the *API Gateway Developer Guide*.
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

property :authorizer_credentials_arn, String,
         callbacks: {
           "authorizer_credentials_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies the required credentials as an IAM role for API Gateway to invoke the authorizer. To specify an IAM role for API Gateway to assume, use the role's Amazon Resource Name (ARN). To use resource-based permissions on the Lambda function, specify null. Supported only for ``REQUEST`` authorizers.
         DESCRIPTION

property :authorizer_payload_format_version, String,
         callbacks: {
           "authorizer_payload_format_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies the format of the payload sent to an HTTP API Lambda authorizer. Required for HTTP API Lambda authorizers. Supported values are ``1.0`` and ``2.0``. To learn more, see [Working with Lambda authorizers for HTTP APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-lambda-authorizer.html).
         DESCRIPTION

property :authorizer_result_ttl_in_seconds, Integer,
         callbacks: {
           "authorizer_result_ttl_in_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The time to live (TTL) for cached authorizer results, in seconds. If it equals 0, authorization caching is disabled. If it is greater than 0, API Gateway caches authorizer responses. The maximum value is 3600, or 1 hour. Supported only for HTTP API Lambda authorizers.
         DESCRIPTION

property :authorizer_type, String,
         required: true,
         callbacks: {
           "authorizer_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The authorizer type. Specify ``REQUEST`` for a Lambda function using incoming request parameters. Specify ``JWT`` to use JSON Web Tokens (supported only for HTTP APIs).
         DESCRIPTION

property :authorizer_uri, String,
         callbacks: {
           "authorizer_uri is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The authorizer's Uniform Resource Identifier (URI). For ``REQUEST`` authorizers, this must be a well-formed Lambda function URI, for example, ``arn:aws:apigateway:us-west-2:lambda:path/2015-03-31/functions/arn:aws:lambda:us-west-2:{account_id}:function:{lambda_function_name}/invocations``. In general, the URI has this form: ``arn:aws:apigateway:{region}:lambda:path/{service_api}``, where *{region}* is the same as the region hosting the Lambda function, path indicates that the remaining substring in the URI should be treated as the path to the resource, including the initial ``/``. For Lambda functions, this is usually of the form ``/2015-03-31/functions/[FunctionARN]/invocations``.
         DESCRIPTION

property :enable_simple_responses, [TrueClass, FalseClass],
         callbacks: {
           "enable_simple_responses is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Specifies whether a Lambda authorizer returns a response in a simple format. By default, a Lambda authorizer must return an IAM policy. If enabled, the Lambda authorizer can return a boolean value instead of an IAM policy. Supported only for HTTP APIs. To learn more, see [Working with Lambda authorizers for HTTP APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-lambda-authorizer.html).
         DESCRIPTION

property :identity_source, Array,
         callbacks: {
           "identity_source is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The identity source for which authorization is requested.
      For a ``REQUEST`` authorizer, this is optional. The value is a set of one or more mapping expressions of the specified request parameters. The identity source can be headers, query string parameters, stage variables, and context parameters. For example, if an Auth header and a Name query string parameter are defined as identity sources, this value is route.request.header.Auth, route.request.querystring.Name for WebSocket APIs. For HTTP APIs, use selection expressions prefixed with ``$``, for example, ``$request.header.Auth``, ``$request.querystring.Name``. These parameters are used to perform runtime validation for Lambda-based authorizers by verifying all of the identity-related request parameters are present in the request, not null, and non-empty. Only when this is true does the authorizer invoke the authorizer Lambda function. Otherwise, it returns a 401 Unauthorized response without calling the Lambda function. For HTTP APIs, identity sources are also used as the cache key when caching is enabled. To learn more, see [Working with Lambda authorizers for HTTP APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-lambda-authorizer.html).
      For ``JWT``, a single entry that specifies where to extract the JSON Web Token (JWT) from inbound requests. Currently only header-based and query parameter-based selections are supported, for example ``$request.header.Authorization``.
         DESCRIPTION

property :identity_validation_expression, String,
         callbacks: {
           "identity_validation_expression is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           This parameter is not used.
         DESCRIPTION

property :jwt_configuration, Hash,
         callbacks: {
           "Subproperty `Issuer` is not a String" => lambda { |v| v[:Issuer].is_a? String },
           "Subproperty `Audience` is not a Array" => lambda { |v| v[:Audience].is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The ``JWTConfiguration`` property specifies the configuration of a JWT authorizer. Required for the ``JWT`` authorizer type. Supported only for HTTP APIs.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the authorizer.
         DESCRIPTION

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
