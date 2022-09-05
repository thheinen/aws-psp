# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_lightsail_certificate
provides :aws_lightsail_certificate, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  An example resource schema demonstrating some basic constructs and validation rules.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :certificate_name, String,
         required: true,
         callbacks: {
           "certificate_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name for the certificate.
         DESCRIPTION

property :domain_name, String,
         required: true,
         callbacks: {
           "domain_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The domain name (e.g., example.com ) for the certificate.
         DESCRIPTION

property :subject_alternative_names, Array,
         callbacks: {
           "subject_alternative_names is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of strings that specify the alternate domains (e.g., example2.com) and subdomains (e.g., blog.example.com) for the certificate.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Lightsail::Certificate"
rest_api_document "/AWS::Lightsail::Certificate"

rest_property_map({
  certificate_name:          "CertificateName",
  domain_name:               "DomainName",
  subject_alternative_names: "SubjectAlternativeNames",
  tags:                      "Tags",
})

rest_post_only_properties %i{
  certificate_name domain_name subject_alternative_names
}
