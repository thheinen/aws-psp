# Import API specifics
use "awscc_base"

resource_name :aws_events_archive
provides :aws_events_archive, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Events::Archive
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :archive_name, String,
         callbacks: {
           "archive_name is not a String" => lambda { |v| v.is_a? String },
           "archive_name needs to be 1..48 characters" => lambda { |v| v.length >= 1 && v.length <= 48 },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :event_pattern, Hash,
         callbacks: {
           "event_pattern is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :retention_days, Integer,
         callbacks: {
           "retention_days is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :source_arn, String,
         required: true,
         callbacks: {
           "source_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Events::Archive"
rest_api_document "/AWS::Events::Archive"

rest_property_map({
  archive_name:   "ArchiveName",
  description:    "Description",
  event_pattern:  "EventPattern",
  retention_days: "RetentionDays",
  source_arn:     "SourceArn",
})

rest_post_only_properties %i{
  archive_name source_arn
}
