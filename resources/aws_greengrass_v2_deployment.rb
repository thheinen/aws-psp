# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_greengrass_v2_deployment
provides :aws_greengrass_v2_deployment, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource for Greengrass V2 deployment.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :components, Hash,
         callbacks: {
           "components is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :deployment_name, String,
         callbacks: {
           "deployment_name is not a String" => lambda { |v| v.is_a? String },
           "deployment_name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
         },
         description: ""

property :deployment_policies, Hash,
         callbacks: {
           "Subproperty `FailureHandlingPolicy` is not a String" => lambda { |v| v[:FailureHandlingPolicy].is_a? String },
           "Subproperty `FailureHandlingPolicy`is not one of `ROLLBACK`, `DO_NOTHING`" => lambda { |v| %w{ROLLBACK DO_NOTHING}.include? v[:FailureHandlingPolicy] },
         },
         description: ""

property :iot_job_configuration, Hash,
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :target_arn, String,
         required: true,
         callbacks: {
           "target_arn is not a String" => lambda { |v| v.is_a? String },
           "target_arn must match pattern arn:[^:]*:iot:[^:]*:[0-9]+:(thing|thinggroup)/.+" => lambda { |v| v =~ Regexp.new("/arn:[^:]*:iot:[^:]*:[0-9]+:(thing|thinggroup)/.+/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::GreengrassV2::Deployment"
rest_api_document "/AWS::GreengrassV2::Deployment"

rest_property_map({
  components:            "Components",
  deployment_name:       "DeploymentName",
  deployment_policies:   "DeploymentPolicies",
  iot_job_configuration: "IotJobConfiguration",
  tags:                  "Tags",
  target_arn:            "TargetArn",
})

rest_post_only_properties %i{
  components deployment_name deployment_policies iot_job_configuration target_arn
}
