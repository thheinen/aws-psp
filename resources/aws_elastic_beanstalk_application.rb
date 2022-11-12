# Import API specifics
use "awscc_base"

resource_name :aws_elastic_beanstalk_application
provides :aws_elastic_beanstalk_application, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::ElasticBeanstalk::Application resource specifies an Elastic Beanstalk application.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :application_name, String,
         callbacks: {
           "application_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A name for the Elastic Beanstalk application. If you don't specify a name, AWS CloudFormation generates a unique physical ID and uses that ID for the application name.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Your description of the application.
         DESCRIPTION

property :resource_lifecycle_config, Hash,
         callbacks: {
           "Subproperty `ServiceRole` is not a String" => lambda { |v| v[:ServiceRole].is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies an application resource lifecycle configuration to prevent your application from accumulating too many versions.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ElasticBeanstalk::Application"
rest_api_document "/AWS::ElasticBeanstalk::Application"

rest_property_map({
  application_name:          "ApplicationName",
  description:               "Description",
  resource_lifecycle_config: "ResourceLifecycleConfig",
})

rest_post_only_properties %i{
  application_name
}
