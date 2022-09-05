# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_ses_email_identity
provides :aws_ses_email_identity, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SES::EmailIdentity
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :configuration_set_attributes, Hash,
         callbacks: {
           "Subproperty `ConfigurationSetName` is not a String" => lambda { |v| v[:ConfigurationSetName].is_a? String },
         },
         description: ""

property :dkim_attributes, Hash,
         callbacks: {
           "Subproperty `SigningEnabled` is not a Boolean" => lambda { |v| v[:SigningEnabled].is_a? Boolean },
         },
         description: ""

property :dkim_signing_attributes, Hash,
         callbacks: {
           "Subproperty `DomainSigningSelector` is not a String" => lambda { |v| v[:DomainSigningSelector].is_a? String },
           "Subproperty `DomainSigningPrivateKey` is not a String" => lambda { |v| v[:DomainSigningPrivateKey].is_a? String },
           "Subproperty `NextSigningKeyLength` is not a String" => lambda { |v| v[:NextSigningKeyLength].is_a? String },
           "Subproperty `NextSigningKeyLength` must match pattern RSA_1024_BIT|RSA_2048_BIT" => lambda { |v| v[:NextSigningKeyLength] =~ Regexp.new("/RSA_1024_BIT|RSA_2048_BIT/") },
         },
         description: ""

property :email_identity, String,
         required: true,
         callbacks: {
           "email_identity is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The email address or domain to verify.
         DESCRIPTION

property :feedback_attributes, Hash,
         callbacks: {
           "Subproperty `EmailForwardingEnabled` is not a Boolean" => lambda { |v| v[:EmailForwardingEnabled].is_a? Boolean },
         },
         description: ""

property :mail_from_attributes, Hash,
         callbacks: {
           "Subproperty `MailFromDomain` is not a String" => lambda { |v| v[:MailFromDomain].is_a? String },
           "Subproperty `BehaviorOnMxFailure` is not a String" => lambda { |v| v[:BehaviorOnMxFailure].is_a? String },
           "Subproperty `BehaviorOnMxFailure` must match pattern USE_DEFAULT_VALUE|REJECT_MESSAGE" => lambda { |v| v[:BehaviorOnMxFailure] =~ Regexp.new("/USE_DEFAULT_VALUE|REJECT_MESSAGE/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::SES::EmailIdentity"
rest_api_document "/AWS::SES::EmailIdentity"

rest_property_map({
  configuration_set_attributes: "ConfigurationSetAttributes",
  dkim_attributes:              "DkimAttributes",
  dkim_signing_attributes:      "DkimSigningAttributes",
  email_identity:               "EmailIdentity",
  feedback_attributes:          "FeedbackAttributes",
  mail_from_attributes:         "MailFromAttributes",
})

rest_post_only_properties %i{
  email_identity
}
