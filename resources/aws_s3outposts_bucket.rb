# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_s3outposts_bucket
provides :aws_s3outposts_bucket, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type Definition for AWS::S3Outposts::Bucket
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :bucket_name, String,
         required: true,
         callbacks: {
           "bucket_name is not a String" => lambda { |v| v.is_a? String },
           "bucket_name needs to be 3..63 characters" => lambda { |v| v.length >= 3 && v.length <= 63 },
           "bucket_name must match pattern (?=^.{3,63}$)(?!^(\d+\.)+\d+$)(^(([a-z0-9]|[a-z0-9][a-z0-9\-]*[a-z0-9])\.)*([a-z0-9]|[a-z0-9][a-z0-9\-]*[a-z0-9])$)" => lambda { |v| v =~ Regexp.new("/(?=^.{3,63}$)(?!^(\d+\.)+\d+$)(^(([a-z0-9]|[a-z0-9][a-z0-9\-]*[a-z0-9])\.)*([a-z0-9]|[a-z0-9][a-z0-9\-]*[a-z0-9])$)/") },
         },
         description: <<~'DESCRIPTION'
           A name for the bucket.
         DESCRIPTION

property :lifecycle_configuration, Hash,
         callbacks: {
           "Subproperty `Rules` is not a Array" => lambda { |v| v[:Rules].is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Rules that define how Amazon S3Outposts manages objects during their lifetime.
         DESCRIPTION

property :outpost_id, String,
         required: true,
         callbacks: {
           "outpost_id is not a String" => lambda { |v| v.is_a? String },
           "outpost_id must match pattern ^(op-[a-f0-9]{17}|\d{12}|ec2)$" => lambda { |v| v =~ Regexp.new("/^(op-[a-f0-9]{17}|\d{12}|ec2)$/") },
         },
         description: <<~'DESCRIPTION'
           The id of the customer outpost on which the bucket resides.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An arbitrary set of tags (key-value pairs) for this S3Outposts bucket.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::S3Outposts::Bucket"
rest_api_document "/AWS::S3Outposts::Bucket"

rest_property_map({
  bucket_name:             "BucketName",
  lifecycle_configuration: "LifecycleConfiguration",
  outpost_id:              "OutpostId",
  tags:                    "Tags",
})

rest_post_only_properties %i{
  bucket_name outpost_id
}
