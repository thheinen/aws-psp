# Import API specifics
use "awscc_base"

resource_name :aws_apigateway_v2_model
provides :aws_apigateway_v2_model, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The ``AWS::ApiGatewayV2::Model`` resource updates data model for a WebSocket API. For more information, see [Model Selection Expressions](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api-selection-expressions.html#apigateway-websocket-api-model-selection-expressions) in the *API Gateway Developer Guide*.
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

property :content_type, String,
         callbacks: {
           "content_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The content-type for the model, for example, "application/json".
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The description of the model.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the model.
         DESCRIPTION

property :schema, Hash,
         required: true,
         callbacks: {
           "schema is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           The schema for the model. For application/json models, this should be JSON schema draft 4 model.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ApiGatewayV2::Model"
rest_api_document "/AWS::ApiGatewayV2::Model"

rest_property_map({
  api_id:       "ApiId",
  content_type: "ContentType",
  description:  "Description",
  name:         "Name",
  schema:       "Schema",
})

rest_post_only_properties %i{
  api_id
}
