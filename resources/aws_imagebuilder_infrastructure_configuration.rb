# Import API specifics
use "awscc_base"

resource_name :aws_imagebuilder_infrastructure_configuration
provides :aws_imagebuilder_infrastructure_configuration, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::ImageBuilder::InfrastructureConfiguration
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The description of the infrastructure configuration."

property :instance_metadata_options, Hash,
         callbacks: {
           "Subproperty `HttpPutResponseHopLimit` is not a Integer" => lambda { |v| v[:HttpPutResponseHopLimit].is_a? Integer },
           "Subproperty `HttpTokens` is not a String" => lambda { |v| v[:HttpTokens].is_a? String },
           "Subproperty `HttpTokens`is not one of `required`, `optional`" => lambda { |v| %w{required optional}.include? v[:HttpTokens] },
         },
         description: "The instance metadata option settings for the infrastructure configuration."

property :instance_profile_name, String,
         required: true,
         callbacks: {
           "instance_profile_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The instance profile of the infrastructure configuration."

property :instance_types, Array,
         callbacks: {
           "instance_types is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The instance types of the infrastructure configuration."

property :key_pair, String,
         callbacks: {
           "key_pair is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The EC2 key pair of the infrastructure configuration.."

property :logging, Hash,
         description: "The logging configuration of the infrastructure configuration."

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The name of the infrastructure configuration."

property :resource_tags, Hash,
         callbacks: {
           "resource_tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: "The tags attached to the resource created by Image Builder."

property :security_group_ids, Array,
         callbacks: {
           "security_group_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The security group IDs of the infrastructure configuration."

property :sns_topic_arn, String,
         callbacks: {
           "sns_topic_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The SNS Topic Amazon Resource Name (ARN) of the infrastructure configuration."

property :subnet_id, String,
         callbacks: {
           "subnet_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The subnet ID of the infrastructure configuration."

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: "The tags associated with the component."

property :terminate_instance_on_failure, [TrueClass, FalseClass],
         callbacks: {
           "terminate_instance_on_failure is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: "The terminate instance on failure configuration of the infrastructure configuration."

# API URLs and mappings
rest_api_collection "/AWS::ImageBuilder::InfrastructureConfiguration"
rest_api_document "/AWS::ImageBuilder::InfrastructureConfiguration"

rest_property_map({
  description:                   "Description",
  instance_metadata_options:     "InstanceMetadataOptions",
  instance_profile_name:         "InstanceProfileName",
  instance_types:                "InstanceTypes",
  key_pair:                      "KeyPair",
  logging:                       "Logging",
  name:                          "Name",
  resource_tags:                 "ResourceTags",
  security_group_ids:            "SecurityGroupIds",
  sns_topic_arn:                 "SnsTopicArn",
  subnet_id:                     "SubnetId",
  tags:                          "Tags",
  terminate_instance_on_failure: "TerminateInstanceOnFailure",
})

rest_post_only_properties %i{
  name
}
