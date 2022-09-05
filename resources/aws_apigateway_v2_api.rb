# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_apigateway_v2_api
provides :aws_apigateway_v2_api, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ApiGatewayV2::Api
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :api_key_selection_expression, String,
         callbacks: {
           "api_key_selection_expression is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :base_path, String,
         callbacks: {
           "base_path is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :body, Hash,
         callbacks: {
           "body is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :body_s3_location, Hash,
         callbacks: {
           "Subproperty `Etag` is not a String" => lambda { |v| v[:Etag].is_a? String },
           "Subproperty `Bucket` is not a String" => lambda { |v| v[:Bucket].is_a? String },
           "Subproperty `Version` is not a String" => lambda { |v| v[:Version].is_a? String },
           "Subproperty `Key` is not a String" => lambda { |v| v[:Key].is_a? String },
         },
         description: ""

property :cors_configuration, Hash,
         callbacks: {
           "Subproperty `AllowOrigins` is not a Array" => lambda { |v| v[:AllowOrigins].is_a? Array },
           "Subproperty `AllowCredentials` is not a Boolean" => lambda { |v| v[:AllowCredentials].is_a? Boolean },
           "Subproperty `ExposeHeaders` is not a Array" => lambda { |v| v[:ExposeHeaders].is_a? Array },
           "Subproperty `AllowHeaders` is not a Array" => lambda { |v| v[:AllowHeaders].is_a? Array },
           "Subproperty `MaxAge` is not a Integer" => lambda { |v| v[:MaxAge].is_a? Integer },
           "Subproperty `AllowMethods` is not a Array" => lambda { |v| v[:AllowMethods].is_a? Array },
         },
         description: ""

property :credentials_arn, String,
         callbacks: {
           "credentials_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :disable_execute_api_endpoint, [TrueClass, FalseClass],
         callbacks: {
           "disable_execute_api_endpoint is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :disable_schema_validation, [TrueClass, FalseClass],
         callbacks: {
           "disable_schema_validation is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :fail_on_warnings, [TrueClass, FalseClass],
         callbacks: {
           "fail_on_warnings is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :protocol_type, String,
         callbacks: {
           "protocol_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :route_key, String,
         callbacks: {
           "route_key is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :route_selection_expression, String,
         callbacks: {
           "route_selection_expression is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           This resource type use map for Tags, suggest to use List of Tag
         DESCRIPTION

property :target, String,
         callbacks: {
           "target is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :version, String,
         callbacks: {
           "version is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::ApiGatewayV2::Api"
rest_api_document "/AWS::ApiGatewayV2::Api"

rest_property_map({
  api_key_selection_expression: "ApiKeySelectionExpression",
  base_path:                    "BasePath",
  body:                         "Body",
  body_s3_location:             "BodyS3Location",
  cors_configuration:           "CorsConfiguration",
  credentials_arn:              "CredentialsArn",
  description:                  "Description",
  disable_execute_api_endpoint: "DisableExecuteApiEndpoint",
  disable_schema_validation:    "DisableSchemaValidation",
  fail_on_warnings:             "FailOnWarnings",
  name:                         "Name",
  protocol_type:                "ProtocolType",
  route_key:                    "RouteKey",
  route_selection_expression:   "RouteSelectionExpression",
  tags:                         "Tags",
  target:                       "Target",
  version:                      "Version",
})

rest_post_only_properties %i{
  protocol_type
}
