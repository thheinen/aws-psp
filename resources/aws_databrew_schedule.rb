# Import API specifics
use "awscc_base"

resource_name :aws_databrew_schedule
provides :aws_databrew_schedule, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::DataBrew::Schedule.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :cron_expression, String,
         required: true,
         callbacks: {
           "cron_expression is not a String" => lambda { |v| v.is_a? String },
           "cron_expression needs to be 1..512 characters" => lambda { |v| v.length >= 1 && v.length <= 512 },
         },
         description: "Schedule cron"

property :job_names, Array,
         callbacks: {
           "job_names is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: "Schedule Name"

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::DataBrew::Schedule"
rest_api_document "/AWS::DataBrew::Schedule"

rest_property_map({
  cron_expression: "CronExpression",
  job_names:       "JobNames",
  name:            "Name",
  tags:            "Tags",
})

rest_post_only_properties %i{
  name tags
}
