# Import API specifics
use "awscc_base"

resource_name :aws_ec2_verified_access_instance
provides :aws_ec2_verified_access_instance, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::EC2::VerifiedAccessInstance resource creates an AWS EC2 Verified Access Instance.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A description for the AWS Verified Access instance.
         DESCRIPTION

property :logging_configurations, Hash,
         callbacks: {
           "Subproperty `LogVersion` is not a String" => lambda { |v| v[:LogVersion].is_a? String },
           "Subproperty `IncludeTrustContext` is not a Boolean" => lambda { |v| v[:IncludeTrustContext].is_a? Boolean },
           "Subproperty `CloudWatchLogs` is not a Object" => lambda { |v| v[:CloudWatchLogs].is_a? Object },
           "Subproperty `KinesisDataFirehose` is not a Object" => lambda { |v| v[:KinesisDataFirehose].is_a? Object },
           "Subproperty `S3` is not a Object" => lambda { |v| v[:S3].is_a? Object },
         },
         description: <<~'DESCRIPTION'
           The configuration options for AWS Verified Access instances.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

property :verified_access_trust_provider_ids, Array,
         callbacks: {
           "verified_access_trust_provider_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The IDs of the AWS Verified Access trust providers.
         DESCRIPTION

property :verified_access_trust_providers, Array,
         callbacks: {
           "verified_access_trust_providers is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           AWS Verified Access trust providers.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::VerifiedAccessInstance"
rest_api_document "/AWS::EC2::VerifiedAccessInstance"

rest_property_map({
  description:                        "Description",
  logging_configurations:             "LoggingConfigurations",
  tags:                               "Tags",
  verified_access_trust_provider_ids: "VerifiedAccessTrustProviderIds",
  verified_access_trust_providers:    "VerifiedAccessTrustProviders",
})

