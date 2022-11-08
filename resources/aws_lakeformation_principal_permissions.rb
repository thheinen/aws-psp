# Import API specifics
use "awscc_base"

resource_name :aws_lakeformation_principal_permissions
provides :aws_lakeformation_principal_permissions, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  A resource schema representing a Lake Formation Permission.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :catalog, Hash,
         callbacks: {
           "catalog is not a String" => lambda { |v| v.is_a? String },
           "catalog needs to be 12..12 characters" => lambda { |v| v.length >= 12 && v.length <= 12 },
         },
         description: ""

property :permissions, Hash,
         required: true,
         callbacks: {
           "permissions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :permissions_with_grant_option, Hash,
         required: true,
         callbacks: {
           "permissions_with_grant_option is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :principal, Hash,
         required: true,
         description: ""

property :resource, Hash,
         required: true,
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::LakeFormation::PrincipalPermissions"
rest_api_document "/AWS::LakeFormation::PrincipalPermissions"

rest_property_map({
  catalog:                       "Catalog",
  permissions:                   "Permissions",
  permissions_with_grant_option: "PermissionsWithGrantOption",
  principal:                     "Principal",
  resource:                      "Resource",
})

rest_post_only_properties %i{
  catalog permissions permissions_with_grant_option principal resource
}
