# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_iot_certificate
provides :aws_iot_certificate, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Use the AWS::IoT::Certificate resource to declare an AWS IoT X.509 certificate.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :ca_certificate_pem, String,
         callbacks: {
           "ca_certificate_pem is not a String" => lambda { |v| v.is_a? String },
           "ca_certificate_pem needs to be 1..65536 characters" => lambda { |v| v.length >= 1 && v.length <= 65536 },
         },
         description: ""

property :certificate_mode, String,
         callbacks: {
           "certificate_mode is not a String" => lambda { |v| v.is_a? String },
           "certificate_modeis not one of `DEFAULT`, `SNI_ONLY`" => lambda { |v| %w{DEFAULT SNI_ONLY}.include? v },
         },
         description: ""

property :certificate_pem, String,
         callbacks: {
           "certificate_pem is not a String" => lambda { |v| v.is_a? String },
           "certificate_pem needs to be 1..65536 characters" => lambda { |v| v.length >= 1 && v.length <= 65536 },
         },
         description: ""

property :certificate_signing_request, String,
         callbacks: {
           "certificate_signing_request is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :status, String,
         required: true,
         callbacks: {
           "status is not a String" => lambda { |v| v.is_a? String },
           "statusis not one of `ACTIVE`, `INACTIVE`, `REVOKED`, `PENDING_TRANSFER`, `PENDING_ACTIVATION`" => lambda { |v| %w{ACTIVE INACTIVE REVOKED PENDING_TRANSFER PENDING_ACTIVATION}.include? v },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::IoT::Certificate"
rest_api_document "/AWS::IoT::Certificate"

rest_property_map({
  ca_certificate_pem:          "CACertificatePem",
  certificate_mode:            "CertificateMode",
  certificate_pem:             "CertificatePem",
  certificate_signing_request: "CertificateSigningRequest",
  status:                      "Status",
})

rest_post_only_properties %i{
  ca_certificate_pem certificate_mode certificate_pem certificate_signing_request
}
