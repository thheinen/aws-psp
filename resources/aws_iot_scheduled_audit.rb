# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_iot_scheduled_audit
provides :aws_iot_scheduled_audit, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Scheduled audits can be used to specify the checks you want to perform during an audit and how often the audit should be run.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :day_of_month, String,
         callbacks: {
           "day_of_month is not a String" => lambda { |v| v.is_a? String },
           "day_of_month must match pattern ^([1-9]|[12][0-9]|3[01])$|^LAST$" => lambda { |v| v =~ Regexp.new("/^([1-9]|[12][0-9]|3[01])$|^LAST$/") },
         },
         description: <<~'DESCRIPTION'
           The day of the month on which the scheduled audit takes place. Can be 1 through 31 or LAST. This field is required if the frequency parameter is set to MONTHLY.
         DESCRIPTION

property :day_of_week, String,
         callbacks: {
           "day_of_week is not a String" => lambda { |v| v.is_a? String },
           "day_of_weekis not one of `SUN`, `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`" => lambda { |v| %w{SUN MON TUE WED THU FRI SAT}.include? v },
         },
         description: <<~'DESCRIPTION'
           The day of the week on which the scheduled audit takes place. Can be one of SUN, MON, TUE,WED, THU, FRI, or SAT. This field is required if the frequency parameter is set to WEEKLY or BIWEEKLY.
         DESCRIPTION

property :frequency, String,
         required: true,
         callbacks: {
           "frequency is not a String" => lambda { |v| v.is_a? String },
           "frequencyis not one of `DAILY`, `WEEKLY`, `BIWEEKLY`, `MONTHLY`" => lambda { |v| %w{DAILY WEEKLY BIWEEKLY MONTHLY}.include? v },
         },
         description: <<~'DESCRIPTION'
           How often the scheduled audit takes place. Can be one of DAILY, WEEKLY, BIWEEKLY, or MONTHLY.
         DESCRIPTION

property :scheduled_audit_name, String,
         callbacks: {
           "scheduled_audit_name is not a String" => lambda { |v| v.is_a? String },
           "scheduled_audit_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "scheduled_audit_name must match pattern [a-zA-Z0-9:_-]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9:_-]+/") },
         },
         description: <<~'DESCRIPTION'
           The name you want to give to the scheduled audit.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

property :target_check_names, Array,
         required: true,
         callbacks: {
           "target_check_names is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Which checks are performed during the scheduled audit. Checks must be enabled for your account.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IoT::ScheduledAudit"
rest_api_document "/AWS::IoT::ScheduledAudit"

rest_property_map({
  day_of_month:         "DayOfMonth",
  day_of_week:          "DayOfWeek",
  frequency:            "Frequency",
  scheduled_audit_name: "ScheduledAuditName",
  tags:                 "Tags",
  target_check_names:   "TargetCheckNames",
})

rest_post_only_properties %i{
  scheduled_audit_name
}
