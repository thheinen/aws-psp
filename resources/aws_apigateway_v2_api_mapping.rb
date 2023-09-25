# Import API specifics
use "awscc_base"

resource_name :aws_apigateway_v2_api_mapping
provides :aws_apigateway_v2_api_mapping, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The ``AWS::ApiGatewayV2::ApiMapping`` resource contains an API mapping. An API mapping relates a path of your custom domain name to a stage of your API. A custom domain name can have multiple API mappings, but the paths can't overlap. A custom domain can map only to APIs of the same protocol type. For more information, see [CreateApiMapping](https://docs.aws.amazon.com/apigatewayv2/latest/api-reference/domainnames-domainname-apimappings.html#CreateApiMapping) in the *Amazon API Gateway V2 API Reference*.
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
           The identifier of the API.
         DESCRIPTION

property :api_mapping_key, String,
         callbacks: {
           "api_mapping_key is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The API mapping key.
         DESCRIPTION

property :domain_name, String,
         required: true,
         callbacks: {
           "domain_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The domain name.
         DESCRIPTION

property :stage, String,
         required: true,
         callbacks: {
           "stage is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The API stage.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ApiGatewayV2::ApiMapping"
rest_api_document "/AWS::ApiGatewayV2::ApiMapping"

rest_property_map({
  api_id:          "ApiId",
  api_mapping_key: "ApiMappingKey",
  domain_name:     "DomainName",
  stage:           "Stage",
})

rest_post_only_properties %i{
  domain_name
}
