# Import API specifics
use "awscc_base"

resource_name :aws_elastic_beanstalk_environment
provides :aws_elastic_beanstalk_environment, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ElasticBeanstalk::Environment
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :application_name, String,
         required: true,
         callbacks: {
           "application_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the application that is associated with this environment.
         DESCRIPTION

property :cname_prefix, String,
         callbacks: {
           "cname_prefix is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           If specified, the environment attempts to use this value as the prefix for the CNAME in your Elastic Beanstalk environment URL. If not specified, the CNAME is generated automatically by appending a random alphanumeric string to the environment name.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Your description for this environment.
         DESCRIPTION

property :environment_name, String,
         callbacks: {
           "environment_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A unique name for the environment.
         DESCRIPTION

property :operations_role, String,
         callbacks: {
           "operations_role is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of an existing IAM role to be used as the environment's operations role.
         DESCRIPTION

property :option_settings, Array,
         callbacks: {
           "option_settings is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Key-value pairs defining configuration options for this environment, such as the instance type.
         DESCRIPTION

property :platform_arn, String,
         callbacks: {
           "platform_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the custom platform to use with the environment.
         DESCRIPTION

property :solution_stack_name, String,
         callbacks: {
           "solution_stack_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of an Elastic Beanstalk solution stack (platform version) to use with the environment.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Specifies the tags applied to resources in the environment.
         DESCRIPTION

property :template_name, String,
         callbacks: {
           "template_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the Elastic Beanstalk configuration template to use with the environment.
         DESCRIPTION

property :tier, Hash,
         callbacks: {
           "Subproperty `Type` is not a String" => lambda { |v| v[:Type].is_a? String },
           "Subproperty `Version` is not a String" => lambda { |v| v[:Version].is_a? String },
           "Subproperty `Name` is not a String" => lambda { |v| v[:Name].is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies the tier to use in creating this environment. The environment tier that you choose determines whether Elastic Beanstalk provisions resources to support a web application that handles HTTP(S) requests or a web application that handles background-processing tasks.
         DESCRIPTION

property :version_label, String,
         callbacks: {
           "version_label is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the application version to deploy.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ElasticBeanstalk::Environment"
rest_api_document "/AWS::ElasticBeanstalk::Environment"

rest_property_map({
  application_name:    "ApplicationName",
  cname_prefix:        "CNAMEPrefix",
  description:         "Description",
  environment_name:    "EnvironmentName",
  operations_role:     "OperationsRole",
  option_settings:     "OptionSettings",
  platform_arn:        "PlatformArn",
  solution_stack_name: "SolutionStackName",
  tags:                "Tags",
  template_name:       "TemplateName",
  tier:                "Tier",
  version_label:       "VersionLabel",
})

rest_post_only_properties %i{
  application_name cname_prefix environment_name solution_stack_name tier/name tier/type
}
