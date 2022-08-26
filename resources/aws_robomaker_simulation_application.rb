# Import API specifics
use "awscc_base"

resource_name :aws_robomaker_simulation_application
provides :aws_robomaker_simulation_application, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  AWS::RoboMaker::SimulationApplication resource creates an AWS RoboMaker SimulationApplication. Simulation application can be used in AWS RoboMaker Simulation Jobs.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :current_revision_id, String,
         callbacks: {
           "current_revision_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The current revision id."

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
           "name must match pattern [a-zA-Z0-9_\-]*" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9_\-]*/") },
         },
         description: "The name of the simulation application."

property :rendering_engine, Hash,
         callbacks: {
           "Subproperty `Name` is not a String" => lambda { |v| v[:Name].is_a? String },
           "Subproperty `Name`is not one of `OGRE`" => lambda { |v| %w{OGRE}.include? v[:Name] },
           "Subproperty `Version` is not a String" => lambda { |v| v[:Version].is_a? String },
           "Subproperty `Version` must match pattern 1.x" => lambda { |v| v[:Version] =~ Regexp.new("/1.x/") },
         },
         description: "The rendering engine for the simulation application."

property :robot_software_suite, Hash,
         required: true,
         callbacks: {
           "Subproperty `Name` is not a String" => lambda { |v| v[:Name].is_a? String },
           "Subproperty `Name`is not one of `ROS`, `ROS2`, `General`" => lambda { |v| %w{ROS ROS2 General}.include? v[:Name] },
           "Subproperty `Version` is not a String" => lambda { |v| v[:Version].is_a? String },
           "Subproperty `Version`is not one of `Kinetic`, `Melodic`, `Dashing`, `Foxy`" => lambda { |v| %w{Kinetic Melodic Dashing Foxy}.include? v[:Version] },
         },
         description: "The robot software suite used by the simulation application."

property :simulation_software_suite, Hash,
         required: true,
         callbacks: {
           "Subproperty `Name` is not a String" => lambda { |v| v[:Name].is_a? String },
           "Subproperty `Name`is not one of `Gazebo`, `RosbagPlay`, `SimulationRuntime`" => lambda { |v| %w{Gazebo RosbagPlay SimulationRuntime}.include? v[:Name] },
           "Subproperty `Version` is not a String" => lambda { |v| v[:Version].is_a? String },
           "Subproperty `Version`is not one of `7`, `9`, `11`, `Kinetic`, `Melodic`, `Dashing`, `Foxy`" => lambda { |v| %w{7 9 11 Kinetic Melodic Dashing Foxy}.include? v[:Version] },
         },
         description: "The simulation software suite used by the simulation application."

property :sources, Array,
         callbacks: {
           "sources is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The sources of the simulation application."

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::RoboMaker::SimulationApplication"
rest_api_document "/AWS::RoboMaker::SimulationApplication"

rest_property_map({
  current_revision_id:       "CurrentRevisionId",
  environment:               "Environment",
  name:                      "Name",
  rendering_engine:          "RenderingEngine",
  robot_software_suite:      "RobotSoftwareSuite",
  simulation_software_suite: "SimulationSoftwareSuite",
  sources:                   "Sources",
  tags:                      "Tags",
})

rest_post_only_properties %i{
  name
}
