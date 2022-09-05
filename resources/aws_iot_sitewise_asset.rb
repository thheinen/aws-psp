# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_iot_sitewise_asset
provides :aws_iot_sitewise_asset, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::IoTSiteWise::Asset
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :asset_description, String,
         callbacks: {
           "asset_description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A description for the asset
         DESCRIPTION

property :asset_hierarchies, Array,
         callbacks: {
           "asset_hierarchies is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :asset_model_id, String,
         required: true,
         callbacks: {
           "asset_model_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the asset model from which to create the asset.
         DESCRIPTION

property :asset_name, String,
         required: true,
         callbacks: {
           "asset_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A unique, friendly name for the asset.
         DESCRIPTION

property :asset_properties, Array,
         callbacks: {
           "asset_properties is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of key-value pairs that contain metadata for the asset.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IoTSiteWise::Asset"
rest_api_document "/AWS::IoTSiteWise::Asset"

rest_property_map({
  asset_description: "AssetDescription",
  asset_hierarchies: "AssetHierarchies",
  asset_model_id:    "AssetModelId",
  asset_name:        "AssetName",
  asset_properties:  "AssetProperties",
  tags:              "Tags",
})

