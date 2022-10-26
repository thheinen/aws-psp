# Import API specifics
use "awscc_base"

resource_name :aws_apigateway_documentation_part
provides :aws_apigateway_documentation_part, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ApiGateway::DocumentationPart
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :location, Hash,
         required: true,
         callbacks: {
           "Subproperty `Method` is not a String" => lambda { |v| v[:Method].is_a? String },
           "Subproperty `Name` is not a String" => lambda { |v| v[:Name].is_a? String },
           "Subproperty `Path` is not a String" => lambda { |v| v[:Path].is_a? String },
           "Subproperty `StatusCode` is not a String" => lambda { |v| v[:StatusCode].is_a? String },
           "Subproperty `Type` is not a String" => lambda { |v| v[:Type].is_a? String },
           "Subproperty `Type`is not one of `API`, `AUTHORIZER`, `MODEL`, `RESOURCE`, `METHOD`, `PATH_PARAMETER`, `QUERY_PARAMETER`, `REQUEST_HEADER`, `REQUEST_BODY`, `RESPONSE`, `RESPONSE_HEADER`, `RESPONSE_BODY`" => lambda { |v| %w{API AUTHORIZER MODEL RESOURCE METHOD PATH_PARAMETER QUERY_PARAMETER REQUEST_HEADER REQUEST_BODY RESPONSE RESPONSE_HEADER RESPONSE_BODY}.include? v[:Type] },
         },
         description: <<~'DESCRIPTION'
           The location of the API entity that the documentation applies to.
         DESCRIPTION

property :properties, String,
         required: true,
         callbacks: {
           "properties is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The documentation content map of the targeted API entity.
         DESCRIPTION

property :rest_api_id, String,
         required: true,
         callbacks: {
           "rest_api_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Identifier of the targeted API entity
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ApiGateway::DocumentationPart"
rest_api_document "/AWS::ApiGateway::DocumentationPart"

rest_property_map({
  location:    "Location",
  properties:  "Properties",
  rest_api_id: "RestApiId",
})

rest_post_only_properties %i{
  location rest_api_id
}
