# Import API specifics
use "awscc_base"

resource_name :aws_quicksight_refresh_schedule
provides :aws_quicksight_refresh_schedule, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of the AWS::QuickSight::RefreshSchedule Resource Type.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :aws_account_id, String,
         callbacks: {
           "aws_account_id is not a String" => lambda { |v| v.is_a? String },
           "aws_account_id needs to be 12..12 characters" => lambda { |v| v.length >= 12 && v.length <= 12 },
           "aws_account_id must match pattern ^[0-9]{12}$" => lambda { |v| v =~ Regexp.new("/^[0-9]{12}$/") },
         },
         description: ""

property :data_set_id, String,
         callbacks: {
           "data_set_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :schedule, Hash,
         callbacks: {
           "Subproperty `ScheduleId` is not a String" => lambda { |v| v[:ScheduleId].is_a? String },
           "Subproperty `ScheduleId` needs to be 1..128 characters" => lambda { |v| v[:ScheduleId].length >= 1 && v[:ScheduleId].length <= 128 },
           "Subproperty `ScheduleFrequency` is not a Object" => lambda { |v| v[:ScheduleFrequency].is_a? Object },
           "Subproperty `StartAfterDateTime` is not a String" => lambda { |v| v[:StartAfterDateTime].is_a? String },
           "Subproperty `StartAfterDateTime` needs to be 1..128 characters" => lambda { |v| v[:StartAfterDateTime].length >= 1 && v[:StartAfterDateTime].length <= 128 },
           "Subproperty `RefreshType` is not a String" => lambda { |v| v[:RefreshType].is_a? String },
           "Subproperty `RefreshType`is not one of `FULL_REFRESH`, `INCREMENTAL_REFRESH`" => lambda { |v| %w{FULL_REFRESH INCREMENTAL_REFRESH}.include? v[:RefreshType] },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::QuickSight::RefreshSchedule"
rest_api_document "/AWS::QuickSight::RefreshSchedule"

rest_property_map({
  aws_account_id: "AwsAccountId",
  data_set_id:    "DataSetId",
  schedule:       "Schedule",
})

rest_post_only_properties %i{
  aws_account_id data_set_id schedule/schedule_id
}
