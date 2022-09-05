# Import API specifics
use "awscc_base"

resource_name :aws_connect_instance_storage_config
provides :aws_connect_instance_storage_config, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Connect::InstanceStorageConfig
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :instance_arn, String,
         required: true,
         callbacks: {
           "instance_arn is not a String" => lambda { |v| v.is_a? String },
           "instance_arn must match pattern ^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$" => lambda { |v| v =~ Regexp.new("/^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$/") },
         },
         description: <<~'DESCRIPTION'
           Connect Instance ID with which the storage config will be associated
         DESCRIPTION

property :kinesis_firehose_config, Hash,
         description: ""

property :kinesis_stream_config, Hash,
         description: ""

property :kinesis_video_stream_config, Hash,
         description: ""

property :resource_type, Hash,
         required: true,
         callbacks: {
           "resource_type is not a String" => lambda { |v| v.is_a? String },
           "resource_typeis not one of `CHAT_TRANSCRIPTS`, `CALL_RECORDINGS`, `SCHEDULED_REPORTS`, `MEDIA_STREAMS`, `CONTACT_TRACE_RECORDS`, `AGENT_EVENTS`" => lambda { |v| %w{CHAT_TRANSCRIPTS CALL_RECORDINGS SCHEDULED_REPORTS MEDIA_STREAMS CONTACT_TRACE_RECORDS AGENT_EVENTS}.include? v },
         },
         description: ""

property :s3_config, Hash,
         description: ""

property :storage_type, Hash,
         required: true,
         callbacks: {
           "storage_type is not a String" => lambda { |v| v.is_a? String },
           "storage_typeis not one of `S3`, `KINESIS_VIDEO_STREAM`, `KINESIS_STREAM`, `KINESIS_FIREHOSE`" => lambda { |v| %w{S3 KINESIS_VIDEO_STREAM KINESIS_STREAM KINESIS_FIREHOSE}.include? v },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Connect::InstanceStorageConfig"
rest_api_document "/AWS::Connect::InstanceStorageConfig"

rest_property_map({
  instance_arn:                "InstanceArn",
  kinesis_firehose_config:     "KinesisFirehoseConfig",
  kinesis_stream_config:       "KinesisStreamConfig",
  kinesis_video_stream_config: "KinesisVideoStreamConfig",
  resource_type:               "ResourceType",
  s3_config:                   "S3Config",
  storage_type:                "StorageType",
})

rest_post_only_properties %i{
  instance_arn resource_type
}
