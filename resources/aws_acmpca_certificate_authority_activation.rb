# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_acmpca_certificate_authority_activation
provides :aws_acmpca_certificate_authority_activation, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Used to install the certificate authority certificate and update the certificate authority status.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :certificate, String,
         required: true,
         callbacks: {
           "certificate is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Certificate Authority certificate that will be installed in the Certificate Authority.
         DESCRIPTION

property :certificate_authority_arn, String,
         required: true,
         callbacks: {
           "certificate_authority_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Arn of the Certificate Authority.
         DESCRIPTION

property :certificate_chain, String,
         callbacks: {
           "certificate_chain is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Certificate chain for the Certificate Authority certificate.
         DESCRIPTION

property :status, String,
         callbacks: {
           "status is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The status of the Certificate Authority.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ACMPCA::CertificateAuthorityActivation"
rest_api_document "/AWS::ACMPCA::CertificateAuthorityActivation"

rest_property_map({
  certificate:               "Certificate",
  certificate_authority_arn: "CertificateAuthorityArn",
  certificate_chain:         "CertificateChain",
  status:                    "Status",
})

rest_post_only_properties %i{
  certificate_authority_arn
}
