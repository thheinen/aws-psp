# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_apigateway_model
provides :aws_apigateway_model, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ApiGateway::Model
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :content_type, String,
         callbacks: {
           "content_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The content type for the model.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A description that identifies this model.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A name for the model. If you don't specify a name, AWS CloudFormation generates a unique physical ID and uses that ID for the model name.
         DESCRIPTION

property :rest_api_id, String,
         required: true,
         callbacks: {
           "rest_api_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of a REST API with which to associate this model.
         DESCRIPTION

property :schema, [Hash, String],
         description: <<~'DESCRIPTION'
           The schema to use to transform data to one or more output formats. Specify null ({}) if you don't want to specify a schema.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ApiGateway::Model"
rest_api_document "/AWS::ApiGateway::Model"

rest_property_map({
  content_type: "ContentType",
  description:  "Description",
  name:         "Name",
  rest_api_id:  "RestApiId",
  schema:       "Schema",
})

rest_post_only_properties %i{
  content_type name rest_api_id
}
