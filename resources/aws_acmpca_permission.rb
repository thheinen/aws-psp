# Import API specifics
use "awscc_base"

resource_name :aws_acmpca_permission
provides :aws_acmpca_permission, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Permission set on private certificate authority
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :actions, Array,
         required: true,
         callbacks: {
           "actions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The actions that the specified AWS service principal can use. Actions IssueCertificate, GetCertificate and ListPermissions must be provided."

property :certificate_authority_arn, String,
         required: true,
         callbacks: {
           "certificate_authority_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The Amazon Resource Name (ARN) of the Private Certificate Authority that grants the permission."

property :principal, String,
         required: true,
         callbacks: {
           "principal is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The AWS service or identity that receives the permission. At this time, the only valid principal is acm.amazonaws.com."

property :source_account, String,
         callbacks: {
           "source_account is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The ID of the calling account."

# API URLs and mappings
rest_api_collection "/AWS::ACMPCA::Permission"
rest_api_document "/AWS::ACMPCA::Permission"

rest_property_map({
  actions:                   "Actions",
  certificate_authority_arn: "CertificateAuthorityArn",
  principal:                 "Principal",
  source_account:            "SourceAccount",
})

rest_post_only_properties %i{
  actions certificate_authority_arn principal source_account
}
