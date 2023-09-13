# Import API specifics
use "awscc_base"

resource_name :aws_lightsail_container
provides :aws_lightsail_container, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Lightsail::Container
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :container_service_deployment, Hash,
         callbacks: {
           "Subproperty `Containers` is not a Array" => lambda { |v| v[:Containers].is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Describes a container deployment configuration of an Amazon Lightsail container service.
         DESCRIPTION

property :is_disabled, [TrueClass, FalseClass],
         callbacks: {
           "is_disabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A Boolean value to indicate whether the container service is disabled.
         DESCRIPTION

property :power, String,
         required: true,
         callbacks: {
           "power is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The power specification for the container service.
         DESCRIPTION

property :private_registry_access, Hash,
         callbacks: {
           "Subproperty `EcrImagePullerRole` is not a Object" => lambda { |v| v[:EcrImagePullerRole].is_a? Object },
         },
         description: <<~'DESCRIPTION'
           A Boolean value to indicate whether the container service has access to private container image repositories, such as Amazon Elastic Container Registry (Amazon ECR) private repositories.
         DESCRIPTION

property :public_domain_names, Array,
         callbacks: {
           "public_domain_names is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The public domain names to use with the container service, such as example.com and www.example.com.
         DESCRIPTION

property :scale, Integer,
         required: true,
         callbacks: {
           "scale is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The scale specification for the container service.
         DESCRIPTION

property :service_name, String,
         required: true,
         callbacks: {
           "service_name is not a String" => lambda { |v| v.is_a? String },
           "service_name needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
           "service_name must match pattern ^[a-z0-9]{1,2}|[a-z0-9][a-z0-9-]+[a-z0-9]$" => lambda { |v| v =~ Regexp.new("/^[a-z0-9]{1,2}|[a-z0-9][a-z0-9-]+[a-z0-9]$/") },
         },
         description: <<~'DESCRIPTION'
           The name for the container service.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Lightsail::Container"
rest_api_document "/AWS::Lightsail::Container"

rest_property_map({
  container_service_deployment: "ContainerServiceDeployment",
  is_disabled:                  "IsDisabled",
  power:                        "Power",
  private_registry_access:      "PrivateRegistryAccess",
  public_domain_names:          "PublicDomainNames",
  scale:                        "Scale",
  service_name:                 "ServiceName",
  tags:                         "Tags",
})

rest_post_only_properties %i{
  service_name
}
