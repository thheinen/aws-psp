# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_apigateway_v2_model
provides :aws_apigateway_v2_model, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ApiGatewayV2::Model
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

property :content_type, String,
         callbacks: {
           "content_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :schema, Hash,
         required: true,
         callbacks: {
           "schema is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

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
