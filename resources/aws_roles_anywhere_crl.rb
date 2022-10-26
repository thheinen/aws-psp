# Import API specifics
use "awscc_base"

resource_name :aws_roles_anywhere_crl
provides :aws_roles_anywhere_crl, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::RolesAnywhere::CRL Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :crl_data, String,
         callbacks: {
           "crl_data is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :enabled, [TrueClass, FalseClass],
         callbacks: {
           "enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :trust_anchor_arn, String,
         callbacks: {
           "trust_anchor_arn is not a String" => lambda { |v| v.is_a? String },
           "trust_anchor_arn must match pattern ^arn:aws(-[^:]+)?:rolesanywhere(:.*){2}(:trust-anchor.*)$" => lambda { |v| v =~ Regexp.new("/^arn:aws(-[^:]+)?:rolesanywhere(:.*){2}(:trust-anchor.*)$/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::RolesAnywhere::CRL"
rest_api_document "/AWS::RolesAnywhere::CRL"

rest_property_map({
  crl_data:         "CrlData",
  enabled:          "Enabled",
  name:             "Name",
  tags:             "Tags",
  trust_anchor_arn: "TrustAnchorArn",
})

