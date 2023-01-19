# Import API specifics
use "awscc_base"

resource_name :aws_licensemanager_license
provides :aws_licensemanager_license, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::LicenseManager::License
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :beneficiary, String,
         callbacks: {
           "beneficiary is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Beneficiary of the license.
         DESCRIPTION

property :consumption_configuration, Hash,
         required: true,
         callbacks: {
           "Subproperty `RenewType` is not a String" => lambda { |v| v[:RenewType].is_a? String },
         },
         description: ""

property :entitlements, Array,
         required: true,
         callbacks: {
           "entitlements is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :home_region, String,
         required: true,
         callbacks: {
           "home_region is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Home region for the created license.
         DESCRIPTION

property :issuer, Hash,
         required: true,
         callbacks: {
           "Subproperty `Name` is not a String" => lambda { |v| v[:Name].is_a? String },
           "Subproperty `SignKey` is not a String" => lambda { |v| v[:SignKey].is_a? String },
         },
         description: ""

property :license_metadata, Array,
         callbacks: {
           "license_metadata is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :license_name, String,
         required: true,
         callbacks: {
           "license_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Name for the created license.
         DESCRIPTION

property :product_name, String,
         required: true,
         callbacks: {
           "product_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Product name for the created license.
         DESCRIPTION

property :product_sku, String,
         callbacks: {
           "product_sku is not a String" => lambda { |v| v.is_a? String },
           "product_sku needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
         },
         description: <<~'DESCRIPTION'
           ProductSKU of the license.
         DESCRIPTION

property :status, Hash,
         callbacks: {
           "status is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :validity, Hash,
         required: true,
         callbacks: {
           "Subproperty `Begin` is not a String" => lambda { |v| v[:Begin].is_a? String },
           "Subproperty `End` is not a String" => lambda { |v| v[:End].is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::LicenseManager::License"
rest_api_document "/AWS::LicenseManager::License"

rest_property_map({
  beneficiary:               "Beneficiary",
  consumption_configuration: "ConsumptionConfiguration",
  entitlements:              "Entitlements",
  home_region:               "HomeRegion",
  issuer:                    "Issuer",
  license_metadata:          "LicenseMetadata",
  license_name:              "LicenseName",
  product_name:              "ProductName",
  product_sku:               "ProductSKU",
  status:                    "Status",
  validity:                  "Validity",
})

