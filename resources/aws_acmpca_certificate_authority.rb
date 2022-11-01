# Import API specifics
use "awscc_base"

resource_name :aws_acmpca_certificate_authority
provides :aws_acmpca_certificate_authority, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Private certificate authority.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :csr_extensions, Hash,
         description: <<~'DESCRIPTION'
           Structure that contains CSR pass through extension information used by the CreateCertificateAuthority action.
         DESCRIPTION

property :key_algorithm, String,
         required: true,
         callbacks: {
           "key_algorithm is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Public key algorithm and size, in bits, of the key pair that your CA creates when it issues a certificate.
         DESCRIPTION

property :key_storage_security_standard, String,
         callbacks: {
           "key_storage_security_standard is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           KeyStorageSecurityStadard defines a cryptographic key management compliance standard used for handling CA keys.
         DESCRIPTION

property :revocation_configuration, Hash,
         description: <<~'DESCRIPTION'
           Certificate revocation information used by the CreateCertificateAuthority and UpdateCertificateAuthority actions.
         DESCRIPTION

property :signing_algorithm, String,
         required: true,
         callbacks: {
           "signing_algorithm is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Algorithm your CA uses to sign certificate requests.
         DESCRIPTION

property :subject, Hash,
         required: true,
         callbacks: {
           "Subproperty `Country` is not a String" => lambda { |v| v[:Country].is_a? String },
           "Subproperty `Organization` is not a String" => lambda { |v| v[:Organization].is_a? String },
           "Subproperty `OrganizationalUnit` is not a String" => lambda { |v| v[:OrganizationalUnit].is_a? String },
           "Subproperty `DistinguishedNameQualifier` is not a String" => lambda { |v| v[:DistinguishedNameQualifier].is_a? String },
           "Subproperty `State` is not a String" => lambda { |v| v[:State].is_a? String },
           "Subproperty `CommonName` is not a String" => lambda { |v| v[:CommonName].is_a? String },
           "Subproperty `SerialNumber` is not a String" => lambda { |v| v[:SerialNumber].is_a? String },
           "Subproperty `Locality` is not a String" => lambda { |v| v[:Locality].is_a? String },
           "Subproperty `Title` is not a String" => lambda { |v| v[:Title].is_a? String },
           "Subproperty `Surname` is not a String" => lambda { |v| v[:Surname].is_a? String },
           "Subproperty `GivenName` is not a String" => lambda { |v| v[:GivenName].is_a? String },
           "Subproperty `Initials` is not a String" => lambda { |v| v[:Initials].is_a? String },
           "Subproperty `Pseudonym` is not a String" => lambda { |v| v[:Pseudonym].is_a? String },
           "Subproperty `GenerationQualifier` is not a String" => lambda { |v| v[:GenerationQualifier].is_a? String },
         },
         description: <<~'DESCRIPTION'
           Structure that contains X.500 distinguished name information for your CA.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :type, String,
         required: true,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The type of the certificate authority.
         DESCRIPTION

property :usage_mode, String,
         callbacks: {
           "usage_mode is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Usage mode of the ceritificate authority.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ACMPCA::CertificateAuthority"
rest_api_document "/AWS::ACMPCA::CertificateAuthority"

rest_property_map({
  csr_extensions:                "CsrExtensions",
  key_algorithm:                 "KeyAlgorithm",
  key_storage_security_standard: "KeyStorageSecurityStandard",
  revocation_configuration:      "RevocationConfiguration",
  signing_algorithm:             "SigningAlgorithm",
  subject:                       "Subject",
  tags:                          "Tags",
  type:                          "Type",
  usage_mode:                    "UsageMode",
})

rest_post_only_properties %i{
  csr_extensions key_algorithm key_storage_security_standard signing_algorithm subject type usage_mode
}
