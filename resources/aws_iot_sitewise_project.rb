# Import API specifics
use "awscc_base"

resource_name :aws_iot_sitewise_project
provides :aws_iot_sitewise_project, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::IoTSiteWise::Project
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :asset_ids, Array,
         callbacks: {
           "asset_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The IDs of the assets to be associated to the project."

property :portal_id, String,
         required: true,
         callbacks: {
           "portal_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The ID of the portal in which to create the project."

property :project_description, String,
         callbacks: {
           "project_description is not a String" => lambda { |v| v.is_a? String },
         },
         description: "A description for the project."

property :project_name, String,
         required: true,
         callbacks: {
           "project_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: "A friendly name for the project."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "A list of key-value pairs that contain metadata for the project."

# API URLs and mappings
rest_api_collection "/AWS::IoTSiteWise::Project"
rest_api_document "/AWS::IoTSiteWise::Project"

rest_property_map({
  asset_ids:           "AssetIds",
  portal_id:           "PortalId",
  project_description: "ProjectDescription",
  project_name:        "ProjectName",
  tags:                "Tags",
})

rest_post_only_properties %i{
  portal_id
}
