# Import API specifics
use "awscc_base"

resource_name :aws_apigateway_rest_api
provides :aws_apigateway_rest_api, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ApiGateway::RestApi.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :api_key_source_type, String,
         callbacks: {
           "api_key_source_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :binary_media_types, Array,
         callbacks: {
           "binary_media_types is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :body, [Hash, String],
         description: ""

property :body_s3_location, Hash,
         callbacks: {
           "Subproperty `Bucket` is not a String" => lambda { |v| v[:Bucket].is_a? String },
           "Subproperty `ETag` is not a String" => lambda { |v| v[:ETag].is_a? String },
           "Subproperty `Version` is not a String" => lambda { |v| v[:Version].is_a? String },
           "Subproperty `Key` is not a String" => lambda { |v| v[:Key].is_a? String },
         },
         description: ""

property :clone_from, String,
         callbacks: {
           "clone_from is not a String" => lambda { |v| v.is_a? String },
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

property :endpoint_configuration, Hash,
         callbacks: {
           "Subproperty `Types` is not a Array" => lambda { |v| v[:Types].is_a? Array },
           "Subproperty `VpcEndpointIds` is not a Array" => lambda { |v| v[:VpcEndpointIds].is_a? Array },
         },
         description: ""

property :fail_on_warnings, [TrueClass, FalseClass],
         callbacks: {
           "fail_on_warnings is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :minimum_compression_size, Integer,
         callbacks: {
           "minimum_compression_size is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :mode, String,
         callbacks: {
           "mode is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :parameters, [Hash, String],
         description: ""

property :policy, [Hash, String],
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::ApiGateway::RestApi"
rest_api_document "/AWS::ApiGateway::RestApi"

rest_property_map({
  api_key_source_type:          "ApiKeySourceType",
  binary_media_types:           "BinaryMediaTypes",
  body:                         "Body",
  body_s3_location:             "BodyS3Location",
  clone_from:                   "CloneFrom",
  description:                  "Description",
  disable_execute_api_endpoint: "DisableExecuteApiEndpoint",
  endpoint_configuration:       "EndpointConfiguration",
  fail_on_warnings:             "FailOnWarnings",
  minimum_compression_size:     "MinimumCompressionSize",
  mode:                         "Mode",
  name:                         "Name",
  parameters:                   "Parameters",
  policy:                       "Policy",
  tags:                         "Tags",
})

