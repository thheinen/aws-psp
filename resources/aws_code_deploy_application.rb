# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_code_deploy_application
provides :aws_code_deploy_application, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::CodeDeploy::Application resource creates an AWS CodeDeploy application
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :application_name, String,
         callbacks: {
           "application_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A name for the application. If you don't specify a name, AWS CloudFormation generates a unique physical ID and uses that ID for the application name.
         DESCRIPTION

property :compute_platform, String,
         callbacks: {
           "compute_platform is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The compute platform that CodeDeploy deploys the application to.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The metadata that you apply to CodeDeploy applications to help you organize and categorize them. Each tag consists of a key and an optional value, both of which you define.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::CodeDeploy::Application"
rest_api_document "/AWS::CodeDeploy::Application"

rest_property_map({
  application_name: "ApplicationName",
  compute_platform: "ComputePlatform",
  tags:             "Tags",
})

rest_post_only_properties %i{
  application_name compute_platform
}
