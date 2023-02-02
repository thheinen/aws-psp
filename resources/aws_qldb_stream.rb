# Import API specifics
use "awscc_base"

resource_name :aws_qldb_stream
provides :aws_qldb_stream, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::QLDB::Stream.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :exclusive_end_time, String,
         callbacks: {
           "exclusive_end_time is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :inclusive_start_time, String,
         required: true,
         callbacks: {
           "inclusive_start_time is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :kinesis_configuration, Hash,
         required: true,
         callbacks: {
           "Subproperty `AggregationEnabled` is not a Boolean" => lambda { |v| v[:AggregationEnabled].is_a? Boolean },
         },
         description: ""

property :ledger_name, String,
         required: true,
         callbacks: {
           "ledger_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :role_arn, Hash,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
           "role_arn must match pattern arn:[\w+=/,.@-]+:[\w+=/,.@-]+:[\w+=/,.@-]*:[0-9]*:[\w+=,.@-]+(/[\w+=,.@-]+)*" => lambda { |v| v =~ Regexp.new("/arn:[\w+=/,.@-]+:[\w+=/,.@-]+:[\w+=/,.@-]*:[0-9]*:[\w+=,.@-]+(/[\w+=,.@-]+)*/") },
         },
         description: ""

property :stream_name, String,
         required: true,
         callbacks: {
           "stream_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::QLDB::Stream"
rest_api_document "/AWS::QLDB::Stream"

rest_property_map({
  exclusive_end_time:    "ExclusiveEndTime",
  inclusive_start_time:  "InclusiveStartTime",
  kinesis_configuration: "KinesisConfiguration",
  ledger_name:           "LedgerName",
  role_arn:              "RoleArn",
  stream_name:           "StreamName",
  tags:                  "Tags",
})

rest_post_only_properties %i{
  exclusive_end_time inclusive_start_time kinesis_configuration ledger_name role_arn stream_name
}
