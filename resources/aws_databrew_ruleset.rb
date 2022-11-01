# Import API specifics
use "awscc_base"

resource_name :aws_databrew_ruleset
provides :aws_databrew_ruleset, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::DataBrew::Ruleset.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Description of the Ruleset
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           Name of the Ruleset
         DESCRIPTION

property :rules, Array,
         required: true,
         callbacks: {
           "rules is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           List of the data quality rules in the ruleset
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :target_arn, String,
         required: true,
         callbacks: {
           "target_arn is not a String" => lambda { |v| v.is_a? String },
           "target_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
         },
         description: <<~'DESCRIPTION'
           Arn of the target resource (dataset) to apply the ruleset to
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::DataBrew::Ruleset"
rest_api_document "/AWS::DataBrew::Ruleset"

rest_property_map({
  description: "Description",
  name:        "Name",
  rules:       "Rules",
  tags:        "Tags",
  target_arn:  "TargetArn",
})

rest_post_only_properties %i{
  name target_arn
}
