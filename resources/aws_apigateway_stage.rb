# Import API specifics
use "awscc_base"

resource_name :aws_apigateway_stage
provides :aws_apigateway_stage, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ApiGateway::Stage
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :access_log_setting, Hash,
         callbacks: {
           "Subproperty `DestinationArn` is not a String" => lambda { |v| v[:DestinationArn].is_a? String },
           "Subproperty `DestinationArn`is not a valid ARN" => lambda { |v| v[:DestinationArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `Format` is not a String" => lambda { |v| v[:Format].is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies settings for logging access in this stage.
         DESCRIPTION

property :cache_cluster_enabled, [TrueClass, FalseClass],
         callbacks: {
           "cache_cluster_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Indicates whether cache clustering is enabled for the stage.
         DESCRIPTION

property :cache_cluster_size, String,
         callbacks: {
           "cache_cluster_size is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The stage's cache cluster size.
         DESCRIPTION

property :canary_setting, Hash,
         callbacks: {
           "Subproperty `DeploymentId` is not a String" => lambda { |v| v[:DeploymentId].is_a? String },
           "Subproperty `PercentTraffic` is not a Number" => lambda { |v| v[:PercentTraffic].is_a? Number },
           "Subproperty `StageVariableOverrides` is not a Object" => lambda { |v| v[:StageVariableOverrides].is_a? Object },
           "Subproperty `UseStageCache` is not a Boolean" => lambda { |v| v[:UseStageCache].is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Specifies settings for the canary deployment in this stage.
         DESCRIPTION

property :client_certificate_id, String,
         callbacks: {
           "client_certificate_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the client certificate that API Gateway uses to call your integration endpoints in the stage.
         DESCRIPTION

property :deployment_id, String,
         callbacks: {
           "deployment_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the deployment that the stage is associated with. This parameter is required to create a stage.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A description of the stage.
         DESCRIPTION

property :documentation_version, String,
         callbacks: {
           "documentation_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The version ID of the API documentation snapshot.
         DESCRIPTION

property :method_settings, Array,
         callbacks: {
           "method_settings is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Settings for all methods in the stage.
         DESCRIPTION

property :rest_api_id, String,
         required: true,
         callbacks: {
           "rest_api_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the RestApi resource that you're deploying with this stage.
         DESCRIPTION

property :stage_name, String,
         callbacks: {
           "stage_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the stage, which API Gateway uses as the first path segment in the invoked Uniform Resource Identifier (URI).
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of arbitrary tags (key-value pairs) to associate with the stage.
         DESCRIPTION

property :tracing_enabled, [TrueClass, FalseClass],
         callbacks: {
           "tracing_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Specifies whether active X-Ray tracing is enabled for this stage.
         DESCRIPTION

property :variables, Hash,
         callbacks: {
           "variables is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           A map (string-to-string map) that defines the stage variables, where the variable name is the key and the variable value is the value.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ApiGateway::Stage"
rest_api_document "/AWS::ApiGateway::Stage"

rest_property_map({
  access_log_setting:    "AccessLogSetting",
  cache_cluster_enabled: "CacheClusterEnabled",
  cache_cluster_size:    "CacheClusterSize",
  canary_setting:        "CanarySetting",
  client_certificate_id: "ClientCertificateId",
  deployment_id:         "DeploymentId",
  description:           "Description",
  documentation_version: "DocumentationVersion",
  method_settings:       "MethodSettings",
  rest_api_id:           "RestApiId",
  stage_name:            "StageName",
  tags:                  "Tags",
  tracing_enabled:       "TracingEnabled",
  variables:             "Variables",
})

rest_post_only_properties %i{
  rest_api_id stage_name
}
