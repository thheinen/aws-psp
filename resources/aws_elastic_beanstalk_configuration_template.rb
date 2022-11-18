# Import API specifics
use "awscc_base"

resource_name :aws_elastic_beanstalk_configuration_template
provides :aws_elastic_beanstalk_configuration_template, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ElasticBeanstalk::ConfigurationTemplate
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
           The name of the Elastic Beanstalk application to associate with this configuration template.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           An optional description for this configuration.
         DESCRIPTION

property :environment_id, String,
         callbacks: {
           "environment_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of an environment whose settings you want to use to create the configuration template. You must specify EnvironmentId if you don't specify PlatformArn, SolutionStackName, or SourceConfiguration.
         DESCRIPTION

property :option_settings, Array,
         callbacks: {
           "option_settings is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Option values for the Elastic Beanstalk configuration, such as the instance type. If specified, these values override the values obtained from the solution stack or the source configuration template. For a complete list of Elastic Beanstalk configuration options, see [Option Values](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/command-options.html) in the AWS Elastic Beanstalk Developer Guide.
         DESCRIPTION

property :platform_arn, String,
         callbacks: {
           "platform_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the custom platform. For more information, see [Custom Platforms](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/custom-platforms.html) in the AWS Elastic Beanstalk Developer Guide.
         DESCRIPTION

property :solution_stack_name, String,
         callbacks: {
           "solution_stack_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of an Elastic Beanstalk solution stack (platform version) that this configuration uses. For example, 64bit Amazon Linux 2013.09 running Tomcat 7 Java 7. A solution stack specifies the operating system, runtime, and application server for a configuration template. It also determines the set of configuration options as well as the possible and default values. For more information, see [Supported Platforms](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/concepts.platforms.html) in the AWS Elastic Beanstalk Developer Guide.
            You must specify SolutionStackName if you don't specify PlatformArn, EnvironmentId, or SourceConfiguration.
            Use the ListAvailableSolutionStacks API to obtain a list of available solution stacks.
         DESCRIPTION

property :source_configuration, Hash,
         callbacks: {
           "Subproperty `ApplicationName` is not a String" => lambda { |v| v[:ApplicationName].is_a? String },
           "Subproperty `TemplateName` is not a String" => lambda { |v| v[:TemplateName].is_a? String },
         },
         description: <<~'DESCRIPTION'
           An Elastic Beanstalk configuration template to base this one on. If specified, Elastic Beanstalk uses the configuration values from the specified configuration template to create a new configuration.
            Values specified in OptionSettings override any values obtained from the SourceConfiguration.
            You must specify SourceConfiguration if you don't specify PlatformArn, EnvironmentId, or SolutionStackName.
            Constraint: If both solution stack name and source configuration are specified, the solution stack of the source configuration template must match the specified solution stack name.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ElasticBeanstalk::ConfigurationTemplate"
rest_api_document "/AWS::ElasticBeanstalk::ConfigurationTemplate"

rest_property_map({
  application_name:     "ApplicationName",
  description:          "Description",
  environment_id:       "EnvironmentId",
  option_settings:      "OptionSettings",
  platform_arn:         "PlatformArn",
  solution_stack_name:  "SolutionStackName",
  source_configuration: "SourceConfiguration",
})

rest_post_only_properties %i{
  application_name environment_id platform_arn solution_stack_name source_configuration
}
