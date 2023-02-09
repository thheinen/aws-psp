# Import API specifics
use "awscc_base"

resource_name :aws_sagemaker_space
provides :aws_sagemaker_space, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SageMaker::Space
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :domain_id, String,
         required: true,
         callbacks: {
           "domain_id is not a String" => lambda { |v| v.is_a? String },
           "domain_id needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
         },
         description: <<~'DESCRIPTION'
           The ID of the associated Domain.
         DESCRIPTION

property :space_name, String,
         required: true,
         callbacks: {
           "space_name is not a String" => lambda { |v| v.is_a? String },
           "space_name needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
         },
         description: <<~'DESCRIPTION'
           A name for the Space.
         DESCRIPTION

property :space_settings, Hash,
         description: <<~'DESCRIPTION'
           A collection of settings.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of tags to apply to the space.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SageMaker::Space"
rest_api_document "/AWS::SageMaker::Space"

rest_property_map({
  domain_id:      "DomainId",
  space_name:     "SpaceName",
  space_settings: "SpaceSettings",
  tags:           "Tags",
})

rest_post_only_properties %i{
  domain_id space_name
}
