# Import API specifics
use "awscc_base"

resource_name :aws_pca_connector_ad_directory_registration
provides :aws_pca_connector_ad_directory_registration, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::PCAConnectorAD::DirectoryRegistration Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :directory_id, String,
         required: true,
         callbacks: {
           "directory_id is not a String" => lambda { |v| v.is_a? String },
           "directory_id must match pattern ^d-[0-9a-f]{10}$" => lambda { |v| v =~ Regexp.new("/^d-[0-9a-f]{10}$/") },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::PCAConnectorAD::DirectoryRegistration"
rest_api_document "/AWS::PCAConnectorAD::DirectoryRegistration"

rest_property_map({
  directory_id: "DirectoryId",
  tags:         "Tags",
})

rest_post_only_properties %i{
  directory_id
}
