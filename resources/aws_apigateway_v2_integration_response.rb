# Import API specifics
use "awscc_base"

resource_name :aws_apigateway_v2_integration_response
provides :aws_apigateway_v2_integration_response, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The ``AWS::ApiGatewayV2::IntegrationResponse`` resource updates an integration response for an WebSocket API. For more information, see [Set up WebSocket API Integration Responses in API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api-integration-responses.html) in the *API Gateway Developer Guide*.
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

property :content_handling_strategy, String,
         callbacks: {
           "content_handling_strategy is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Supported only for WebSocket APIs. Specifies how to handle response payload content type conversions. Supported values are ``CONVERT_TO_BINARY`` and ``CONVERT_TO_TEXT``, with the following behaviors:
      ``CONVERT_TO_BINARY``: Converts a response payload from a Base64-encoded string to the corresponding binary blob.
      ``CONVERT_TO_TEXT``: Converts a response payload from a binary blob to a Base64-encoded string.
      If this property is not defined, the response payload will be passed through from the integration response to the route response or method response without modification.
         DESCRIPTION

property :integration_id, String,
         required: true,
         callbacks: {
           "integration_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The integration ID.
         DESCRIPTION

property :integration_response_key, String,
         required: true,
         callbacks: {
           "integration_response_key is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The integration response key.
         DESCRIPTION

property :response_parameters, Hash,
         callbacks: {
           "response_parameters is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           A key-value map specifying response parameters that are passed to the method response from the backend. The key is a method response header parameter name and the mapped value is an integration response header value, a static value enclosed within a pair of single quotes, or a JSON expression from the integration response body. The mapping key must match the pattern of ``method.response.header.{name}``, where name is a valid and unique header name. The mapped non-static value must match the pattern of ``integration.response.header.{name}`` or ``integration.response.body.{JSON-expression}``, where ``{name}`` is a valid and unique response header name and ``{JSON-expression}`` is a valid JSON expression without the ``$`` prefix.
         DESCRIPTION

property :response_templates, Hash,
         callbacks: {
           "response_templates is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           The collection of response templates for the integration response as a string-to-string map of key-value pairs. Response templates are represented as a key/value map, with a content-type as the key and a template as the value.
         DESCRIPTION

property :template_selection_expression, String,
         callbacks: {
           "template_selection_expression is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The template selection expression for the integration response. Supported only for WebSocket APIs.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ApiGatewayV2::IntegrationResponse"
rest_api_document "/AWS::ApiGatewayV2::IntegrationResponse"

rest_property_map({
  api_id:                        "ApiId",
  content_handling_strategy:     "ContentHandlingStrategy",
  integration_id:                "IntegrationId",
  integration_response_key:      "IntegrationResponseKey",
  response_parameters:           "ResponseParameters",
  response_templates:            "ResponseTemplates",
  template_selection_expression: "TemplateSelectionExpression",
})

rest_post_only_properties %i{
  api_id integration_id
}
