# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_inspector_assessment_target
provides :aws_inspector_assessment_target, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Inspector::AssessmentTarget
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :assessment_target_name, String,
         callbacks: {
           "assessment_target_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :resource_group_arn, String,
         callbacks: {
           "resource_group_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Inspector::AssessmentTarget"
rest_api_document "/AWS::Inspector::AssessmentTarget"

rest_property_map({
  assessment_target_name: "AssessmentTargetName",
  resource_group_arn:     "ResourceGroupArn",
})

rest_post_only_properties %i{
  assessment_target_name
}
