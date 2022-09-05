# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_s3outposts_access_point
provides :aws_s3outposts_access_point, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type Definition for AWS::S3Outposts::AccessPoint
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
           The Amazon Resource Name (ARN) of the bucket you want to associate this AccessPoint with.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 3..50 characters" => lambda { |v| v.length >= 3 && v.length <= 50 },
           "name must match pattern ^[a-z0-9]([a-z0-9\\-]*[a-z0-9])?$" => lambda { |v| v =~ Regexp.new("/^[a-z0-9]([a-z0-9\\-]*[a-z0-9])?$/") },
         },
         description: <<~'DESCRIPTION'
           A name for the AccessPoint.
         DESCRIPTION

property :policy, Hash,
         callbacks: {
           "policy is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           The access point policy associated with this access point.
         DESCRIPTION

property :vpc_configuration, Hash,
         required: true,
         callbacks: {
           "Subproperty `VpcId` is not a String" => lambda { |v| v[:VpcId].is_a? String },
           "Subproperty `VpcId` needs to be 1..1024 characters" => lambda { |v| v[:VpcId].length >= 1 && v[:VpcId].length <= 1024 },
         },
         description: <<~'DESCRIPTION'
           Virtual Private Cloud (VPC) from which requests can be made to the AccessPoint.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::S3Outposts::AccessPoint"
rest_api_document "/AWS::S3Outposts::AccessPoint"

rest_property_map({
  bucket:            "Bucket",
  name:              "Name",
  policy:            "Policy",
  vpc_configuration: "VpcConfiguration",
})

rest_post_only_properties %i{
  bucket name vpc_configuration
}
