# Import API specifics
use "awscc_base"

resource_name :aws_kinesis_stream
provides :aws_kinesis_stream, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Kinesis::Stream
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "name must match pattern ^[a-zA-Z0-9_.-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_.-]+$/") },
         },
         description: "The name of the Kinesis stream."

property :retention_period_hours, Integer,
         callbacks: {
           "retention_period_hours is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "The number of hours for the data records that are stored in shards to remain accessible."

property :shard_count, Integer,
         callbacks: {
           "shard_count is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "The number of shards that the stream uses. Required when StreamMode = PROVISIONED is passed."

property :stream_encryption, Hash,
         callbacks: {
           "Subproperty `EncryptionType` is not a String" => lambda { |v| v[:EncryptionType].is_a? String },
           "Subproperty `EncryptionType`is not one of `KMS`" => lambda { |v| %w{KMS}.include? v[:EncryptionType] },
           "Subproperty `KeyId` is not a String" => lambda { |v| v[:KeyId].is_a? String },
           "Subproperty `KeyId` needs to be 1..2048 characters" => lambda { |v| v[:KeyId].length >= 1 && v[:KeyId].length <= 2048 },
         },
         description: "When specified, enables or updates server-side encryption using an AWS KMS key for a specified stream."

property :stream_mode_details, Hash,
         callbacks: {
           "Subproperty `StreamMode` is not a String" => lambda { |v| v[:StreamMode].is_a? String },
           "Subproperty `StreamMode`is not one of `ON_DEMAND`, `PROVISIONED`" => lambda { |v| %w{ON_DEMAND PROVISIONED}.include? v[:StreamMode] },
         },
         description: "The mode in which the stream is running."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "An arbitrary set of tags (key–value pairs) to associate with the Kinesis stream."

# API URLs and mappings
rest_api_collection "/AWS::Kinesis::Stream"
rest_api_document "/AWS::Kinesis::Stream"

rest_property_map({
  name:                   "Name",
  retention_period_hours: "RetentionPeriodHours",
  shard_count:            "ShardCount",
  stream_encryption:      "StreamEncryption",
  stream_mode_details:    "StreamModeDetails",
  tags:                   "Tags",
})

rest_post_only_properties %i{
  name
}
