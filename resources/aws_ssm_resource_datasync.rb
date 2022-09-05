# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_ssm_resource_datasync
provides :aws_ssm_resource_datasync, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SSM::ResourceDataSync
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :bucket_name, String,
         callbacks: {
           "bucket_name is not a String" => lambda { |v| v.is_a? String },
           "bucket_name needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
         },
         description: ""

property :bucket_prefix, String,
         callbacks: {
           "bucket_prefix is not a String" => lambda { |v| v.is_a? String },
           "bucket_prefix needs to be 0..64 characters" => lambda { |v| v.length >= 0 && v.length <= 64 },
         },
         description: ""

property :bucket_region, String,
         callbacks: {
           "bucket_region is not a String" => lambda { |v| v.is_a? String },
           "bucket_region needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
         },
         description: ""

property :kms_key_arn, String,
         callbacks: {
           "kms_key_arn is not a String" => lambda { |v| v.is_a? String },
           "kms_key_arn needs to be 0..512 characters" => lambda { |v| v.length >= 0 && v.length <= 512 },
         },
         description: ""

property :s3_destination, Hash,
         callbacks: {
           "Subproperty `KMSKeyArn` is not a String" => lambda { |v| v[:KMSKeyArn].is_a? String },
           "Subproperty `KMSKeyArn` needs to be 1..512 characters" => lambda { |v| v[:KMSKeyArn].length >= 1 && v[:KMSKeyArn].length <= 512 },
           "Subproperty `KMSKeyArn`is not a valid ARN" => lambda { |v| v[:KMSKeyArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `BucketPrefix` is not a String" => lambda { |v| v[:BucketPrefix].is_a? String },
           "Subproperty `BucketPrefix` needs to be 1..256 characters" => lambda { |v| v[:BucketPrefix].length >= 1 && v[:BucketPrefix].length <= 256 },
           "Subproperty `BucketName` is not a String" => lambda { |v| v[:BucketName].is_a? String },
           "Subproperty `BucketName` needs to be 1..2048 characters" => lambda { |v| v[:BucketName].length >= 1 && v[:BucketName].length <= 2048 },
           "Subproperty `BucketRegion` is not a String" => lambda { |v| v[:BucketRegion].is_a? String },
           "Subproperty `BucketRegion` needs to be 1..64 characters" => lambda { |v| v[:BucketRegion].length >= 1 && v[:BucketRegion].length <= 64 },
           "Subproperty `SyncFormat` is not a String" => lambda { |v| v[:SyncFormat].is_a? String },
           "Subproperty `SyncFormat` needs to be 1..1024 characters" => lambda { |v| v[:SyncFormat].length >= 1 && v[:SyncFormat].length <= 1024 },
         },
         description: ""

property :sync_format, String,
         callbacks: {
           "sync_format is not a String" => lambda { |v| v.is_a? String },
           "sync_format needs to be 0..1024 characters" => lambda { |v| v.length >= 0 && v.length <= 1024 },
         },
         description: ""

property :sync_source, Hash,
         callbacks: {
           "Subproperty `IncludeFutureRegions` is not a Boolean" => lambda { |v| v[:IncludeFutureRegions].is_a? Boolean },
           "Subproperty `SourceRegions` is not a Array" => lambda { |v| v[:SourceRegions].is_a? Array },
           "Subproperty `SourceType` is not a String" => lambda { |v| v[:SourceType].is_a? String },
           "Subproperty `SourceType` needs to be 1..64 characters" => lambda { |v| v[:SourceType].length >= 1 && v[:SourceType].length <= 64 },
         },
         description: ""

property :sync_type, String,
         callbacks: {
           "sync_type is not a String" => lambda { |v| v.is_a? String },
           "sync_type needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::SSM::ResourceDataSync"
rest_api_document "/AWS::SSM::ResourceDataSync"

rest_property_map({
  bucket_name:    "BucketName",
  bucket_prefix:  "BucketPrefix",
  bucket_region:  "BucketRegion",
  kms_key_arn:    "KMSKeyArn",
  s3_destination: "S3Destination",
  sync_format:    "SyncFormat",
  sync_source:    "SyncSource",
  sync_type:      "SyncType",
})

rest_post_only_properties %i{
  bucket_name bucket_prefix bucket_region kms_key_arn s3_destination sync_format sync_name sync_type
}
