# Import API specifics
use "awscc_base"

resource_name :aws_backup_report_plan
provides :aws_backup_report_plan, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Contains detailed information about a report plan in AWS Backup Audit Manager.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :report_delivery_channel, Hash,
         required: true,
         callbacks: {
           "Subproperty `Formats` is not a Array" => lambda { |v| v[:Formats].is_a? Array },
           "Subproperty `S3BucketName` is not a String" => lambda { |v| v[:S3BucketName].is_a? String },
           "Subproperty `S3KeyPrefix` is not a String" => lambda { |v| v[:S3KeyPrefix].is_a? String },
         },
         description: <<~'DESCRIPTION'
           A structure that contains information about where and how to deliver your reports, specifically your Amazon S3 bucket name, S3 key prefix, and the formats of your reports.
         DESCRIPTION

property :report_plan_description, String,
         callbacks: {
           "report_plan_description is not a String" => lambda { |v| v.is_a? String },
           "report_plan_description needs to be 0..1024 characters" => lambda { |v| v.length >= 0 && v.length <= 1024 },
           "report_plan_description must match pattern .*\S.*" => lambda { |v| v =~ Regexp.new("/.*\S.*/") },
         },
         description: <<~'DESCRIPTION'
           An optional description of the report plan with a maximum of 1,024 characters.
         DESCRIPTION

property :report_plan_name, String,
         callbacks: {
           "report_plan_name is not a String" => lambda { |v| v.is_a? String },
           "report_plan_name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "report_plan_name must match pattern [a-zA-Z][_a-zA-Z0-9]*" => lambda { |v| v =~ Regexp.new("/[a-zA-Z][_a-zA-Z0-9]*/") },
         },
         description: <<~'DESCRIPTION'
           The unique name of the report plan. The name must be between 1 and 256 characters, starting with a letter, and consisting of letters (a-z, A-Z), numbers (0-9), and underscores (_).
         DESCRIPTION

property :report_plan_tags, Array,
         callbacks: {
           "report_plan_tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Metadata that you can assign to help organize the report plans that you create. Each tag is a key-value pair.
         DESCRIPTION

property :report_setting, Hash,
         required: true,
         callbacks: {
           "Subproperty `ReportTemplate` is not a String" => lambda { |v| v[:ReportTemplate].is_a? String },
           "Subproperty `FrameworkArns` is not a Array" => lambda { |v| v[:FrameworkArns].is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Identifies the report template for the report. Reports are built using a report template.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Backup::ReportPlan"
rest_api_document "/AWS::Backup::ReportPlan"

rest_property_map({
  report_delivery_channel: "ReportDeliveryChannel",
  report_plan_description: "ReportPlanDescription",
  report_plan_name:        "ReportPlanName",
  report_plan_tags:        "ReportPlanTags",
  report_setting:          "ReportSetting",
})

rest_post_only_properties %i{
  report_plan_name
}
