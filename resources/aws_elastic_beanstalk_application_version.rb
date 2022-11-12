# Import API specifics
use "awscc_base"

resource_name :aws_elastic_beanstalk_application_version
provides :aws_elastic_beanstalk_application_version, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ElasticBeanstalk::ApplicationVersion
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
           The name of the Elastic Beanstalk application that is associated with this application version.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A description of this application version.
         DESCRIPTION

property :source_bundle, Hash,
         required: true,
         callbacks: {
           "Subproperty `S3Bucket` is not a String" => lambda { |v| v[:S3Bucket].is_a? String },
           "Subproperty `S3Key` is not a String" => lambda { |v| v[:S3Key].is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon S3 bucket and key that identify the location of the source bundle for this version.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ElasticBeanstalk::ApplicationVersion"
rest_api_document "/AWS::ElasticBeanstalk::ApplicationVersion"

rest_property_map({
  application_name: "ApplicationName",
  description:      "Description",
  source_bundle:    "SourceBundle",
})

rest_post_only_properties %i{
  application_name source_bundle
}
