# Import API specifics
use "awscc_base"

resource_name :aws_transfer_certificate
provides :aws_transfer_certificate, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Transfer::Certificate
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :active_date, String,
         callbacks: {
           "active_date is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies the active date for the certificate.
         DESCRIPTION

property :certificate, String,
         required: true,
         callbacks: {
           "certificate is not a String" => lambda { |v| v.is_a? String },
           "certificate needs to be 1..16384 characters" => lambda { |v| v.length >= 1 && v.length <= 16384 },
           "certificate must match pattern ^[	
           -ÿ]*" => lambda { |v| v =~ Regexp.new("/^[	
           -ÿ]*/") },
         },
         description: <<~'DESCRIPTION'
           Specifies the certificate body to be imported.
         DESCRIPTION

property :certificate_chain, String,
         callbacks: {
           "certificate_chain is not a String" => lambda { |v| v.is_a? String },
           "certificate_chain needs to be 1..2097152 characters" => lambda { |v| v.length >= 1 && v.length <= 2097152 },
           "certificate_chain must match pattern ^[	
           -ÿ]*" => lambda { |v| v =~ Regexp.new("/^[	
           -ÿ]*/") },
         },
         description: <<~'DESCRIPTION'
           Specifies the certificate chain to be imported.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..200 characters" => lambda { |v| v.length >= 1 && v.length <= 200 },
           "description must match pattern ^[\w\- ]*$" => lambda { |v| v =~ Regexp.new("/^[\w\- ]*$/") },
         },
         description: <<~'DESCRIPTION'
           A textual description for the certificate.
         DESCRIPTION

property :inactive_date, String,
         callbacks: {
           "inactive_date is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies the inactive date for the certificate.
         DESCRIPTION

property :private_key, String,
         callbacks: {
           "private_key is not a String" => lambda { |v| v.is_a? String },
           "private_key needs to be 1..16384 characters" => lambda { |v| v.length >= 1 && v.length <= 16384 },
           "private_key must match pattern ^[	
           -ÿ]*" => lambda { |v| v =~ Regexp.new("/^[	
           -ÿ]*/") },
         },
         description: <<~'DESCRIPTION'
           Specifies the private key for the certificate.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Key-value pairs that can be used to group and search for certificates. Tags are metadata attached to certificates for any purpose.
         DESCRIPTION

property :usage, String,
         required: true,
         callbacks: {
           "usage is not a String" => lambda { |v| v.is_a? String },
           "usageis not one of `SIGNING`, `ENCRYPTION`" => lambda { |v| %w{SIGNING ENCRYPTION}.include? v },
         },
         description: <<~'DESCRIPTION'
           Specifies the usage type for the certificate.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Transfer::Certificate"
rest_api_document "/AWS::Transfer::Certificate"

rest_property_map({
  active_date:       "ActiveDate",
  certificate:       "Certificate",
  certificate_chain: "CertificateChain",
  description:       "Description",
  inactive_date:     "InactiveDate",
  private_key:       "PrivateKey",
  tags:              "Tags",
  usage:             "Usage",
})

rest_post_only_properties %i{
  certificate certificate_chain private_key
}
