# Import API specifics
use "awscc_base"

resource_name :aws_mediapackage_asset
provides :aws_mediapackage_asset, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::MediaPackage::Asset
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :id, String,
         required: true,
         callbacks: {
           "id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The unique identifier for the Asset."

property :packaging_group_id, String,
         required: true,
         callbacks: {
           "packaging_group_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The ID of the PackagingGroup for the Asset."

property :resource_id, String,
         callbacks: {
           "resource_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The resource ID to include in SPEKE key requests."

property :source_arn, String,
         required: true,
         callbacks: {
           "source_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: "ARN of the source object in S3."

property :source_role_arn, String,
         required: true,
         callbacks: {
           "source_role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The IAM role_arn used to access the source S3 bucket."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "A collection of tags associated with a resource"

# API URLs and mappings
rest_api_collection "/AWS::MediaPackage::Asset"
rest_api_document "/AWS::MediaPackage::Asset"

rest_property_map({
  id:                 "Id",
  packaging_group_id: "PackagingGroupId",
  resource_id:        "ResourceId",
  source_arn:         "SourceArn",
  source_role_arn:    "SourceRoleArn",
  tags:               "Tags",
})

