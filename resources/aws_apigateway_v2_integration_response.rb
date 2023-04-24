# Import API specifics
use "awscc_base"

resource_name :aws_apigateway_v2_integration_response
provides :aws_apigateway_v2_integration_response, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Schema for ApiGatewayV2 Integration Response
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
           The API identifier
         DESCRIPTION

property :content_handling_strategy, String,
         callbacks: {
           "content_handling_strategy is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies how to handle response payload content type conversions
         DESCRIPTION

property :integration_id, String,
         required: true,
         callbacks: {
           "integration_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The integration ID
         DESCRIPTION

property :integration_response_key, String,
         required: true,
         callbacks: {
           "integration_response_key is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The integration response key
         DESCRIPTION

property :response_parameters, Hash,
         callbacks: {
           "response_parameters is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           A key-value map specifying response parameters that are passed to the method response from the backend
         DESCRIPTION

property :response_templates, Hash,
         callbacks: {
           "response_templates is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           The collection of response templates for the integration response as a string-to-string map of key-value pairs
         DESCRIPTION

property :template_selection_expression, String,
         callbacks: {
           "template_selection_expression is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The template selection expression for the integration response. Supported only for WebSocket APIs
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
