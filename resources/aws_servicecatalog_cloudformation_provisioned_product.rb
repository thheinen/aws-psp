# Import API specifics
use "awscc_base"

resource_name :aws_servicecatalog_cloudformation_provisioned_product
provides :aws_servicecatalog_cloudformation_provisioned_product, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Schema for AWS::ServiceCatalog::CloudFormationProvisionedProduct
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :accept_language, String,
         callbacks: {
           "accept_language is not a String" => lambda { |v| v.is_a? String },
           "accept_languageis not one of `en`, `jp`, `zh`" => lambda { |v| %w{en jp zh}.include? v },
         },
         description: ""

property :notification_arns, Array,
         callbacks: {
           "notification_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :path_id, String,
         callbacks: {
           "path_id is not a String" => lambda { |v| v.is_a? String },
           "path_id needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
         },
         description: ""

property :path_name, String,
         callbacks: {
           "path_name is not a String" => lambda { |v| v.is_a? String },
           "path_name needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
         },
         description: ""

property :product_id, String,
         callbacks: {
           "product_id is not a String" => lambda { |v| v.is_a? String },
           "product_id needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
         },
         description: ""

property :product_name, String,
         callbacks: {
           "product_name is not a String" => lambda { |v| v.is_a? String },
           "product_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
         },
         description: ""

property :provisioned_product_name, String,
         callbacks: {
           "provisioned_product_name is not a String" => lambda { |v| v.is_a? String },
           "provisioned_product_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
         },
         description: ""

property :provisioning_artifact_id, String,
         callbacks: {
           "provisioning_artifact_id is not a String" => lambda { |v| v.is_a? String },
           "provisioning_artifact_id needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
         },
         description: ""

property :provisioning_artifact_name, String,
         callbacks: {
           "provisioning_artifact_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :provisioning_parameters, Array,
         callbacks: {
           "provisioning_parameters is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :provisioning_preferences, Hash,
         callbacks: {
           "Subproperty `StackSetAccounts` is not a Array" => lambda { |v| v[:StackSetAccounts].is_a? Array },
           "Subproperty `StackSetFailureToleranceCount` is not a Integer" => lambda { |v| v[:StackSetFailureToleranceCount].is_a? Integer },
           "Subproperty `StackSetFailureTolerancePercentage` is not a Integer" => lambda { |v| v[:StackSetFailureTolerancePercentage].is_a? Integer },
           "Subproperty `StackSetMaxConcurrencyCount` is not a Integer" => lambda { |v| v[:StackSetMaxConcurrencyCount].is_a? Integer },
           "Subproperty `StackSetMaxConcurrencyPercentage` is not a Integer" => lambda { |v| v[:StackSetMaxConcurrencyPercentage].is_a? Integer },
           "Subproperty `StackSetOperationType` is not a String" => lambda { |v| v[:StackSetOperationType].is_a? String },
           "Subproperty `StackSetOperationType`is not one of `CREATE`, `UPDATE`, `DELETE`" => lambda { |v| %w{CREATE UPDATE DELETE}.include? v[:StackSetOperationType] },
           "Subproperty `StackSetRegions` is not a Array" => lambda { |v| v[:StackSetRegions].is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::ServiceCatalog::CloudFormationProvisionedProduct"
rest_api_document "/AWS::ServiceCatalog::CloudFormationProvisionedProduct"

rest_property_map({
  accept_language:            "AcceptLanguage",
  notification_arns:          "NotificationArns",
  path_id:                    "PathId",
  path_name:                  "PathName",
  product_id:                 "ProductId",
  product_name:               "ProductName",
  provisioned_product_name:   "ProvisionedProductName",
  provisioning_artifact_id:   "ProvisioningArtifactId",
  provisioning_artifact_name: "ProvisioningArtifactName",
  provisioning_parameters:    "ProvisioningParameters",
  provisioning_preferences:   "ProvisioningPreferences",
  tags:                       "Tags",
})

rest_post_only_properties %i{
  notification_arns provisioned_product_name
}
