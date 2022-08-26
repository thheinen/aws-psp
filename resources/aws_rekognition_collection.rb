# Import API specifics
use "awscc_base"

resource_name :aws_rekognition_collection
provides :aws_rekognition_collection, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::Rekognition::Collection type creates an Amazon Rekognition Collection. A collection is a logical grouping of information about detected faces which can later be referenced for searches on the group
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :collection_id, Hash,
         required: true,
         callbacks: {
           "collection_id is not a String" => lambda { |v| v.is_a? String },
           "collection_id must match pattern \A[a-zA-Z0-9_\.\-]+$" => lambda { |v| v =~ Regexp.new("/\A[a-zA-Z0-9_\.\-]+$/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "An array of key-value pairs to apply to this resource."

# API URLs and mappings
rest_api_collection "/AWS::Rekognition::Collection"
rest_api_document "/AWS::Rekognition::Collection"

rest_property_map({
  collection_id: "CollectionId",
  tags:          "Tags",
})

rest_post_only_properties %i{
  collection_id
}
