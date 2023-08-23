# Import API specifics
use "awscc_base"

resource_name :aws_s3_bucket_policy
provides :aws_s3_bucket_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::S3::BucketPolicy
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :bucket, String,
         required: true,
         callbacks: {
           "bucket is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the Amazon S3 bucket to which the policy applies.
         DESCRIPTION

property :policy_document, [Hash, String],
         required: true,
         description: <<~'DESCRIPTION'
           A policy document containing permissions to add to the specified bucket. In IAM, you must provide policy documents in JSON format. However, in CloudFormation you can provide the policy in JSON or YAML format because CloudFormation converts YAML to JSON before submitting it to IAM.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::S3::BucketPolicy"
rest_api_document "/AWS::S3::BucketPolicy"

rest_property_map({
  bucket:          "Bucket",
  policy_document: "PolicyDocument",
})

rest_post_only_properties %i{
  bucket
}
