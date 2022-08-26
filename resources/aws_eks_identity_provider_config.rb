# Import API specifics
use "awscc_base"

resource_name :aws_eks_identity_provider_config
provides :aws_eks_identity_provider_config, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  An object representing an Amazon EKS IdentityProviderConfig.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :cluster_name, String,
         required: true,
         callbacks: {
           "cluster_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The name of the identity provider configuration."

property :identity_provider_config_name, String,
         callbacks: {
           "identity_provider_config_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The name of the OIDC provider configuration."

property :oidc, Hash,
         callbacks: {
           "Subproperty `ClientId` is not a String" => lambda { |v| v[:ClientId].is_a? String },
           "Subproperty `GroupsClaim` is not a String" => lambda { |v| v[:GroupsClaim].is_a? String },
           "Subproperty `GroupsPrefix` is not a String" => lambda { |v| v[:GroupsPrefix].is_a? String },
           "Subproperty `IssuerUrl` is not a String" => lambda { |v| v[:IssuerUrl].is_a? String },
           "Subproperty `RequiredClaims` is not a Array" => lambda { |v| v[:RequiredClaims].is_a? Array },
           "Subproperty `UsernameClaim` is not a String" => lambda { |v| v[:UsernameClaim].is_a? String },
           "Subproperty `UsernamePrefix` is not a String" => lambda { |v| v[:UsernamePrefix].is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "An array of key-value pairs to apply to this resource."

property :type, String,
         required: true,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
           "typeis not one of `oidc`" => lambda { |v| %w{oidc}.include? v },
         },
         description: "The type of the identity provider configuration."

# API URLs and mappings
rest_api_collection "/AWS::EKS::IdentityProviderConfig"
rest_api_document "/AWS::EKS::IdentityProviderConfig"

rest_property_map({
  cluster_name:                  "ClusterName",
  identity_provider_config_name: "IdentityProviderConfigName",
  oidc:                          "Oidc",
  tags:                          "Tags",
  type:                          "Type",
})

rest_post_only_properties %i{
  cluster_name identity_provider_config_name oidc type
}
