# Import API specifics
use "awscc_base"

resource_name :aws_work_spaces_web_user_access_logging_settings
provides :aws_work_spaces_web_user_access_logging_settings, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::WorkSpacesWeb::UserAccessLoggingSettings Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :kinesis_stream_arn, String,
         required: true,
         callbacks: {
           "kinesis_stream_arn is not a String" => lambda { |v| v.is_a? String },
           "kinesis_stream_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "kinesis_stream_arn must match pattern arn:[\w+=/,.@-]+:kinesis:[a-zA-Z0-9\-]*:[a-zA-Z0-9]{1,12}:stream/.+" => lambda { |v| v =~ Regexp.new("/arn:[\w+=/,.@-]+:kinesis:[a-zA-Z0-9\-]*:[a-zA-Z0-9]{1,12}:stream/.+/") },
         },
         description: <<~'DESCRIPTION'
           Kinesis stream ARN to which log events are published.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::WorkSpacesWeb::UserAccessLoggingSettings"
rest_api_document "/AWS::WorkSpacesWeb::UserAccessLoggingSettings"

rest_property_map({
  kinesis_stream_arn: "KinesisStreamArn",
  tags:               "Tags",
})

