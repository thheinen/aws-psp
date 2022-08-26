# Import API specifics
use "awscc_base"

resource_name :aws_acmpca_certificate
provides :aws_acmpca_certificate, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  A certificate issued via a private certificate authority
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :api_passthrough, Hash,
         description: "These are fields to be overridden in a certificate at the time of issuance. These requires an API_Passthrough template be used or they will be ignored."

property :certificate_authority_arn, Hash,
         required: true,
         callbacks: {
           "certificate_authority_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The Amazon Resource Name (ARN) for the private CA to issue the certificate."

property :certificate_signing_request, String,
         required: true,
         callbacks: {
           "certificate_signing_request is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The certificate signing request (CSR) for the Certificate."

property :signing_algorithm, String,
         required: true,
         callbacks: {
           "signing_algorithm is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The name of the algorithm that will be used to sign the Certificate."

property :template_arn, Hash,
         callbacks: {
           "template_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: "Specifies a custom configuration template to use when issuing a certificate. If this parameter is not provided, ACM Private CA defaults to the EndEntityCertificate/V1 template."

property :validity, Hash,
         required: true,
         callbacks: {
           "Subproperty `Value` is not a Number" => lambda { |v| v[:Value].is_a? Number },
           "Subproperty `Type` is not a String" => lambda { |v| v[:Type].is_a? String },
         },
         description: "The time before which the Certificate will be valid."

property :validity_not_before, Hash,
         callbacks: {
           "Subproperty `Value` is not a Number" => lambda { |v| v[:Value].is_a? Number },
           "Subproperty `Type` is not a String" => lambda { |v| v[:Type].is_a? String },
         },
         description: "The time after which the Certificate will be valid."

# API URLs and mappings
rest_api_collection "/AWS::ACMPCA::Certificate"
rest_api_document "/AWS::ACMPCA::Certificate"

rest_property_map({
  api_passthrough:             "ApiPassthrough",
  certificate_authority_arn:   "CertificateAuthorityArn",
  certificate_signing_request: "CertificateSigningRequest",
  signing_algorithm:           "SigningAlgorithm",
  template_arn:                "TemplateArn",
  validity:                    "Validity",
  validity_not_before:         "ValidityNotBefore",
})

rest_post_only_properties %i{
  api_passthrough certificate_authority_arn certificate_signing_request signing_algorithm template_arn validity validity_not_before
}
