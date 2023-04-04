# Import API specifics
use "awscc_base"

resource_name :aws_ssm_contacts_rotation
provides :aws_ssm_contacts_rotation, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SSMContacts::Rotation.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :contact_ids, Array,
         required: true,
         callbacks: {
           "contact_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Members of the rotation
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name must match pattern ^[a-zA-Z0-9_]*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_]*$/") },
         },
         description: <<~'DESCRIPTION'
           Name of the Rotation
         DESCRIPTION

property :recurrence, Hash,
         required: true,
         callbacks: {
           "Subproperty `MonthlySettings` is not a Array" => lambda { |v| v[:MonthlySettings].is_a? Array },
           "Subproperty `WeeklySettings` is not a Array" => lambda { |v| v[:WeeklySettings].is_a? Array },
           "Subproperty `DailySettings` is not a Array" => lambda { |v| v[:DailySettings].is_a? Array },
           "Subproperty `NumberOfOnCalls` is not a Integer" => lambda { |v| v[:NumberOfOnCalls].is_a? Integer },
           "Subproperty `RecurrenceMultiplier` is not a Integer" => lambda { |v| v[:RecurrenceMultiplier].is_a? Integer },
           "Subproperty `ShiftCoverages` is not a Array" => lambda { |v| v[:ShiftCoverages].is_a? Array },
         },
         description: ""

property :start_time, String,
         required: true,
         callbacks: {
           "start_time is not a String" => lambda { |v| v.is_a? String },
           "start_time must match pattern ^(\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2})$" => lambda { |v| v =~ Regexp.new("/^(\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2})$/") },
         },
         description: <<~'DESCRIPTION'
           Start time of the first shift of Oncall Schedule
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :time_zone_id, String,
         required: true,
         callbacks: {
           "time_zone_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           TimeZone Identifier for the Oncall Schedule
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SSMContacts::Rotation"
rest_api_document "/AWS::SSMContacts::Rotation"

rest_property_map({
  contact_ids:  "ContactIds",
  name:         "Name",
  recurrence:   "Recurrence",
  start_time:   "StartTime",
  tags:         "Tags",
  time_zone_id: "TimeZoneId",
})

