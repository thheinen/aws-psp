# Import API specifics
use "awscc_base"

resource_name :aws_s3_multi_region_access_point
provides :aws_s3_multi_region_access_point, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  AWS::S3::MultiRegionAccessPoint is an Amazon S3 resource type that dynamically routes S3 requests to easily satisfy geographic compliance requirements based on customer-defined routing policies.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 3..50 characters" => lambda { |v| v.length >= 3 && v.length <= 50 },
           "name must match pattern ^[a-z0-9][-a-z0-9]{1,48}[a-z0-9]$" => lambda { |v| v =~ Regexp.new("/^[a-z0-9][-a-z0-9]{1,48}[a-z0-9]$/") },
         },
         description: "The name you want to assign to this Multi Region Access Point."

property :public_access_block_configuration, Hash,
         callbacks: {
           "Subproperty `BlockPublicAcls` is not a Boolean" => lambda { |v| v[:BlockPublicAcls].is_a? Boolean },
           "Subproperty `IgnorePublicAcls` is not a Boolean" => lambda { |v| v[:IgnorePublicAcls].is_a? Boolean },
           "Subproperty `BlockPublicPolicy` is not a Boolean" => lambda { |v| v[:BlockPublicPolicy].is_a? Boolean },
           "Subproperty `RestrictPublicBuckets` is not a Boolean" => lambda { |v| v[:RestrictPublicBuckets].is_a? Boolean },
         },
         description: "The PublicAccessBlock configuration that you want to apply to this Multi Region Access Point. You can enable the configuration options in any combination. For more information about when Amazon S3 considers a bucket or object public, see https://docs.aws.amazon.com/AmazonS3/latest/dev/access-control-block-public-access.html#access-control-block-public-access-policy-status 'The Meaning of Public' in the Amazon Simple Storage Service Developer Guide."

property :regions, Array,
         required: true,
         callbacks: {
           "regions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The list of buckets that you want to associate this Multi Region Access Point with."

# API URLs and mappings
rest_api_collection "/AWS::S3::MultiRegionAccessPoint"
rest_api_document "/AWS::S3::MultiRegionAccessPoint"

rest_property_map({
  name:                              "Name",
  public_access_block_configuration: "PublicAccessBlockConfiguration",
  regions:                           "Regions",
})

rest_post_only_properties %i{
  name public_access_block_configuration regions
}
