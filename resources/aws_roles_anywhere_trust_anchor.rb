# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_roles_anywhere_trust_anchor
provides :aws_roles_anywhere_trust_anchor, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::RolesAnywhere::TrustAnchor Resource Type.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

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

property :source, Hash,
         required: true,
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::RolesAnywhere::TrustAnchor"
rest_api_document "/AWS::RolesAnywhere::TrustAnchor"

rest_property_map({
  enabled: "Enabled",
  name:    "Name",
  source:  "Source",
  tags:    "Tags",
})

