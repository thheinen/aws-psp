# Import API specifics
use "awscc_base"

resource_name :aws_kinesis_firehose_delivery_stream
provides :aws_kinesis_firehose_delivery_stream, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::KinesisFirehose::DeliveryStream
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :amazonopensearchservice_destination_configuration, Hash,
         callbacks: {
           "Subproperty `DomainARN` is not a String" => lambda { |v| v[:DomainARN].is_a? String },
           "Subproperty `DomainARN` needs to be 1..512 characters" => lambda { |v| v[:DomainARN].length >= 1 && v[:DomainARN].length <= 512 },
           "Subproperty `DomainARN` must match pattern arn:.*" => lambda { |v| v[:DomainARN] =~ Regexp.new("/arn:.*/") },
           "Subproperty `IndexName` is not a String" => lambda { |v| v[:IndexName].is_a? String },
           "Subproperty `IndexName` needs to be 1..80 characters" => lambda { |v| v[:IndexName].length >= 1 && v[:IndexName].length <= 80 },
           "Subproperty `IndexRotationPeriod` is not a String" => lambda { |v| v[:IndexRotationPeriod].is_a? String },
           "Subproperty `IndexRotationPeriod`is not one of `NoRotation`, `OneHour`, `OneDay`, `OneWeek`, `OneMonth`" => lambda { |v| %w{NoRotation OneHour OneDay OneWeek OneMonth}.include? v[:IndexRotationPeriod] },
           "Subproperty `RoleARN` is not a String" => lambda { |v| v[:RoleARN].is_a? String },
           "Subproperty `RoleARN` needs to be 1..512 characters" => lambda { |v| v[:RoleARN].length >= 1 && v[:RoleARN].length <= 512 },
           "Subproperty `RoleARN` must match pattern arn:.*" => lambda { |v| v[:RoleARN] =~ Regexp.new("/arn:.*/") },
           "Subproperty `S3BackupMode` is not a String" => lambda { |v| v[:S3BackupMode].is_a? String },
           "Subproperty `S3BackupMode`is not one of `FailedDocumentsOnly`, `AllDocuments`" => lambda { |v| %w{FailedDocumentsOnly AllDocuments}.include? v[:S3BackupMode] },
           "Subproperty `ClusterEndpoint` is not a String" => lambda { |v| v[:ClusterEndpoint].is_a? String },
           "Subproperty `ClusterEndpoint` needs to be 1..512 characters" => lambda { |v| v[:ClusterEndpoint].length >= 1 && v[:ClusterEndpoint].length <= 512 },
           "Subproperty `ClusterEndpoint` must match pattern https:.*" => lambda { |v| v[:ClusterEndpoint] =~ Regexp.new("/https:.*/") },
           "Subproperty `TypeName` is not a String" => lambda { |v| v[:TypeName].is_a? String },
           "Subproperty `TypeName` needs to be 0..100 characters" => lambda { |v| v[:TypeName].length >= 0 && v[:TypeName].length <= 100 },
         },
         description: ""

property :delivery_stream_encryption_configuration_input, Hash,
         callbacks: {
           "Subproperty `KeyARN` is not a String" => lambda { |v| v[:KeyARN].is_a? String },
           "Subproperty `KeyARN` needs to be 1..512 characters" => lambda { |v| v[:KeyARN].length >= 1 && v[:KeyARN].length <= 512 },
           "Subproperty `KeyARN` must match pattern arn:.*" => lambda { |v| v[:KeyARN] =~ Regexp.new("/arn:.*/") },
           "Subproperty `KeyType` is not a String" => lambda { |v| v[:KeyType].is_a? String },
           "Subproperty `KeyType`is not one of `AWS_OWNED_CMK`, `CUSTOMER_MANAGED_CMK`" => lambda { |v| %w{AWS_OWNED_CMK CUSTOMER_MANAGED_CMK}.include? v[:KeyType] },
         },
         description: ""

property :delivery_stream_name, String,
         callbacks: {
           "delivery_stream_name is not a String" => lambda { |v| v.is_a? String },
           "delivery_stream_name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "delivery_stream_name must match pattern [a-zA-Z0-9._-]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9._-]+/") },
         },
         description: ""

property :delivery_stream_type, String,
         callbacks: {
           "delivery_stream_type is not a String" => lambda { |v| v.is_a? String },
           "delivery_stream_typeis not one of `DirectPut`, `KinesisStreamAsSource`" => lambda { |v| %w{DirectPut KinesisStreamAsSource}.include? v },
         },
         description: ""

property :elasticsearch_destination_configuration, Hash,
         callbacks: {
           "Subproperty `DomainARN` is not a String" => lambda { |v| v[:DomainARN].is_a? String },
           "Subproperty `DomainARN` needs to be 1..512 characters" => lambda { |v| v[:DomainARN].length >= 1 && v[:DomainARN].length <= 512 },
           "Subproperty `DomainARN` must match pattern arn:.*" => lambda { |v| v[:DomainARN] =~ Regexp.new("/arn:.*/") },
           "Subproperty `IndexName` is not a String" => lambda { |v| v[:IndexName].is_a? String },
           "Subproperty `IndexName` needs to be 1..80 characters" => lambda { |v| v[:IndexName].length >= 1 && v[:IndexName].length <= 80 },
           "Subproperty `IndexRotationPeriod` is not a String" => lambda { |v| v[:IndexRotationPeriod].is_a? String },
           "Subproperty `IndexRotationPeriod`is not one of `NoRotation`, `OneHour`, `OneDay`, `OneWeek`, `OneMonth`" => lambda { |v| %w{NoRotation OneHour OneDay OneWeek OneMonth}.include? v[:IndexRotationPeriod] },
           "Subproperty `RoleARN` is not a String" => lambda { |v| v[:RoleARN].is_a? String },
           "Subproperty `RoleARN` needs to be 1..512 characters" => lambda { |v| v[:RoleARN].length >= 1 && v[:RoleARN].length <= 512 },
           "Subproperty `RoleARN` must match pattern arn:.*" => lambda { |v| v[:RoleARN] =~ Regexp.new("/arn:.*/") },
           "Subproperty `S3BackupMode` is not a String" => lambda { |v| v[:S3BackupMode].is_a? String },
           "Subproperty `S3BackupMode`is not one of `FailedDocumentsOnly`, `AllDocuments`" => lambda { |v| %w{FailedDocumentsOnly AllDocuments}.include? v[:S3BackupMode] },
           "Subproperty `ClusterEndpoint` is not a String" => lambda { |v| v[:ClusterEndpoint].is_a? String },
           "Subproperty `ClusterEndpoint` needs to be 1..512 characters" => lambda { |v| v[:ClusterEndpoint].length >= 1 && v[:ClusterEndpoint].length <= 512 },
           "Subproperty `ClusterEndpoint` must match pattern https:.*" => lambda { |v| v[:ClusterEndpoint] =~ Regexp.new("/https:.*/") },
           "Subproperty `TypeName` is not a String" => lambda { |v| v[:TypeName].is_a? String },
           "Subproperty `TypeName` needs to be 0..100 characters" => lambda { |v| v[:TypeName].length >= 0 && v[:TypeName].length <= 100 },
         },
         description: ""

property :extended_s3_destination_configuration, Hash,
         callbacks: {
           "Subproperty `BucketARN` is not a String" => lambda { |v| v[:BucketARN].is_a? String },
           "Subproperty `BucketARN` needs to be 1..2048 characters" => lambda { |v| v[:BucketARN].length >= 1 && v[:BucketARN].length <= 2048 },
           "Subproperty `BucketARN` must match pattern arn:.*" => lambda { |v| v[:BucketARN] =~ Regexp.new("/arn:.*/") },
           "Subproperty `CompressionFormat` is not a String" => lambda { |v| v[:CompressionFormat].is_a? String },
           "Subproperty `CompressionFormat`is not one of `UNCOMPRESSED`, `GZIP`, `ZIP`, `Snappy`, `HADOOP_SNAPPY`" => lambda { |v| %w{UNCOMPRESSED GZIP ZIP Snappy HADOOP_SNAPPY}.include? v[:CompressionFormat] },
           "Subproperty `ErrorOutputPrefix` is not a String" => lambda { |v| v[:ErrorOutputPrefix].is_a? String },
           "Subproperty `ErrorOutputPrefix` needs to be 0..1024 characters" => lambda { |v| v[:ErrorOutputPrefix].length >= 0 && v[:ErrorOutputPrefix].length <= 1024 },
           "Subproperty `Prefix` is not a String" => lambda { |v| v[:Prefix].is_a? String },
           "Subproperty `Prefix` needs to be 0..1024 characters" => lambda { |v| v[:Prefix].length >= 0 && v[:Prefix].length <= 1024 },
           "Subproperty `RoleARN` is not a String" => lambda { |v| v[:RoleARN].is_a? String },
           "Subproperty `RoleARN` needs to be 1..512 characters" => lambda { |v| v[:RoleARN].length >= 1 && v[:RoleARN].length <= 512 },
           "Subproperty `RoleARN` must match pattern arn:.*" => lambda { |v| v[:RoleARN] =~ Regexp.new("/arn:.*/") },
           "Subproperty `S3BackupMode` is not a String" => lambda { |v| v[:S3BackupMode].is_a? String },
           "Subproperty `S3BackupMode`is not one of `Disabled`, `Enabled`" => lambda { |v| %w{Disabled Enabled}.include? v[:S3BackupMode] },
         },
         description: ""

property :http_endpoint_destination_configuration, Hash,
         callbacks: {
           "Subproperty `RoleARN` is not a String" => lambda { |v| v[:RoleARN].is_a? String },
           "Subproperty `RoleARN` needs to be 1..512 characters" => lambda { |v| v[:RoleARN].length >= 1 && v[:RoleARN].length <= 512 },
           "Subproperty `RoleARN` must match pattern arn:.*" => lambda { |v| v[:RoleARN] =~ Regexp.new("/arn:.*/") },
           "Subproperty `S3BackupMode` is not a String" => lambda { |v| v[:S3BackupMode].is_a? String },
         },
         description: ""

property :kinesis_stream_source_configuration, Hash,
         callbacks: {
           "Subproperty `KinesisStreamARN` is not a String" => lambda { |v| v[:KinesisStreamARN].is_a? String },
           "Subproperty `KinesisStreamARN` needs to be 1..512 characters" => lambda { |v| v[:KinesisStreamARN].length >= 1 && v[:KinesisStreamARN].length <= 512 },
           "Subproperty `KinesisStreamARN` must match pattern arn:.*" => lambda { |v| v[:KinesisStreamARN] =~ Regexp.new("/arn:.*/") },
           "Subproperty `RoleARN` is not a String" => lambda { |v| v[:RoleARN].is_a? String },
           "Subproperty `RoleARN` needs to be 1..512 characters" => lambda { |v| v[:RoleARN].length >= 1 && v[:RoleARN].length <= 512 },
           "Subproperty `RoleARN` must match pattern arn:.*" => lambda { |v| v[:RoleARN] =~ Regexp.new("/arn:.*/") },
         },
         description: ""

property :redshift_destination_configuration, Hash,
         callbacks: {
           "Subproperty `ClusterJDBCURL` is not a String" => lambda { |v| v[:ClusterJDBCURL].is_a? String },
           "Subproperty `ClusterJDBCURL` needs to be 1..512 characters" => lambda { |v| v[:ClusterJDBCURL].length >= 1 && v[:ClusterJDBCURL].length <= 512 },
           "Subproperty `Password` is not a String" => lambda { |v| v[:Password].is_a? String },
           "Subproperty `Password` needs to be 6..512 characters" => lambda { |v| v[:Password].length >= 6 && v[:Password].length <= 512 },
           "Subproperty `RoleARN` is not a String" => lambda { |v| v[:RoleARN].is_a? String },
           "Subproperty `RoleARN` needs to be 1..512 characters" => lambda { |v| v[:RoleARN].length >= 1 && v[:RoleARN].length <= 512 },
           "Subproperty `RoleARN` must match pattern arn:.*" => lambda { |v| v[:RoleARN] =~ Regexp.new("/arn:.*/") },
           "Subproperty `S3BackupMode` is not a String" => lambda { |v| v[:S3BackupMode].is_a? String },
           "Subproperty `S3BackupMode`is not one of `Disabled`, `Enabled`" => lambda { |v| %w{Disabled Enabled}.include? v[:S3BackupMode] },
           "Subproperty `Username` is not a String" => lambda { |v| v[:Username].is_a? String },
           "Subproperty `Username` needs to be 1..512 characters" => lambda { |v| v[:Username].length >= 1 && v[:Username].length <= 512 },
         },
         description: ""

property :s3_destination_configuration, Hash,
         callbacks: {
           "Subproperty `BucketARN` is not a String" => lambda { |v| v[:BucketARN].is_a? String },
           "Subproperty `BucketARN` needs to be 1..2048 characters" => lambda { |v| v[:BucketARN].length >= 1 && v[:BucketARN].length <= 2048 },
           "Subproperty `BucketARN` must match pattern arn:.*" => lambda { |v| v[:BucketARN] =~ Regexp.new("/arn:.*/") },
           "Subproperty `CompressionFormat` is not a String" => lambda { |v| v[:CompressionFormat].is_a? String },
           "Subproperty `CompressionFormat`is not one of `UNCOMPRESSED`, `GZIP`, `ZIP`, `Snappy`, `HADOOP_SNAPPY`" => lambda { |v| %w{UNCOMPRESSED GZIP ZIP Snappy HADOOP_SNAPPY}.include? v[:CompressionFormat] },
           "Subproperty `ErrorOutputPrefix` is not a String" => lambda { |v| v[:ErrorOutputPrefix].is_a? String },
           "Subproperty `ErrorOutputPrefix` needs to be 0..1024 characters" => lambda { |v| v[:ErrorOutputPrefix].length >= 0 && v[:ErrorOutputPrefix].length <= 1024 },
           "Subproperty `Prefix` is not a String" => lambda { |v| v[:Prefix].is_a? String },
           "Subproperty `Prefix` needs to be 0..1024 characters" => lambda { |v| v[:Prefix].length >= 0 && v[:Prefix].length <= 1024 },
           "Subproperty `RoleARN` is not a String" => lambda { |v| v[:RoleARN].is_a? String },
           "Subproperty `RoleARN` needs to be 1..512 characters" => lambda { |v| v[:RoleARN].length >= 1 && v[:RoleARN].length <= 512 },
           "Subproperty `RoleARN` must match pattern arn:.*" => lambda { |v| v[:RoleARN] =~ Regexp.new("/arn:.*/") },
         },
         description: ""

property :splunk_destination_configuration, Hash,
         callbacks: {
           "Subproperty `HECAcknowledgmentTimeoutInSeconds` is not a Integer" => lambda { |v| v[:HECAcknowledgmentTimeoutInSeconds].is_a? Integer },
           "Subproperty `HECEndpoint` is not a String" => lambda { |v| v[:HECEndpoint].is_a? String },
           "Subproperty `HECEndpoint` needs to be 0..2048 characters" => lambda { |v| v[:HECEndpoint].length >= 0 && v[:HECEndpoint].length <= 2048 },
           "Subproperty `HECEndpointType` is not a String" => lambda { |v| v[:HECEndpointType].is_a? String },
           "Subproperty `HECEndpointType`is not one of `Raw`, `Event`" => lambda { |v| %w{Raw Event}.include? v[:HECEndpointType] },
           "Subproperty `HECToken` is not a String" => lambda { |v| v[:HECToken].is_a? String },
           "Subproperty `HECToken` needs to be 0..2048 characters" => lambda { |v| v[:HECToken].length >= 0 && v[:HECToken].length <= 2048 },
           "Subproperty `S3BackupMode` is not a String" => lambda { |v| v[:S3BackupMode].is_a? String },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::KinesisFirehose::DeliveryStream"
rest_api_document "/AWS::KinesisFirehose::DeliveryStream"

rest_property_map({
  amazonopensearchservice_destination_configuration: "AmazonopensearchserviceDestinationConfiguration",
  delivery_stream_encryption_configuration_input:    "DeliveryStreamEncryptionConfigurationInput",
  delivery_stream_name:                              "DeliveryStreamName",
  delivery_stream_type:                              "DeliveryStreamType",
  elasticsearch_destination_configuration:           "ElasticsearchDestinationConfiguration",
  extended_s3_destination_configuration:             "ExtendedS3DestinationConfiguration",
  http_endpoint_destination_configuration:           "HttpEndpointDestinationConfiguration",
  kinesis_stream_source_configuration:               "KinesisStreamSourceConfiguration",
  redshift_destination_configuration:                "RedshiftDestinationConfiguration",
  s3_destination_configuration:                      "S3DestinationConfiguration",
  splunk_destination_configuration:                  "SplunkDestinationConfiguration",
  tags:                                              "Tags",
})

rest_post_only_properties %i{
  amazonopensearchservice_destination_configuration/vpc_configuration delivery_stream_name delivery_stream_type elasticsearch_destination_configuration/vpc_configuration kinesis_stream_source_configuration
}
