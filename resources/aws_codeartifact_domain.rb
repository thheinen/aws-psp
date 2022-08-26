# Import API specifics
use "awscc_base"

resource_name :aws_codeartifact_domain
provides :aws_codeartifact_domain, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The resource schema to create a CodeArtifact domain.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :domain_name, String,
         required: true,
         callbacks: {
           "domain_name is not a String" => lambda { |v| v.is_a? String },
           "domain_name needs to be 2..50 characters" => lambda { |v| v.length >= 2 && v.length <= 50 },
           "domain_name must match pattern ^([a-z][a-z0-9\-]{0,48}[a-z0-9])$" => lambda { |v| v =~ Regexp.new("/^([a-z][a-z0-9\-]{0,48}[a-z0-9])$/") },
         },
         description: "The name of the domain."

property :permissions_policy_document, Hash,
         callbacks: {
           "permissions_policy_document is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: "The access control resource policy on the provided domain."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "An array of key-value pairs to apply to this resource."

# API URLs and mappings
rest_api_collection "/AWS::CodeArtifact::Domain"
rest_api_document "/AWS::CodeArtifact::Domain"

rest_property_map({
  domain_name:                 "DomainName",
  permissions_policy_document: "PermissionsPolicyDocument",
  tags:                        "Tags",
})

rest_post_only_properties %i{
  domain_name encryption_key
}
