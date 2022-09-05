# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_s3outposts_bucket_policy
provides :aws_s3outposts_bucket_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type Definition for AWS::S3Outposts::BucketPolicy
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :bucket, String,
         required: true,
         callbacks: {
           "bucket is not a String" => lambda { |v| v.is_a? String },
           "bucket needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "bucket must match pattern ^arn:[^:]+:s3-outposts:[a-zA-Z0-9\-]+:\d{12}:outpost\/[^:]+\/bucket\/[^:]+$" => lambda { |v| v =~ Regexp.new("/^arn:[^:]+:s3-outposts:[a-zA-Z0-9\-]+:\d{12}:outpost\/[^:]+\/bucket\/[^:]+$/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the specified bucket.
         DESCRIPTION

property :policy_document, Hash,
         required: true,
         callbacks: {
           "policy_document is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           A policy document containing permissions to add to the specified bucket.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::S3Outposts::BucketPolicy"
rest_api_document "/AWS::S3Outposts::BucketPolicy"

rest_property_map({
  bucket:          "Bucket",
  policy_document: "PolicyDocument",
})

rest_post_only_properties %i{
  bucket
}
