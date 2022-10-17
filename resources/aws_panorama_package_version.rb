# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_panorama_package_version
provides :aws_panorama_package_version, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Schema for PackageVersion Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :mark_latest, [TrueClass, FalseClass],
         callbacks: {
           "mark_latest is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :owner_account, Hash,
         callbacks: {
           "owner_account is not a String" => lambda { |v| v.is_a? String },
           "owner_account needs to be 1..12 characters" => lambda { |v| v.length >= 1 && v.length <= 12 },
           "owner_account must match pattern ^[0-9a-z\_]+$" => lambda { |v| v =~ Regexp.new("/^[0-9a-z\_]+$/") },
         },
         description: ""

property :package_id, Hash,
         required: true,
         callbacks: {
           "package_id is not a String" => lambda { |v| v.is_a? String },
           "package_id needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "package_id must match pattern ^[a-zA-Z0-9\-\_\/]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9\-\_\/]+$/") },
         },
         description: ""

property :package_version, Hash,
         required: true,
         callbacks: {
           "package_version is not a String" => lambda { |v| v.is_a? String },
           "package_version needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "package_version must match pattern ^([0-9]+)\.([0-9]+)$" => lambda { |v| v =~ Regexp.new("/^([0-9]+)\.([0-9]+)$/") },
         },
         description: ""

property :patch_version, Hash,
         required: true,
         callbacks: {
           "patch_version is not a String" => lambda { |v| v.is_a? String },
           "patch_version needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "patch_version must match pattern ^[a-z0-9]+$" => lambda { |v| v =~ Regexp.new("/^[a-z0-9]+$/") },
         },
         description: ""

property :updated_latest_patch_version, Hash,
         callbacks: {
           "updated_latest_patch_version is not a String" => lambda { |v| v.is_a? String },
           "updated_latest_patch_version needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "updated_latest_patch_version must match pattern ^[a-z0-9]+$" => lambda { |v| v =~ Regexp.new("/^[a-z0-9]+$/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Panorama::PackageVersion"
rest_api_document "/AWS::Panorama::PackageVersion"

rest_property_map({
  mark_latest:                  "MarkLatest",
  owner_account:                "OwnerAccount",
  package_id:                   "PackageId",
  package_version:              "PackageVersion",
  patch_version:                "PatchVersion",
  updated_latest_patch_version: "UpdatedLatestPatchVersion",
})

rest_post_only_properties %i{
  owner_account package_id package_version patch_version
}
