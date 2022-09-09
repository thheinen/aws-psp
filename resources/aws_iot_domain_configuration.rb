# Import API specifics
use "awscc_base"

resource_name :aws_iot_domain_configuration
provides :aws_iot_domain_configuration, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Create and manage a Domain Configuration
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :authorizer_config, Hash,
         callbacks: {
           "Subproperty `AllowAuthorizerOverride` is not a Boolean" => lambda { |v| v[:AllowAuthorizerOverride].is_a? Boolean },
           "Subproperty `DefaultAuthorizerName` is not a String" => lambda { |v| v[:DefaultAuthorizerName].is_a? String },
           "Subproperty `DefaultAuthorizerName` needs to be 1..128 characters" => lambda { |v| v[:DefaultAuthorizerName].length >= 1 && v[:DefaultAuthorizerName].length <= 128 },
           "Subproperty `DefaultAuthorizerName` must match pattern ^[\w=,@-]+$" => lambda { |v| v[:DefaultAuthorizerName] =~ Regexp.new("/^[\w=,@-]+$/") },
         },
         description: ""

property :domain_configuration_name, String,
         callbacks: {
           "domain_configuration_name is not a String" => lambda { |v| v.is_a? String },
           "domain_configuration_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "domain_configuration_name must match pattern ^[\w.-]+$" => lambda { |v| v =~ Regexp.new("/^[\w.-]+$/") },
         },
         description: ""

property :domain_configuration_status, String,
         callbacks: {
           "domain_configuration_status is not a String" => lambda { |v| v.is_a? String },
           "domain_configuration_statusis not one of `ENABLED`, `DISABLED`" => lambda { |v| %w{ENABLED DISABLED}.include? v },
         },
         description: ""

property :domain_name, String,
         callbacks: {
           "domain_name is not a String" => lambda { |v| v.is_a? String },
           "domain_name needs to be 1..253 characters" => lambda { |v| v.length >= 1 && v.length <= 253 },
         },
         description: ""

property :server_certificate_arns, Array,
         callbacks: {
           "server_certificate_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :service_type, String,
         callbacks: {
           "service_type is not a String" => lambda { |v| v.is_a? String },
           "service_typeis not one of `DATA`, `CREDENTIAL_PROVIDER`, `JOBS`" => lambda { |v| %w{DATA CREDENTIAL_PROVIDER JOBS}.include? v },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :validation_certificate_arn, String,
         callbacks: {
           "validation_certificate_arn is not a String" => lambda { |v| v.is_a? String },
           "validation_certificate_arn must match pattern ^arn:aws(-cn|-us-gov|-iso-b|-iso)?:acm:[a-z]{2}-(gov-|iso-|isob-)?[a-z]{4,9}-\d{1}:\d{12}:certificate/[a-zA-Z0-9/-]+$" => lambda { |v| v =~ Regexp.new("/^arn:aws(-cn|-us-gov|-iso-b|-iso)?:acm:[a-z]{2}-(gov-|iso-|isob-)?[a-z]{4,9}-\d{1}:\d{12}:certificate/[a-zA-Z0-9/-]+$/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::IoT::DomainConfiguration"
rest_api_document "/AWS::IoT::DomainConfiguration"

rest_property_map({
  authorizer_config:           "AuthorizerConfig",
  domain_configuration_name:   "DomainConfigurationName",
  domain_configuration_status: "DomainConfigurationStatus",
  domain_name:                 "DomainName",
  server_certificate_arns:     "ServerCertificateArns",
  service_type:                "ServiceType",
  tags:                        "Tags",
  validation_certificate_arn:  "ValidationCertificateArn",
})

rest_post_only_properties %i{
  domain_configuration_name domain_name server_certificate_arns service_type validation_certificate_arn
}
