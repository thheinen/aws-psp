# Import API specifics
use "awscc_base"

resource_name :aws_iot_sitewise_dashboard
provides :aws_iot_sitewise_dashboard, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::IoTSiteWise::Dashboard
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :dashboard_definition, String,
         required: true,
         callbacks: {
           "dashboard_definition is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The dashboard definition specified in a JSON literal.
         DESCRIPTION

property :dashboard_description, String,
         required: true,
         callbacks: {
           "dashboard_description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A description for the dashboard.
         DESCRIPTION

property :dashboard_name, String,
         required: true,
         callbacks: {
           "dashboard_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A friendly name for the dashboard.
         DESCRIPTION

property :project_id, String,
         callbacks: {
           "project_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the project in which to create the dashboard.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of key-value pairs that contain metadata for the dashboard.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IoTSiteWise::Dashboard"
rest_api_document "/AWS::IoTSiteWise::Dashboard"

rest_property_map({
  dashboard_definition:  "DashboardDefinition",
  dashboard_description: "DashboardDescription",
  dashboard_name:        "DashboardName",
  project_id:            "ProjectId",
  tags:                  "Tags",
})

rest_post_only_properties %i{
  project_id
}
