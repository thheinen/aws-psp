# Import API specifics
use "awscc_base"

resource_name :aws_pipes_pipe
provides :aws_pipes_pipe, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::Pipes::Pipe Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..512 characters" => lambda { |v| v.length >= 0 && v.length <= 512 },
           "description must match pattern ^.*$" => lambda { |v| v =~ Regexp.new("/^.*$/") },
         },
         description: ""

property :desired_state, Hash,
         callbacks: {
           "desired_state is not a String" => lambda { |v| v.is_a? String },
           "desired_stateis not one of `RUNNING`, `STOPPED`" => lambda { |v| %w{RUNNING STOPPED}.include? v },
         },
         description: ""

property :enrichment, String,
         callbacks: {
           "enrichment is not a String" => lambda { |v| v.is_a? String },
           "enrichment needs to be 0..1600 characters" => lambda { |v| v.length >= 0 && v.length <= 1600 },
           "enrichment must match pattern ^$|arn:(aws[a-zA-Z0-9-]*):([a-zA-Z0-9\-]+):([a-z]{2}((-gov)|(-iso(b?)))?-[a-z]+-\d{1})?:(\d{12})?:(.+)$" => lambda { |v| v =~ Regexp.new("/^$|arn:(aws[a-zA-Z0-9-]*):([a-zA-Z0-9\-]+):([a-z]{2}((-gov)|(-iso(b?)))?-[a-z]+-\d{1})?:(\d{12})?:(.+)$/") },
         },
         description: ""

property :enrichment_parameters, Hash,
         callbacks: {
           "Subproperty `InputTemplate` is not a String" => lambda { |v| v[:InputTemplate].is_a? String },
           "Subproperty `InputTemplate` needs to be 0..8192 characters" => lambda { |v| v[:InputTemplate].length >= 0 && v[:InputTemplate].length <= 8192 },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "name must match pattern ^[\.\-_A-Za-z0-9]+$" => lambda { |v| v =~ Regexp.new("/^[\.\-_A-Za-z0-9]+$/") },
         },
         description: ""

property :role_arn, String,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
           "role_arn needs to be 1..1600 characters" => lambda { |v| v.length >= 1 && v.length <= 1600 },
           "role_arn must match pattern ^arn:(aws[a-zA-Z-]*)?:iam::\d{12}:role/?[a-zA-Z0-9+=,.@\-_/]+$" => lambda { |v| v =~ Regexp.new("/^arn:(aws[a-zA-Z-]*)?:iam::\d{12}:role/?[a-zA-Z0-9+=,.@\-_/]+$/") },
         },
         description: ""

property :source, String,
         required: true,
         callbacks: {
           "source is not a String" => lambda { |v| v.is_a? String },
           "source needs to be 1..1600 characters" => lambda { |v| v.length >= 1 && v.length <= 1600 },
           "source must match pattern ^smk://(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9]):[0-9]{1,5}|arn:(aws[a-zA-Z0-9-]*):([a-zA-Z0-9\-]+):([a-z]{2}((-gov)|(-iso(b?)))?-[a-z]+-\d{1})?:(\d{12})?:(.+)$" => lambda { |v| v =~ Regexp.new("/^smk://(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9]):[0-9]{1,5}|arn:(aws[a-zA-Z0-9-]*):([a-zA-Z0-9\-]+):([a-z]{2}((-gov)|(-iso(b?)))?-[a-z]+-\d{1})?:(\d{12})?:(.+)$/") },
         },
         description: ""

property :source_parameters, Hash,
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :target, String,
         required: true,
         callbacks: {
           "target is not a String" => lambda { |v| v.is_a? String },
           "target needs to be 1..1600 characters" => lambda { |v| v.length >= 1 && v.length <= 1600 },
           "target must match pattern ^arn:(aws[a-zA-Z0-9-]*):([a-zA-Z0-9\-]+):([a-z]{2}((-gov)|(-iso(b?)))?-[a-z]+-\d{1})?:(\d{12})?:(.+)$" => lambda { |v| v =~ Regexp.new("/^arn:(aws[a-zA-Z0-9-]*):([a-zA-Z0-9\-]+):([a-z]{2}((-gov)|(-iso(b?)))?-[a-z]+-\d{1})?:(\d{12})?:(.+)$/") },
         },
         description: ""

property :target_parameters, Hash,
         callbacks: {
           "Subproperty `InputTemplate` is not a String" => lambda { |v| v[:InputTemplate].is_a? String },
           "Subproperty `InputTemplate` needs to be 0..8192 characters" => lambda { |v| v[:InputTemplate].length >= 0 && v[:InputTemplate].length <= 8192 },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Pipes::Pipe"
rest_api_document "/AWS::Pipes::Pipe"

rest_property_map({
  description:           "Description",
  desired_state:         "DesiredState",
  enrichment:            "Enrichment",
  enrichment_parameters: "EnrichmentParameters",
  name:                  "Name",
  role_arn:              "RoleArn",
  source:                "Source",
  source_parameters:     "SourceParameters",
  tags:                  "Tags",
  target:                "Target",
  target_parameters:     "TargetParameters",
})

rest_post_only_properties %i{
  name source source_parameters/active_mq_broker_parameters/queue_name source_parameters/dynamodb_stream_parameters/starting_position source_parameters/kinesis_stream_parameters/starting_position source_parameters/kinesis_stream_parameters/starting_position_timestamp source_parameters/managed_streaming_kafka_parameters/consumer_group_id source_parameters/managed_streaming_kafka_parameters/starting_position source_parameters/managed_streaming_kafka_parameters/topic_name source_parameters/rabbit_mq_broker_parameters/queue_name source_parameters/rabbit_mq_broker_parameters/virtual_host source_parameters/self_managed_apache_kafka_parameters/additional_bootstrap_servers source_parameters/self_managed_apache_kafka_parameters/consumer_group_id source_parameters/self_managed_apache_kafka_parameters/starting_position source_parameters/self_managed_apache_kafka_parameters/topic_name
}
