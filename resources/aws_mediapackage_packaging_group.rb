# Import API specifics
use "awscc_base"

resource_name :aws_mediapackage_packaging_group
provides :aws_mediapackage_packaging_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::MediaPackage::PackagingGroup
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :authorization, Hash,
         callbacks: {
           "Subproperty `CdnIdentifierSecret` is not a String" => lambda { |v| v[:CdnIdentifierSecret].is_a? String },
           "Subproperty `SecretsRoleArn` is not a String" => lambda { |v| v[:SecretsRoleArn].is_a? String },
           "Subproperty `SecretsRoleArn`is not a valid ARN" => lambda { |v| v[:SecretsRoleArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: "CDN Authorization"

property :egress_access_logs, Hash,
         callbacks: {
           "Subproperty `LogGroupName` is not a String" => lambda { |v| v[:LogGroupName].is_a? String },
           "Subproperty `LogGroupName` needs to be 1..512 characters" => lambda { |v| v[:LogGroupName].length >= 1 && v[:LogGroupName].length <= 512 },
           "Subproperty `LogGroupName` must match pattern \A\/aws\/MediaPackage\/[0-9a-zA-Z-_\/\.#]+\Z" => lambda { |v| v[:LogGroupName] =~ Regexp.new("/\A\/aws\/MediaPackage\/[0-9a-zA-Z-_\/\.#]+\Z/") },
         },
         description: "The configuration parameters for egress access logging."

property :id, String,
         required: true,
         callbacks: {
           "id is not a String" => lambda { |v| v.is_a? String },
           "id needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "id must match pattern \A[0-9a-zA-Z-_]+\Z" => lambda { |v| v =~ Regexp.new("/\A[0-9a-zA-Z-_]+\Z/") },
         },
         description: "The ID of the PackagingGroup."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "A collection of tags associated with a resource"

# API URLs and mappings
rest_api_collection "/AWS::MediaPackage::PackagingGroup"
rest_api_document "/AWS::MediaPackage::PackagingGroup"

rest_property_map({
  authorization:      "Authorization",
  egress_access_logs: "EgressAccessLogs",
  id:                 "Id",
  tags:               "Tags",
})

rest_post_only_properties %i{
  id tags
}
