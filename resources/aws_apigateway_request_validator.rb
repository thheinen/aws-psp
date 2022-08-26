# Import API specifics
use "awscc_base"

resource_name :aws_apigateway_request_validator
provides :aws_apigateway_request_validator, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ApiGateway::RequestValidator
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: "Name of the request validator."

property :rest_api_id, String,
         required: true,
         callbacks: {
           "rest_api_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The identifier of the targeted API entity."

property :validate_request_body, [TrueClass, FalseClass],
         callbacks: {
           "validate_request_body is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: "Indicates whether to validate the request body according to the configured schema for the targeted API and method. "

property :validate_request_parameters, [TrueClass, FalseClass],
         callbacks: {
           "validate_request_parameters is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: "Indicates whether to validate request parameters."

# API URLs and mappings
rest_api_collection "/AWS::ApiGateway::RequestValidator"
rest_api_document "/AWS::ApiGateway::RequestValidator"

rest_property_map({
  name:                        "Name",
  rest_api_id:                 "RestApiId",
  validate_request_body:       "ValidateRequestBody",
  validate_request_parameters: "ValidateRequestParameters",
})

rest_post_only_properties %i{
  name rest_api_id
}
