# Import API specifics
use "awscc_base"

resource_name :aws_apigateway_deployment
provides :aws_apigateway_deployment, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ApiGateway::Deployment
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :deployment_canary_settings, Hash,
         callbacks: {
           "Subproperty `PercentTraffic` is not a Number" => lambda { |v| v[:PercentTraffic].is_a? Number },
           "Subproperty `StageVariableOverrides` is not a Object" => lambda { |v| v[:StageVariableOverrides].is_a? Object },
           "Subproperty `UseStageCache` is not a Boolean" => lambda { |v| v[:UseStageCache].is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Specifies settings for the canary deployment.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A description of the purpose of the API Gateway deployment.
         DESCRIPTION

property :rest_api_id, String,
         required: true,
         callbacks: {
           "rest_api_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the RestApi resource to deploy.
         DESCRIPTION

property :stage_description, Hash,
         callbacks: {
           "Subproperty `CacheClusterEnabled` is not a Boolean" => lambda { |v| v[:CacheClusterEnabled].is_a? Boolean },
           "Subproperty `CacheClusterSize` is not a String" => lambda { |v| v[:CacheClusterSize].is_a? String },
           "Subproperty `CacheDataEncrypted` is not a Boolean" => lambda { |v| v[:CacheDataEncrypted].is_a? Boolean },
           "Subproperty `CacheTtlInSeconds` is not a Integer" => lambda { |v| v[:CacheTtlInSeconds].is_a? Integer },
           "Subproperty `CachingEnabled` is not a Boolean" => lambda { |v| v[:CachingEnabled].is_a? Boolean },
           "Subproperty `ClientCertificateId` is not a String" => lambda { |v| v[:ClientCertificateId].is_a? String },
           "Subproperty `DataTraceEnabled` is not a Boolean" => lambda { |v| v[:DataTraceEnabled].is_a? Boolean },
           "Subproperty `Description` is not a String" => lambda { |v| v[:Description].is_a? String },
           "Subproperty `DocumentationVersion` is not a String" => lambda { |v| v[:DocumentationVersion].is_a? String },
           "Subproperty `LoggingLevel` is not a String" => lambda { |v| v[:LoggingLevel].is_a? String },
           "Subproperty `MethodSettings` is not a Array" => lambda { |v| v[:MethodSettings].is_a? Array },
           "Subproperty `MetricsEnabled` is not a Boolean" => lambda { |v| v[:MetricsEnabled].is_a? Boolean },
           "Subproperty `Tags` is not a Array" => lambda { |v| v[:Tags].is_a? Array },
           "Subproperty `ThrottlingBurstLimit` is not a Integer" => lambda { |v| v[:ThrottlingBurstLimit].is_a? Integer },
           "Subproperty `ThrottlingRateLimit` is not a Number" => lambda { |v| v[:ThrottlingRateLimit].is_a? Number },
           "Subproperty `TracingEnabled` is not a Boolean" => lambda { |v| v[:TracingEnabled].is_a? Boolean },
           "Subproperty `Variables` is not a Object" => lambda { |v| v[:Variables].is_a? Object },
         },
         description: <<~'DESCRIPTION'
           Configures the stage that API Gateway creates with this deployment.
         DESCRIPTION

property :stage_name, String,
         callbacks: {
           "stage_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A name for the stage that API Gateway creates with this deployment. Use only alphanumeric characters.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ApiGateway::Deployment"
rest_api_document "/AWS::ApiGateway::Deployment"

rest_property_map({
  deployment_canary_settings: "DeploymentCanarySettings",
  description:                "Description",
  rest_api_id:                "RestApiId",
  stage_description:          "StageDescription",
  stage_name:                 "StageName",
})

rest_post_only_properties %i{
  deployment_canary_settings rest_api_id
}
