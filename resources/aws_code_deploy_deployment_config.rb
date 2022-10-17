# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_code_deploy_deployment_config
provides :aws_code_deploy_deployment_config, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::CodeDeploy::DeploymentConfig
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :compute_platform, String,
         callbacks: {
           "compute_platform is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The destination platform type for the deployment (Lambda, Server, or ECS).
         DESCRIPTION

property :deployment_config_name, String,
         callbacks: {
           "deployment_config_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A name for the deployment configuration. If you don't specify a name, AWS CloudFormation generates a unique physical ID and uses that ID for the deployment configuration name. For more information, see Name Type.
         DESCRIPTION

property :minimum_healthy_hosts, Hash,
         callbacks: {
           "Subproperty `Value` is not a Integer" => lambda { |v| v[:Value].is_a? Integer },
           "Subproperty `Type` is not a String" => lambda { |v| v[:Type].is_a? String },
         },
         description: <<~'DESCRIPTION'
           The minimum number of healthy instances that should be available at any time during the deployment. There are two parameters expected in the input: type and value.
         DESCRIPTION

property :traffic_routing_config, Hash,
         callbacks: {
           "Subproperty `Type` is not a String" => lambda { |v| v[:Type].is_a? String },
         },
         description: <<~'DESCRIPTION'
           The configuration that specifies how the deployment traffic is routed.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::CodeDeploy::DeploymentConfig"
rest_api_document "/AWS::CodeDeploy::DeploymentConfig"

rest_property_map({
  compute_platform:       "ComputePlatform",
  deployment_config_name: "DeploymentConfigName",
  minimum_healthy_hosts:  "MinimumHealthyHosts",
  traffic_routing_config: "TrafficRoutingConfig",
})

rest_post_only_properties %i{
  compute_platform deployment_config_name minimum_healthy_hosts traffic_routing_config
}
