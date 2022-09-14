# Import API specifics
use "awscc_base"

resource_name :aws_signer_signing_profile
provides :aws_signer_signing_profile, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  A signing profile is a signing template that can be used to carry out a pre-defined signing job.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :platform_id, Hash,
         required: true,
         callbacks: {
           "platform_id is not a String" => lambda { |v| v.is_a? String },
           "platform_idis not one of `AWSLambda-SHA384-ECDSA`" => lambda { |v| %w{AWSLambda-SHA384-ECDSA}.include? v },
         },
         description: <<~'DESCRIPTION'
           The ID of the target signing platform.
         DESCRIPTION

property :signature_validity_period, Hash,
         callbacks: {
           "Subproperty `Value` is not a Integer" => lambda { |v| v[:Value].is_a? Integer },
           "Subproperty `Type` is not a String" => lambda { |v| v[:Type].is_a? String },
           "Subproperty `Type`is not one of `DAYS`, `MONTHS`, `YEARS`" => lambda { |v| %w{DAYS MONTHS YEARS}.include? v[:Type] },
         },
         description: <<~'DESCRIPTION'
           Signature validity period of the profile.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of tags associated with the signing profile.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Signer::SigningProfile"
rest_api_document "/AWS::Signer::SigningProfile"

rest_property_map({
  platform_id:               "PlatformId",
  signature_validity_period: "SignatureValidityPeriod",
  tags:                      "Tags",
})

rest_post_only_properties %i{
  platform_id signature_validity_period
}
