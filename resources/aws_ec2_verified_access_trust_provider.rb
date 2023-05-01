# Import API specifics
use "awscc_base"

resource_name :aws_ec2_verified_access_trust_provider
provides :aws_ec2_verified_access_trust_provider, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::EC2::VerifiedAccessTrustProvider type describes a verified access trust provider
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A description for the Amazon Web Services Verified Access trust provider.
         DESCRIPTION

property :device_options, Hash,
         callbacks: {
           "Subproperty `TenantId` is not a String" => lambda { |v| v[:TenantId].is_a? String },
         },
         description: ""

property :device_trust_provider_type, String,
         callbacks: {
           "device_trust_provider_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The type of device-based trust provider. Possible values: jamf|crowdstrike
         DESCRIPTION

property :oidc_options, Hash,
         callbacks: {
           "Subproperty `Issuer` is not a String" => lambda { |v| v[:Issuer].is_a? String },
           "Subproperty `AuthorizationEndpoint` is not a String" => lambda { |v| v[:AuthorizationEndpoint].is_a? String },
           "Subproperty `TokenEndpoint` is not a String" => lambda { |v| v[:TokenEndpoint].is_a? String },
           "Subproperty `UserInfoEndpoint` is not a String" => lambda { |v| v[:UserInfoEndpoint].is_a? String },
           "Subproperty `ClientId` is not a String" => lambda { |v| v[:ClientId].is_a? String },
           "Subproperty `ClientSecret` is not a String" => lambda { |v| v[:ClientSecret].is_a? String },
           "Subproperty `Scope` is not a String" => lambda { |v| v[:Scope].is_a? String },
         },
         description: ""

property :policy_reference_name, String,
         required: true,
         callbacks: {
           "policy_reference_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The identifier to be used when working with policy rules.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

property :trust_provider_type, String,
         required: true,
         callbacks: {
           "trust_provider_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Type of trust provider. Possible values: user|device
         DESCRIPTION

property :user_trust_provider_type, String,
         callbacks: {
           "user_trust_provider_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The type of device-based trust provider. Possible values: oidc|iam-identity-center
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::VerifiedAccessTrustProvider"
rest_api_document "/AWS::EC2::VerifiedAccessTrustProvider"

rest_property_map({
  description:                "Description",
  device_options:             "DeviceOptions",
  device_trust_provider_type: "DeviceTrustProviderType",
  oidc_options:               "OidcOptions",
  policy_reference_name:      "PolicyReferenceName",
  tags:                       "Tags",
  trust_provider_type:        "TrustProviderType",
  user_trust_provider_type:   "UserTrustProviderType",
})

rest_post_only_properties %i{
  device_options device_trust_provider_type policy_reference_name trust_provider_type user_trust_provider_type
}
