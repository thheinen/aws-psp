# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_iot_sitewise_asset_model
provides :aws_iot_sitewise_asset_model, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::IoTSiteWise::AssetModel
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :asset_model_composite_models, Array,
         callbacks: {
           "asset_model_composite_models is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The composite asset models that are part of this asset model. Composite asset models are asset models that contain specific properties.
         DESCRIPTION

property :asset_model_description, String,
         callbacks: {
           "asset_model_description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A description for the asset model.
         DESCRIPTION

property :asset_model_hierarchies, Array,
         callbacks: {
           "asset_model_hierarchies is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The hierarchy definitions of the asset model. Each hierarchy specifies an asset model whose assets can be children of any other assets created from this asset model. You can specify up to 10 hierarchies per asset model.
         DESCRIPTION

property :asset_model_name, String,
         required: true,
         callbacks: {
           "asset_model_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A unique, friendly name for the asset model.
         DESCRIPTION

property :asset_model_properties, Array,
         callbacks: {
           "asset_model_properties is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The property definitions of the asset model. You can specify up to 200 properties per asset model.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of key-value pairs that contain metadata for the asset model.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IoTSiteWise::AssetModel"
rest_api_document "/AWS::IoTSiteWise::AssetModel"

rest_property_map({
  asset_model_composite_models: "AssetModelCompositeModels",
  asset_model_description:      "AssetModelDescription",
  asset_model_hierarchies:      "AssetModelHierarchies",
  asset_model_name:             "AssetModelName",
  asset_model_properties:       "AssetModelProperties",
  tags:                         "Tags",
})

