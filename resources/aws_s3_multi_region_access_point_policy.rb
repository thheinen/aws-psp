# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_s3_multi_region_access_point_policy
provides :aws_s3_multi_region_access_point_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The policy to be attached to a Multi Region Access Point
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :mrap_name, String,
         required: true,
         callbacks: {
           "mrap_name is not a String" => lambda { |v| v.is_a? String },
           "mrap_name needs to be 3..50 characters" => lambda { |v| v.length >= 3 && v.length <= 50 },
           "mrap_name must match pattern ^[a-z0-9][-a-z0-9]{1,48}[a-z0-9]$" => lambda { |v| v =~ Regexp.new("/^[a-z0-9][-a-z0-9]{1,48}[a-z0-9]$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the Multi Region Access Point to apply policy
         DESCRIPTION

property :policy, Hash,
         required: true,
         callbacks: {
           "policy is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           Policy document to apply to a Multi Region Access Point
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::S3::MultiRegionAccessPointPolicy"
rest_api_document "/AWS::S3::MultiRegionAccessPointPolicy"

rest_property_map({
  mrap_name: "MrapName",
  policy:    "Policy",
})

rest_post_only_properties %i{
  mrap_name
}
