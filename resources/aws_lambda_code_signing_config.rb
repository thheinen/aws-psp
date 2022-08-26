# Import API specifics
use "awscc_base"

resource_name :aws_lambda_code_signing_config
provides :aws_lambda_code_signing_config, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Lambda::CodeSigningConfig.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :allowed_publishers, Hash,
         required: true,
         callbacks: {
           "Subproperty `SigningProfileVersionArns` is not a Array" => lambda { |v| v[:SigningProfileVersionArns].is_a? Array },
         },
         description: "When the CodeSigningConfig is later on attached to a function, the function code will be expected to be signed by profiles from this list"

property :code_signing_policies, Hash,
         callbacks: {
           "Subproperty `UntrustedArtifactOnDeployment` is not a String" => lambda { |v| v[:UntrustedArtifactOnDeployment].is_a? String },
           "Subproperty `UntrustedArtifactOnDeployment`is not one of `Warn`, `Enforce`" => lambda { |v| %w{Warn Enforce}.include? v[:UntrustedArtifactOnDeployment] },
         },
         description: "Policies to control how to act if a signature is invalid"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..256 characters" => lambda { |v| v.length >= 0 && v.length <= 256 },
         },
         description: "A description of the CodeSigningConfig"

# API URLs and mappings
rest_api_collection "/AWS::Lambda::CodeSigningConfig"
rest_api_document "/AWS::Lambda::CodeSigningConfig"

rest_property_map({
  allowed_publishers:    "AllowedPublishers",
  code_signing_policies: "CodeSigningPolicies",
  description:           "Description",
})

