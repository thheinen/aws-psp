# Import API specifics
use "awscc_base"

resource_name :aws_robomaker_robot_application
provides :aws_robomaker_robot_application, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  AWS::RoboMaker::RobotApplication resource creates an AWS RoboMaker RobotApplication. Robot application can be used in AWS RoboMaker Simulation Jobs.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :current_revision_id, String,
         callbacks: {
           "current_revision_id is not a String" => lambda { |v| v.is_a? String },
           "current_revision_id needs to be 1..40 characters" => lambda { |v| v.length >= 1 && v.length <= 40 },
         },
         description: "The revision ID of robot application."

property :environment, String,
         callbacks: {
           "environment is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The URI of the Docker image for the robot application."

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: "The name of the robot application."

property :robot_software_suite, Hash,
         required: true,
         callbacks: {
           "Subproperty `Name` is not a String" => lambda { |v| v[:Name].is_a? String },
           "Subproperty `Name`is not one of `ROS`, `ROS2`, `General`" => lambda { |v| %w{ROS ROS2 General}.include? v[:Name] },
           "Subproperty `Version` is not a String" => lambda { |v| v[:Version].is_a? String },
           "Subproperty `Version`is not one of `Kinetic`, `Melodic`, `Dashing`" => lambda { |v| %w{Kinetic Melodic Dashing}.include? v[:Version] },
         },
         description: ""

property :sources, Array,
         callbacks: {
           "sources is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The sources of the robot application."

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::RoboMaker::RobotApplication"
rest_api_document "/AWS::RoboMaker::RobotApplication"

rest_property_map({
  current_revision_id:  "CurrentRevisionId",
  environment:          "Environment",
  name:                 "Name",
  robot_software_suite: "RobotSoftwareSuite",
  sources:              "Sources",
  tags:                 "Tags",
})

rest_post_only_properties %i{
  name
}
