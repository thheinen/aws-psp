# Import API specifics
use "awscc_base"

resource_name :aws_apigateway_v2_api
provides :aws_apigateway_v2_api, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The ``AWS::ApiGatewayV2::Api`` resource creates an API. WebSocket APIs and HTTP APIs are supported. For more information about WebSocket APIs, see [About WebSocket APIs in API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api-overview.html) in the *API Gateway Developer Guide*. For more information about HTTP APIs, see [HTTP APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api.html) in the *API Gateway Developer Guide.*
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :api_key_selection_expression, String,
         callbacks: {
           "api_key_selection_expression is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           An API key selection expression. Supported only for WebSocket APIs. See [API Key Selection Expressions](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api-selection-expressions.html#apigateway-websocket-api-apikey-selection-expressions).
         DESCRIPTION

property :base_path, String,
         callbacks: {
           "base_path is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies how to interpret the base path of the API during import. Valid values are ``ignore``, ``prepend``, and ``split``. The default value is ``ignore``. To learn more, see [Set the OpenAPI basePath Property](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-import-api-basePath.html). Supported only for HTTP APIs.
         DESCRIPTION

property :body, Hash,
         callbacks: {
           "body is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           The OpenAPI definition. Supported only for HTTP APIs. To import an HTTP API, you must specify a ``Body`` or ``BodyS3Location``. If you specify a ``Body`` or ``BodyS3Location``, don't specify CloudFormation resources such as ``AWS::ApiGatewayV2::Authorizer`` or ``AWS::ApiGatewayV2::Route``. API Gateway doesn't support the combination of OpenAPI and CloudFormation resources.
         DESCRIPTION

property :body_s3_location, Hash,
         callbacks: {
           "Subproperty `Etag` is not a String" => lambda { |v| v[:Etag].is_a? String },
           "Subproperty `Bucket` is not a String" => lambda { |v| v[:Bucket].is_a? String },
           "Subproperty `Version` is not a String" => lambda { |v| v[:Version].is_a? String },
           "Subproperty `Key` is not a String" => lambda { |v| v[:Key].is_a? String },
         },
         description: <<~'DESCRIPTION'
           The S3 location of an OpenAPI definition. Supported only for HTTP APIs. To import an HTTP API, you must specify a ``Body`` or ``BodyS3Location``. If you specify a ``Body`` or ``BodyS3Location``, don't specify CloudFormation resources such as ``AWS::ApiGatewayV2::Authorizer`` or ``AWS::ApiGatewayV2::Route``. API Gateway doesn't support the combination of OpenAPI and CloudFormation resources.
         DESCRIPTION

property :cors_configuration, Hash,
         callbacks: {
           "Subproperty `AllowOrigins` is not a Array" => lambda { |v| v[:AllowOrigins].is_a? Array },
           "Subproperty `AllowCredentials` is not a Boolean" => lambda { |v| v[:AllowCredentials].is_a? Boolean },
           "Subproperty `ExposeHeaders` is not a Array" => lambda { |v| v[:ExposeHeaders].is_a? Array },
           "Subproperty `AllowHeaders` is not a Array" => lambda { |v| v[:AllowHeaders].is_a? Array },
           "Subproperty `MaxAge` is not a Integer" => lambda { |v| v[:MaxAge].is_a? Integer },
           "Subproperty `AllowMethods` is not a Array" => lambda { |v| v[:AllowMethods].is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A CORS configuration. Supported only for HTTP APIs. See [Configuring CORS](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-cors.html) for more information.
         DESCRIPTION

property :credentials_arn, String,
         callbacks: {
           "credentials_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           This property is part of quick create. It specifies the credentials required for the integration, if any. For a Lambda integration, three options are available. To specify an IAM Role for API Gateway to assume, use the role's Amazon Resource Name (ARN). To require that the caller's identity be passed through from the request, specify ``arn:aws:iam::*:user/*``. To use resource-based permissions on supported AWS services, specify ``null``. Currently, this property is not used for HTTP integrations. Supported only for HTTP APIs.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The description of the API.
         DESCRIPTION

property :disable_execute_api_endpoint, [TrueClass, FalseClass],
         callbacks: {
           "disable_execute_api_endpoint is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Specifies whether clients can invoke your API by using the default ``execute-api`` endpoint. By default, clients can invoke your API with the default https://{api_id}.execute-api.{region}.amazonaws.com endpoint. To require that clients use a custom domain name to invoke your API, disable the default endpoint.
         DESCRIPTION

property :disable_schema_validation, [TrueClass, FalseClass],
         callbacks: {
           "disable_schema_validation is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Avoid validating models when creating a deployment. Supported only for WebSocket APIs.
         DESCRIPTION

property :fail_on_warnings, [TrueClass, FalseClass],
         callbacks: {
           "fail_on_warnings is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Specifies whether to rollback the API creation when a warning is encountered. By default, API creation continues if a warning is encountered.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the API. Required unless you specify an OpenAPI definition for ``Body`` or ``S3BodyLocation``.
         DESCRIPTION

property :protocol_type, String,
         callbacks: {
           "protocol_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The API protocol. Valid values are ``WEBSOCKET`` or ``HTTP``. Required unless you specify an OpenAPI definition for ``Body`` or ``S3BodyLocation``.
         DESCRIPTION

property :route_key, String,
         callbacks: {
           "route_key is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           This property is part of quick create. If you don't specify a ``routeKey``, a default route of ``$default`` is created. The ``$default`` route acts as a catch-all for any request made to your API, for a particular stage. The ``$default`` route key can't be modified. You can add routes after creating the API, and you can update the route keys of additional routes. Supported only for HTTP APIs.
         DESCRIPTION

property :route_selection_expression, String,
         callbacks: {
           "route_selection_expression is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The route selection expression for the API. For HTTP APIs, the ``routeSelectionExpression`` must be ``${request.method} ${request.path}``. If not provided, this will be the default for HTTP APIs. This property is required for WebSocket APIs.
         DESCRIPTION

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           The collection of tags. Each tag element is associated with a given resource.
         DESCRIPTION

property :target, String,
         callbacks: {
           "target is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           This property is part of quick create. Quick create produces an API with an integration, a default catch-all route, and a default stage which is configured to automatically deploy changes. For HTTP integrations, specify a fully qualified URL. For Lambda integrations, specify a function ARN. The type of the integration will be HTTP_PROXY or AWS_PROXY, respectively. Supported only for HTTP APIs.
         DESCRIPTION

property :version, String,
         callbacks: {
           "version is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A version identifier for the API.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ApiGatewayV2::Api"
rest_api_document "/AWS::ApiGatewayV2::Api"

rest_property_map({
  api_key_selection_expression: "ApiKeySelectionExpression",
  base_path:                    "BasePath",
  body:                         "Body",
  body_s3_location:             "BodyS3Location",
  cors_configuration:           "CorsConfiguration",
  credentials_arn:              "CredentialsArn",
  description:                  "Description",
  disable_execute_api_endpoint: "DisableExecuteApiEndpoint",
  disable_schema_validation:    "DisableSchemaValidation",
  fail_on_warnings:             "FailOnWarnings",
  name:                         "Name",
  protocol_type:                "ProtocolType",
  route_key:                    "RouteKey",
  route_selection_expression:   "RouteSelectionExpression",
  tags:                         "Tags",
  target:                       "Target",
  version:                      "Version",
})

rest_post_only_properties %i{
  protocol_type
}
