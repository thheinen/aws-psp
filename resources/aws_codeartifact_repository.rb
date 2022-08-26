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
         description: "A text description of the repository."

property :external_connections, Array,
         callbacks: {
           "external_connections is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "A list of external connections associated with the repository."

property :permissions_policy_document, Hash,
         callbacks: {
           "permissions_policy_document is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: "The access control resource policy on the provided repository."

property :repository_name, String,
         required: true,
         callbacks: {
           "repository_name is not a String" => lambda { |v| v.is_a? String },
           "repository_name needs to be 2..100 characters" => lambda { |v| v.length >= 2 && v.length <= 100 },
           "repository_name must match pattern ^([A-Za-z0-9][A-Za-z0-9._\-]{1,99})$" => lambda { |v| v =~ Regexp.new("/^([A-Za-z0-9][A-Za-z0-9._\-]{1,99})$/") },
         },
         description: "The name of the repository."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "An array of key-value pairs to apply to this resource."

property :upstreams, Array,
         callbacks: {
           "upstreams is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "A list of upstream repositories associated with the repository."

# API URLs and mappings
rest_api_collection "/AWS::CodeArtifact::Repository"
rest_api_document "/AWS::CodeArtifact::Repository"

rest_property_map({
  description:                 "Description",
  external_connections:        "ExternalConnections",
  permissions_policy_document: "PermissionsPolicyDocument",
  repository_name:             "RepositoryName",
  tags:                        "Tags",
  upstreams:                   "Upstreams",
})

rest_post_only_properties %i{
  domain_name domain_owner repository_name
}
