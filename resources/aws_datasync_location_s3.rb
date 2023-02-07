# Import API specifics
use "awscc_base"

resource_name :aws_datasync_location_s3
provides :aws_datasync_location_s3, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::DataSync::LocationS3
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :s3_bucket_arn, String,
         callbacks: {
           "s3_bucket_arn is not a String" => lambda { |v| v.is_a? String },
           "s3_bucket_arn must match pattern ^arn:(aws|aws-cn|aws-us-gov|aws-iso|aws-iso-b):s3:[a-z\-0-9]*:[0-9]*:.*$" => lambda { |v| v =~ Regexp.new("/^arn:(aws|aws-cn|aws-us-gov|aws-iso|aws-iso-b):s3:[a-z\-0-9]*:[0-9]*:.*$/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the Amazon S3 bucket.
         DESCRIPTION

property :s3_config, Hash,
         required: true,
         callbacks: {
           "Subproperty `BucketAccessRoleArn` is not a String" => lambda { |v| v[:BucketAccessRoleArn].is_a? String },
           "Subproperty `BucketAccessRoleArn` must match pattern ^arn:(aws|aws-cn|aws-us-gov|aws-iso|aws-iso-b):iam::[0-9]{12}:role/.*$" => lambda { |v| v[:BucketAccessRoleArn] =~ Regexp.new("/^arn:(aws|aws-cn|aws-us-gov|aws-iso|aws-iso-b):iam::[0-9]{12}:role/.*$/") },
           "Subproperty `BucketAccessRoleArn`is not a valid ARN" => lambda { |v| v[:BucketAccessRoleArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: ""

property :s3_storage_class, String,
         callbacks: {
           "s3_storage_class is not a String" => lambda { |v| v.is_a? String },
           "s3_storage_classis not one of `STANDARD`, `STANDARD_IA`, `ONEZONE_IA`, `INTELLIGENT_TIERING`, `GLACIER`, `GLACIER_INSTANT_RETRIEVAL`, `DEEP_ARCHIVE`" => lambda { |v| %w{STANDARD STANDARD_IA ONEZONE_IA INTELLIGENT_TIERING GLACIER GLACIER_INSTANT_RETRIEVAL DEEP_ARCHIVE}.include? v },
         },
         description: <<~'DESCRIPTION'
           The Amazon S3 storage class you want to store your files in when this location is used as a task destination.
         DESCRIPTION

property :subdirectory, String,
         callbacks: {
           "subdirectory is not a String" => lambda { |v| v.is_a? String },
           "subdirectory must match pattern ^[\p{L}\p{M}\p{Z}\p{S}\p{N}\p{P}\p{C}]*$" => lambda { |v| v =~ Regexp.new("/^[\p{L}\p{M}\p{Z}\p{S}\p{N}\p{P}\p{C}]*$/") },
         },
         description: <<~'DESCRIPTION'
           A subdirectory in the Amazon S3 bucket. This subdirectory in Amazon S3 is used to read data from the S3 source location or write data to the S3 destination.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::DataSync::LocationS3"
rest_api_document "/AWS::DataSync::LocationS3"

rest_property_map({
  s3_bucket_arn:    "S3BucketArn",
  s3_config:        "S3Config",
  s3_storage_class: "S3StorageClass",
  subdirectory:     "Subdirectory",
  tags:             "Tags",
})

rest_post_only_properties %i{
  s3_bucket_arn s3_config s3_storage_class subdirectory
}
