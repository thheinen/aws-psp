# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_panorama_package
provides :aws_panorama_package, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Schema for Package CloudFormation Resource
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :package_name, Hash,
         required: true,
         callbacks: {
           "package_name is not a String" => lambda { |v| v.is_a? String },
           "package_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "package_name must match pattern ^[a-zA-Z0-9\-\_]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9\-\_]+$/") },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Panorama::Package"
rest_api_document "/AWS::Panorama::Package"

rest_property_map({
  package_name: "PackageName",
  tags:         "Tags",
})

rest_post_only_properties %i{
  package_name
}
