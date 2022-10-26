# Import API specifics
use "awscc_base"

resource_name :aws_apigateway_documentation_version
provides :aws_apigateway_documentation_version, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  A snapshot of the documentation of an API.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The description of the API documentation snapshot.
         DESCRIPTION

property :documentation_version, String,
         required: true,
         callbacks: {
           "documentation_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The version identifier of the API documentation snapshot.
         DESCRIPTION

property :rest_api_id, String,
         required: true,
         callbacks: {
           "rest_api_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The identifier of the API.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ApiGateway::DocumentationVersion"
rest_api_document "/AWS::ApiGateway::DocumentationVersion"

rest_property_map({
  description:           "Description",
  documentation_version: "DocumentationVersion",
  rest_api_id:           "RestApiId",
})

rest_post_only_properties %i{
  documentation_version rest_api_id
}
