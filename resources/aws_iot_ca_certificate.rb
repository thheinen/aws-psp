# Import API specifics
use "awscc_base"

resource_name :aws_iot_ca_certificate
provides :aws_iot_ca_certificate, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Registers a CA Certificate in IoT.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :auto_registration_status, String,
         callbacks: {
           "auto_registration_status is not a String" => lambda { |v| v.is_a? String },
           "auto_registration_statusis not one of `ENABLE`, `DISABLE`" => lambda { |v| %w{ENABLE DISABLE}.include? v },
         },
         description: ""

property :ca_certificate_pem, String,
         required: true,
         callbacks: {
           "ca_certificate_pem is not a String" => lambda { |v| v.is_a? String },
           "ca_certificate_pem needs to be 1..65536 characters" => lambda { |v| v.length >= 1 && v.length <= 65536 },
           "ca_certificate_pem must match pattern [\s\S]*" => lambda { |v| v =~ Regexp.new("/[\s\S]*/") },
         },
         description: ""

property :certificate_mode, String,
         callbacks: {
           "certificate_mode is not a String" => lambda { |v| v.is_a? String },
           "certificate_modeis not one of `DEFAULT`, `SNI_ONLY`" => lambda { |v| %w{DEFAULT SNI_ONLY}.include? v },
         },
         description: ""

property :registration_config, Hash,
         callbacks: {
           "Subproperty `TemplateBody` is not a String" => lambda { |v| v[:TemplateBody].is_a? String },
           "Subproperty `TemplateBody` needs to be 0..10240 characters" => lambda { |v| v[:TemplateBody].length >= 0 && v[:TemplateBody].length <= 10240 },
           "Subproperty `TemplateBody` must match pattern [\s\S]*" => lambda { |v| v[:TemplateBody] =~ Regexp.new("/[\s\S]*/") },
           "Subproperty `RoleArn` is not a String" => lambda { |v| v[:RoleArn].is_a? String },
           "Subproperty `RoleArn` needs to be 20..2048 characters" => lambda { |v| v[:RoleArn].length >= 20 && v[:RoleArn].length <= 2048 },
           "Subproperty `RoleArn` must match pattern arn:(aws[a-zA-Z-]*)?:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+" => lambda { |v| v[:RoleArn] =~ Regexp.new("/arn:(aws[a-zA-Z-]*)?:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+/") },
           "Subproperty `RoleArn`is not a valid ARN" => lambda { |v| v[:RoleArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `TemplateName` is not a String" => lambda { |v| v[:TemplateName].is_a? String },
           "Subproperty `TemplateName` needs to be 1..36 characters" => lambda { |v| v[:TemplateName].length >= 1 && v[:TemplateName].length <= 36 },
           "Subproperty `TemplateName` must match pattern ^[0-9A-Za-z_-]+$" => lambda { |v| v[:TemplateName] =~ Regexp.new("/^[0-9A-Za-z_-]+$/") },
         },
         description: ""

property :remove_auto_registration, [TrueClass, FalseClass],
         callbacks: {
           "remove_auto_registration is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :status, String,
         required: true,
         callbacks: {
           "status is not a String" => lambda { |v| v.is_a? String },
           "statusis not one of `ACTIVE`, `INACTIVE`" => lambda { |v| %w{ACTIVE INACTIVE}.include? v },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

property :verification_certificate_pem, String,
         callbacks: {
           "verification_certificate_pem is not a String" => lambda { |v| v.is_a? String },
           "verification_certificate_pem needs to be 1..65536 characters" => lambda { |v| v.length >= 1 && v.length <= 65536 },
           "verification_certificate_pem must match pattern [\s\S]*" => lambda { |v| v =~ Regexp.new("/[\s\S]*/") },
         },
         description: <<~'DESCRIPTION'
           The private key verification certificate.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IoT::CACertificate"
rest_api_document "/AWS::IoT::CACertificate"

rest_property_map({
  auto_registration_status:     "AutoRegistrationStatus",
  ca_certificate_pem:           "CACertificatePem",
  certificate_mode:             "CertificateMode",
  registration_config:          "RegistrationConfig",
  remove_auto_registration:     "RemoveAutoRegistration",
  status:                       "Status",
  tags:                         "Tags",
  verification_certificate_pem: "VerificationCertificatePem",
})

rest_post_only_properties %i{
  ca_certificate_pem certificate_mode verification_certificate_pem
}
