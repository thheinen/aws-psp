# Import API specifics
use "awscc_base"

resource_name :aws_robomaker_robot_application_version
provides :aws_robomaker_robot_application_version, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  AWS::RoboMaker::RobotApplicationVersion resource creates an AWS RoboMaker RobotApplicationVersion. This helps you control which code your robot uses.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :application, Hash,
         required: true,
         callbacks: {
           "application is not a String" => lambda { |v| v.is_a? String },
           "application must match pattern arn:[\w+=/,.@-]+:[\w+=/,.@-]+:[\w+=/,.@-]*:[0-9]*:[\w+=,.@-]+(/[\w+=,.@-]+)*" => lambda { |v| v =~ Regexp.new("/arn:[\w+=/,.@-]+:[\w+=/,.@-]+:[\w+=/,.@-]*:[0-9]*:[\w+=,.@-]+(/[\w+=,.@-]+)*/") },
         },
         description: ""

property :current_revision_id, String,
         callbacks: {
           "current_revision_id is not a String" => lambda { |v| v.is_a? String },
           "current_revision_id needs to be 1..40 characters" => lambda { |v| v.length >= 1 && v.length <= 40 },
           "current_revision_id must match pattern [a-zA-Z0-9_.\-]*" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9_.\-]*/") },
         },
         description: "The revision ID of robot application."

# API URLs and mappings
rest_api_collection "/AWS::RoboMaker::RobotApplicationVersion"
rest_api_document "/AWS::RoboMaker::RobotApplicationVersion"

rest_property_map({
  application:         "Application",
  current_revision_id: "CurrentRevisionId",
})

rest_post_only_properties %i{
  application current_revision_id
}
