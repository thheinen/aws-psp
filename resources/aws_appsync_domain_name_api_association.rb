# Import API specifics
use "awscc_base"

resource_name :aws_appsync_domain_name_api_association
provides :aws_appsync_domain_name_api_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::AppSync::DomainNameApiAssociation
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :api_id, String,
         required: true,
         callbacks: {
           "api_id is not a String" => lambda { |v| v.is_a? String },
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
rest_api_collection "/AWS::AppSync::DomainNameApiAssociation"
rest_api_document "/AWS::AppSync::DomainNameApiAssociation"

rest_property_map({
  api_id:      "ApiId",
  domain_name: "DomainName",
})

rest_post_only_properties %i{
  domain_name
}
