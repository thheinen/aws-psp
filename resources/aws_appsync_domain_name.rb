# Import API specifics
use "awscc_base"

resource_name :aws_appsync_domain_name
provides :aws_appsync_domain_name, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::AppSync::DomainName
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :certificate_arn, String,
         required: true,
         callbacks: {
           "certificate_arn is not a String" => lambda { |v| v.is_a? String },
           "certificate_arn needs to be 3..2048 characters" => lambda { |v| v.length >= 3 && v.length <= 2048 },
           "certificate_arn must match pattern ^arn:[a-z-]*:acm:[a-z0-9-]*:\d{12}:certificate/[0-9A-Za-z_/-]*$" => lambda { |v| v =~ Regexp.new("/^arn:[a-z-]*:acm:[a-z0-9-]*:\d{12}:certificate/[0-9A-Za-z_/-]*$/") },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..255 characters" => lambda { |v| v.length >= 0 && v.length <= 255 },
         },
         description: ""

property :domain_name, String,
         required: true,
         callbacks: {
           "domain_name is not a String" => lambda { |v| v.is_a? String },
           "domain_name needs to be 1..253 characters" => lambda { |v| v.length >= 1 && v.length <= 253 },
           "domain_name must match pattern ^(\*[a-z\d-]*\.)?([a-z\d-]+\.)+[a-z\d-]+$" => lambda { |v| v =~ Regexp.new("/^(\*[a-z\d-]*\.)?([a-z\d-]+\.)+[a-z\d-]+$/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::AppSync::DomainName"
rest_api_document "/AWS::AppSync::DomainName"

rest_property_map({
  certificate_arn: "CertificateArn",
  description:     "Description",
  domain_name:     "DomainName",
})

rest_post_only_properties %i{
  certificate_arn domain_name
}
