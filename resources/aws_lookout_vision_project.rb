# Import API specifics
use "awscc_base"

resource_name :aws_lookout_vision_project
provides :aws_lookout_vision_project, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::LookoutVision::Project type creates an Amazon Lookout for Vision project. A project is a grouping of the resources needed to create and manage a Lookout for Vision model.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :project_name, Hash,
         required: true,
         callbacks: {
           "project_name is not a String" => lambda { |v| v.is_a? String },
           "project_name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "project_name must match pattern [a-zA-Z0-9][a-zA-Z0-9_\-]*" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9][a-zA-Z0-9_\-]*/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::LookoutVision::Project"
rest_api_document "/AWS::LookoutVision::Project"

rest_property_map({
  project_name: "ProjectName",
})

rest_post_only_properties %i{
  project_name
}
