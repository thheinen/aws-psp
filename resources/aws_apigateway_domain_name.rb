# Import API specifics
use "awscc_base"

resource_name :aws_apigateway_domain_name
provides :aws_apigateway_domain_name, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ApiGateway::DomainName.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :certificate_arn, String,
         callbacks: {
           "certificate_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :domain_name, String,
         callbacks: {
           "domain_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :endpoint_configuration, Hash,
         callbacks: {
           "Subproperty `Types` is not a Array" => lambda { |v| v[:Types].is_a? Array },
         },
         description: ""

property :mutual_tls_authentication, Hash,
         callbacks: {
           "Subproperty `TruststoreUri` is not a String" => lambda { |v| v[:TruststoreUri].is_a? String },
           "Subproperty `TruststoreVersion` is not a String" => lambda { |v| v[:TruststoreVersion].is_a? String },
         },
         description: ""

property :ownership_verification_certificate_arn, String,
         callbacks: {
           "ownership_verification_certificate_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :regional_certificate_arn, String,
         callbacks: {
           "regional_certificate_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :security_policy, String,
         callbacks: {
           "security_policy is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::ApiGateway::DomainName"
rest_api_document "/AWS::ApiGateway::DomainName"

rest_property_map({
  certificate_arn:                        "CertificateArn",
  domain_name:                            "DomainName",
  endpoint_configuration:                 "EndpointConfiguration",
  mutual_tls_authentication:              "MutualTlsAuthentication",
  ownership_verification_certificate_arn: "OwnershipVerificationCertificateArn",
  regional_certificate_arn:               "RegionalCertificateArn",
  security_policy:                        "SecurityPolicy",
  tags:                                   "Tags",
})

rest_post_only_properties %i{
  domain_name
}
