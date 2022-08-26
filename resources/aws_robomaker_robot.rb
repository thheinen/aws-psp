# Import API specifics
use "awscc_base"

resource_name :aws_robomaker_robot
provides :aws_robomaker_robot, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  AWS::RoboMaker::Robot resource creates an AWS RoboMaker Robot.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :architecture, String,
         required: true,
         callbacks: {
           "architecture is not a String" => lambda { |v| v.is_a? String },
           "architectureis not one of `X86_64`, `ARM64`, `ARMHF`" => lambda { |v| %w{X86_64 ARM64 ARMHF}.include? v },
         },
         description: "The target architecture of the robot."

property :fleet, String,
         callbacks: {
           "fleet is not a String" => lambda { |v| v.is_a? String },
           "fleet needs to be 1..1224 characters" => lambda { |v| v.length >= 1 && v.length <= 1224 },
         },
         description: "The Amazon Resource Name (ARN) of the fleet."

property :greengrass_group_id, String,
         required: true,
         callbacks: {
           "greengrass_group_id is not a String" => lambda { |v| v.is_a? String },
           "greengrass_group_id needs to be 1..1224 characters" => lambda { |v| v.length >= 1 && v.length <= 1224 },
         },
         description: "The Greengrass group id."

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: "The name for the robot."

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::RoboMaker::Robot"
rest_api_document "/AWS::RoboMaker::Robot"

rest_property_map({
  architecture:        "Architecture",
  fleet:               "Fleet",
  greengrass_group_id: "GreengrassGroupId",
  name:                "Name",
  tags:                "Tags",
})

rest_post_only_properties %i{
  architecture fleet greengrass_group_id name
}
