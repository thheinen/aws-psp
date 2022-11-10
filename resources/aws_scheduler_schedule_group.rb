# Import API specifics
use "awscc_base"

resource_name :aws_scheduler_schedule_group
provides :aws_scheduler_schedule_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::Scheduler::ScheduleGroup Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "name must match pattern ^[0-9a-zA-Z-_.]+$" => lambda { |v| v =~ Regexp.new("/^[0-9a-zA-Z-_.]+$/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The list of tags to associate with the schedule group.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Scheduler::ScheduleGroup"
rest_api_document "/AWS::Scheduler::ScheduleGroup"

rest_property_map({
  name: "Name",
  tags: "Tags",
})

rest_post_only_properties %i{
  name
}
