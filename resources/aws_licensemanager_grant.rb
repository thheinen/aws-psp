# Import API specifics
use "awscc_base"

resource_name :aws_licensemanager_grant
provides :aws_licensemanager_grant, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  An example resource schema demonstrating some basic constructs and validation rules.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :allowed_operations, Array,
         callbacks: {
           "allowed_operations is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :grant_name, String,
         callbacks: {
           "grant_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: "Name for the created Grant."

property :home_region, String,
         callbacks: {
           "home_region is not a String" => lambda { |v| v.is_a? String },
         },
         description: "Home region for the created grant."

property :license_arn, Hash,
         callbacks: {
           "license_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: "License Arn for the grant."

property :principals, Array,
         callbacks: {
           "principals is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :status, String,
         callbacks: {
           "status is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::LicenseManager::Grant"
rest_api_document "/AWS::LicenseManager::Grant"

rest_property_map({
  allowed_operations: "AllowedOperations",
  grant_name:         "GrantName",
  home_region:        "HomeRegion",
  license_arn:        "LicenseArn",
  principals:         "Principals",
  status:             "Status",
})

