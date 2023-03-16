# Import API specifics
use "awscc_base"

resource_name :aws_codeartifact_repository
provides :aws_codeartifact_repository, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The resource schema to create a CodeArtifact repository.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A text description of the repository.
         DESCRIPTION

property :domain_name, String,
         required: true,
         callbacks: {
           "domain_name is not a String" => lambda { |v| v.is_a? String },
           "domain_name needs to be 2..50 characters" => lambda { |v| v.length >= 2 && v.length <= 50 },
           "domain_name must match pattern ^([a-z][a-z0-9\-]{0,48}[a-z0-9])$" => lambda { |v| v =~ Regexp.new("/^([a-z][a-z0-9\-]{0,48}[a-z0-9])$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the domain that contains the repository.
         DESCRIPTION

property :external_connections, Array,
         callbacks: {
           "external_connections is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of external connections associated with the repository.
         DESCRIPTION

property :permissions_policy_document, Hash,
         callbacks: {
           "permissions_policy_document is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           The access control resource policy on the provided repository.
         DESCRIPTION

property :repository_name, String,
         required: true,
         callbacks: {
           "repository_name is not a String" => lambda { |v| v.is_a? String },
           "repository_name needs to be 2..100 characters" => lambda { |v| v.length >= 2 && v.length <= 100 },
           "repository_name must match pattern ^([A-Za-z0-9][A-Za-z0-9._\-]{1,99})$" => lambda { |v| v =~ Regexp.new("/^([A-Za-z0-9][A-Za-z0-9._\-]{1,99})$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the repository.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

property :upstreams, Array,
         callbacks: {
           "upstreams is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of upstream repositories associated with the repository.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::CodeArtifact::Repository"
rest_api_document "/AWS::CodeArtifact::Repository"

rest_property_map({
  description:                 "Description",
  domain_name:                 "DomainName",
  external_connections:        "ExternalConnections",
  permissions_policy_document: "PermissionsPolicyDocument",
  repository_name:             "RepositoryName",
  tags:                        "Tags",
  upstreams:                   "Upstreams",
})

rest_post_only_properties %i{
  domain_name domain_owner repository_name
}
