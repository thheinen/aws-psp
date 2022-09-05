# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_apigateway_base_path_mapping
provides :aws_apigateway_base_path_mapping, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ApiGateway::BasePathMapping
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :base_path, String,
         callbacks: {
           "base_path is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The base path name that callers of the API must provide in the URL after the domain name.
         DESCRIPTION

property :domain_name, String,
         required: true,
         callbacks: {
           "domain_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The DomainName of an AWS::ApiGateway::DomainName resource.
         DESCRIPTION

property :id, String,
         callbacks: {
           "id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :rest_api_id, String,
         callbacks: {
           "rest_api_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the API.
         DESCRIPTION

property :stage, String,
         callbacks: {
           "stage is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the API's stage.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ApiGateway::BasePathMapping"
rest_api_document "/AWS::ApiGateway::BasePathMapping"

rest_property_map({
  base_path:   "BasePath",
  domain_name: "DomainName",
  id:          "Id",
  rest_api_id: "RestApiId",
  stage:       "Stage",
})

rest_post_only_properties %i{
  base_path domain_name
}
