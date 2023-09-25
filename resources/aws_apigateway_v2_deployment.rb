# Import API specifics
use "awscc_base"

resource_name :aws_apigateway_v2_deployment
provides :aws_apigateway_v2_deployment, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The ``AWS::ApiGatewayV2::Deployment`` resource creates a deployment for an API.
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

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The description for the deployment resource.
         DESCRIPTION

property :stage_name, String,
         callbacks: {
           "stage_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of an existing stage to associate with the deployment.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ApiGatewayV2::Deployment"
rest_api_document "/AWS::ApiGatewayV2::Deployment"

rest_property_map({
  api_id:      "ApiId",
  description: "Description",
  stage_name:  "StageName",
})

rest_post_only_properties %i{
  api_id
}
