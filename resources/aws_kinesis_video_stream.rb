# Import API specifics
use "awscc_base"

resource_name :aws_kinesis_video_stream
provides :aws_kinesis_video_stream, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type Definition for AWS::KinesisVideo::Stream
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :data_retention_in_hours, Integer,
         callbacks: {
           "data_retention_in_hours is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of hours till which Kinesis Video will retain the data in the stream
         DESCRIPTION

property :device_name, String,
         callbacks: {
           "device_name is not a String" => lambda { |v| v.is_a? String },
           "device_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "device_name must match pattern [a-zA-Z0-9_.-]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9_.-]+/") },
         },
         description: <<~'DESCRIPTION'
           The name of the device that is writing to the stream.
         DESCRIPTION

property :kms_key_id, String,
         callbacks: {
           "kms_key_id is not a String" => lambda { |v| v.is_a? String },
           "kms_key_id needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
           "kms_key_id must match pattern .+" => lambda { |v| v =~ Regexp.new("/.+/") },
         },
         description: <<~'DESCRIPTION'
           AWS KMS key ID that Kinesis Video Streams uses to encrypt stream data.
         DESCRIPTION

property :media_type, String,
         callbacks: {
           "media_type is not a String" => lambda { |v| v.is_a? String },
           "media_type needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "media_type must match pattern [\w\-\.\+]+/[\w\-\.\+]+(,[\w\-\.\+]+/[\w\-\.\+]+)*" => lambda { |v| v =~ Regexp.new("/[\w\-\.\+]+/[\w\-\.\+]+(,[\w\-\.\+]+/[\w\-\.\+]+)*/") },
         },
         description: <<~'DESCRIPTION'
           The media type of the stream. Consumers of the stream can use this information when processing the stream.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "name must match pattern [a-zA-Z0-9_.-]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9_.-]+/") },
         },
         description: <<~'DESCRIPTION'
           The name of the Kinesis Video stream.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs associated with the Kinesis Video Stream.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::KinesisVideo::Stream"
rest_api_document "/AWS::KinesisVideo::Stream"

rest_property_map({
  data_retention_in_hours: "DataRetentionInHours",
  device_name:             "DeviceName",
  kms_key_id:              "KmsKeyId",
  media_type:              "MediaType",
  name:                    "Name",
  tags:                    "Tags",
})

rest_post_only_properties %i{
  name
}
