# Import API specifics
use "awscc_base"

resource_name :aws_robomaker_fleet
provides :aws_robomaker_fleet, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  AWS::RoboMaker::Fleet resource creates an AWS RoboMaker fleet. Fleets contain robots and can receive deployments.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "name must match pattern [a-zA-Z0-9_\-]{1,255}$" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9_\-]{1,255}$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the fleet.
         DESCRIPTION

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::RoboMaker::Fleet"
rest_api_document "/AWS::RoboMaker::Fleet"

rest_property_map({
  name: "Name",
  tags: "Tags",
})

rest_post_only_properties %i{
  name
}
