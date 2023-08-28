# Import API specifics
use "awscc_base"

resource_name :aws_pca_connector_ad_template_group_access_control_entry
provides :aws_pca_connector_ad_template_group_access_control_entry, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::PCAConnectorAD::TemplateGroupAccessControlEntry Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :access_rights, Hash,
         required: true,
         description: ""

property :group_display_name, String,
         required: true,
         callbacks: {
           "group_display_name is not a String" => lambda { |v| v.is_a? String },
           "group_display_name needs to be 0..256 characters" => lambda { |v| v.length >= 0 && v.length <= 256 },
           "group_display_name must match pattern ^[\x20-\x7E]+$" => lambda { |v| v =~ Regexp.new("/^[\x20-\x7E]+$/") },
         },
         description: ""

property :group_security_identifier, String,
         callbacks: {
           "group_security_identifier is not a String" => lambda { |v| v.is_a? String },
           "group_security_identifier needs to be 7..256 characters" => lambda { |v| v.length >= 7 && v.length <= 256 },
           "group_security_identifier must match pattern ^S-[0-9]-([0-9]+-){1,14}[0-9]+$" => lambda { |v| v =~ Regexp.new("/^S-[0-9]-([0-9]+-){1,14}[0-9]+$/") },
         },
         description: ""

property :template_arn, String,
         callbacks: {
           "template_arn is not a String" => lambda { |v| v.is_a? String },
           "template_arn needs to be 5..200 characters" => lambda { |v| v.length >= 5 && v.length <= 200 },
           "template_arn must match pattern ^arn:[\w-]+:pca-connector-ad:[\w-]+:[0-9]+:connector(\/[\w-]+)\/template(\/[\w-]+)$" => lambda { |v| v =~ Regexp.new("/^arn:[\w-]+:pca-connector-ad:[\w-]+:[0-9]+:connector(\/[\w-]+)\/template(\/[\w-]+)$/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::PCAConnectorAD::TemplateGroupAccessControlEntry"
rest_api_document "/AWS::PCAConnectorAD::TemplateGroupAccessControlEntry"

rest_property_map({
  access_rights:             "AccessRights",
  group_display_name:        "GroupDisplayName",
  group_security_identifier: "GroupSecurityIdentifier",
  template_arn:              "TemplateArn",
})

rest_post_only_properties %i{
  group_security_identifier template_arn
}
