# Import API specifics
use "awscc_base"

resource_name :aws_mediapackage_channel
provides :aws_mediapackage_channel, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::MediaPackage::Channel
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A short text description of the Channel.
         DESCRIPTION

property :egress_access_logs, Hash,
         callbacks: {
           "Subproperty `LogGroupName` is not a String" => lambda { |v| v[:LogGroupName].is_a? String },
           "Subproperty `LogGroupName` needs to be 1..256 characters" => lambda { |v| v[:LogGroupName].length >= 1 && v[:LogGroupName].length <= 256 },
           "Subproperty `LogGroupName` must match pattern \A^(\/aws\/MediaPackage\/)[a-zA-Z0-9_-]+\Z" => lambda { |v| v[:LogGroupName] =~ Regexp.new("/\A^(\/aws\/MediaPackage\/)[a-zA-Z0-9_-]+\Z/") },
         },
         description: <<~'DESCRIPTION'
           The configuration parameters for egress access logging.
         DESCRIPTION

property :id, String,
         required: true,
         callbacks: {
           "id is not a String" => lambda { |v| v.is_a? String },
           "id needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "id must match pattern \A[0-9a-zA-Z-_]+\Z" => lambda { |v| v =~ Regexp.new("/\A[0-9a-zA-Z-_]+\Z/") },
         },
         description: <<~'DESCRIPTION'
           The ID of the Channel.
         DESCRIPTION

property :ingress_access_logs, Hash,
         callbacks: {
           "Subproperty `LogGroupName` is not a String" => lambda { |v| v[:LogGroupName].is_a? String },
           "Subproperty `LogGroupName` needs to be 1..256 characters" => lambda { |v| v[:LogGroupName].length >= 1 && v[:LogGroupName].length <= 256 },
           "Subproperty `LogGroupName` must match pattern \A^(\/aws\/MediaPackage\/)[a-zA-Z0-9_-]+\Z" => lambda { |v| v[:LogGroupName] =~ Regexp.new("/\A^(\/aws\/MediaPackage\/)[a-zA-Z0-9_-]+\Z/") },
         },
         description: <<~'DESCRIPTION'
           The configuration parameters for egress access logging.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A collection of tags associated with a resource
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::MediaPackage::Channel"
rest_api_document "/AWS::MediaPackage::Channel"

rest_property_map({
  description:         "Description",
  egress_access_logs:  "EgressAccessLogs",
  id:                  "Id",
  ingress_access_logs: "IngressAccessLogs",
  tags:                "Tags",
})

rest_post_only_properties %i{
  id tags
}
