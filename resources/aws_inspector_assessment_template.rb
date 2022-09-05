# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_inspector_assessment_template
provides :aws_inspector_assessment_template, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Inspector::AssessmentTemplate
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :assessment_target_arn, String,
         required: true,
         callbacks: {
           "assessment_target_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :assessment_template_name, String,
         callbacks: {
           "assessment_template_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :duration_in_seconds, Integer,
         required: true,
         callbacks: {
           "duration_in_seconds is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :rules_package_arns, Array,
         required: true,
         callbacks: {
           "rules_package_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :user_attributes_for_findings, Array,
         callbacks: {
           "user_attributes_for_findings is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Inspector::AssessmentTemplate"
rest_api_document "/AWS::Inspector::AssessmentTemplate"

rest_property_map({
  assessment_target_arn:        "AssessmentTargetArn",
  assessment_template_name:     "AssessmentTemplateName",
  duration_in_seconds:          "DurationInSeconds",
  rules_package_arns:           "RulesPackageArns",
  user_attributes_for_findings: "UserAttributesForFindings",
})

rest_post_only_properties %i{
  assessment_target_arn assessment_template_name duration_in_seconds rules_package_arns user_attributes_for_findings
}
