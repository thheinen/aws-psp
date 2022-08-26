# Import API specifics
use "awscc_base"

resource_name :aws_devopsguru_resource_collection
provides :aws_devopsguru_resource_collection, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  This resource schema represents the ResourceCollection resource in the Amazon DevOps Guru.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :resource_collection_filter, Hash,
         required: true,
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::DevOpsGuru::ResourceCollection"
rest_api_document "/AWS::DevOpsGuru::ResourceCollection"

rest_property_map({
  resource_collection_filter: "ResourceCollectionFilter",
})

