# Import API specifics
use "awscc_base"

resource_name :aws_stepfunctions_activity
provides :aws_stepfunctions_activity, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for Activity
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..80 characters" => lambda { |v| v.length >= 1 && v.length <= 80 },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::StepFunctions::Activity"
rest_api_document "/AWS::StepFunctions::Activity"

rest_property_map({
  name: "Name",
  tags: "Tags",
})

rest_post_only_properties %i{
  name
}
