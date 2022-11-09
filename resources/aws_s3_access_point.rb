# Import API specifics
use "awscc_base"

resource_name :aws_s3_access_point
provides :aws_s3_access_point, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::S3::AccessPoint resource is an Amazon S3 resource type that you can use to access buckets.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :bucket, String,
         required: true,
         callbacks: {
           "bucket is not a String" => lambda { |v| v.is_a? String },
           "bucket needs to be 3..255 characters" => lambda { |v| v.length >= 3 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           The name of the bucket that you want to associate this Access Point with.
         DESCRIPTION

property :bucket_account_id, String,
         callbacks: {
           "bucket_account_id is not a String" => lambda { |v| v.is_a? String },
           "bucket_account_id must match pattern ^\d{12}$" => lambda { |v| v =~ Regexp.new("/^\d{12}$/") },
         },
         description: <<~'DESCRIPTION'
           The AWS account ID associated with the S3 bucket associated with this access point.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 3..50 characters" => lambda { |v| v.length >= 3 && v.length <= 50 },
           "name must match pattern ^[a-z0-9]([a-z0-9\-]*[a-z0-9])?$" => lambda { |v| v =~ Regexp.new("/^[a-z0-9]([a-z0-9\-]*[a-z0-9])?$/") },
         },
         description: <<~'DESCRIPTION'
           The name you want to assign to this Access Point. If you don't specify a name, AWS CloudFormation generates a unique ID and uses that ID for the access point name.
         DESCRIPTION

property :policy, Hash,
         callbacks: {
           "policy is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           The Access Point Policy you want to apply to this access point.
         DESCRIPTION

property :policy_status, Hash,
         callbacks: {
           "Subproperty `IsPublic` is not a String" => lambda { |v| v[:IsPublic].is_a? String },
           "Subproperty `IsPublic`is not one of `true`, `false`" => lambda { |v| %w{true false}.include? v[:IsPublic] },
         },
         description: ""

property :public_access_block_configuration, Hash,
         callbacks: {
           "Subproperty `BlockPublicAcls` is not a Boolean" => lambda { |v| v[:BlockPublicAcls].is_a? Boolean },
           "Subproperty `IgnorePublicAcls` is not a Boolean" => lambda { |v| v[:IgnorePublicAcls].is_a? Boolean },
           "Subproperty `BlockPublicPolicy` is not a Boolean" => lambda { |v| v[:BlockPublicPolicy].is_a? Boolean },
           "Subproperty `RestrictPublicBuckets` is not a Boolean" => lambda { |v| v[:RestrictPublicBuckets].is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           The PublicAccessBlock configuration that you want to apply to this Access Point. You can enable the configuration options in any combination. For more information about when Amazon S3 considers a bucket or object public, see https://docs.aws.amazon.com/AmazonS3/latest/dev/access-control-block-public-access.html#access-control-block-public-access-policy-status 'The Meaning of Public' in the Amazon Simple Storage Service Developer Guide.
         DESCRIPTION

property :vpc_configuration, Hash,
         callbacks: {
           "Subproperty `VpcId` is not a String" => lambda { |v| v[:VpcId].is_a? String },
           "Subproperty `VpcId` needs to be 1..1024 characters" => lambda { |v| v[:VpcId].length >= 1 && v[:VpcId].length <= 1024 },
         },
         description: <<~'DESCRIPTION'
           If you include this field, Amazon S3 restricts access to this Access Point to requests from the specified Virtual Private Cloud (VPC).
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::S3::AccessPoint"
rest_api_document "/AWS::S3::AccessPoint"

rest_property_map({
  bucket:                            "Bucket",
  bucket_account_id:                 "BucketAccountId",
  name:                              "Name",
  policy:                            "Policy",
  policy_status:                     "PolicyStatus",
  public_access_block_configuration: "PublicAccessBlockConfiguration",
  vpc_configuration:                 "VpcConfiguration",
})

rest_post_only_properties %i{
  bucket bucket_account_id name public_access_block_configuration vpc_configuration
}
