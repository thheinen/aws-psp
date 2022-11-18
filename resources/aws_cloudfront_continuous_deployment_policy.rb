# Import API specifics
use "awscc_base"

resource_name :aws_cloudfront_continuous_deployment_policy
provides :aws_cloudfront_continuous_deployment_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::CloudFront::ContinuousDeploymentPolicy
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :continuous_deployment_policy_config, Hash,
         required: true,
         callbacks: {
           "Subproperty `Enabled` is not a Boolean" => lambda { |v| v[:Enabled].is_a? Boolean },
           "Subproperty `StagingDistributionDnsNames` is not a Array" => lambda { |v| v[:StagingDistributionDnsNames].is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::CloudFront::ContinuousDeploymentPolicy"
rest_api_document "/AWS::CloudFront::ContinuousDeploymentPolicy"

rest_property_map({
  continuous_deployment_policy_config: "ContinuousDeploymentPolicyConfig",
})

