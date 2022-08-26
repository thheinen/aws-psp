# Import API specifics
use "awscc_base"

resource_name :aws_apigateway_resource
provides :aws_apigateway_resource, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ApiGateway::Resource
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :parent_id, String,
         required: true,
         callbacks: {
           "parent_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The parent resource's identifier."

property :path_part, String,
         required: true,
         callbacks: {
           "path_part is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The last path segment for this resource."

property :rest_api_id, String,
         required: true,
         callbacks: {
           "rest_api_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The ID of the RestApi resource in which you want to create this resource.."

# API URLs and mappings
rest_api_collection "/AWS::ApiGateway::Resource"
rest_api_document "/AWS::ApiGateway::Resource"

rest_property_map({
  parent_id:   "ParentId",
  path_part:   "PathPart",
  rest_api_id: "RestApiId",
})

rest_post_only_properties %i{
  parent_id path_part rest_api_id
}
