# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_imagebuilder_distribution_configuration
provides :aws_imagebuilder_distribution_configuration, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::ImageBuilder::DistributionConfiguration
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The description of the distribution configuration.
         DESCRIPTION

property :distributions, Array,
         required: true,
         callbacks: {
           "distributions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The distributions of the distribution configuration.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the distribution configuration.
         DESCRIPTION

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           The tags associated with the component.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ImageBuilder::DistributionConfiguration"
rest_api_document "/AWS::ImageBuilder::DistributionConfiguration"

rest_property_map({
  description:   "Description",
  distributions: "Distributions",
  name:          "Name",
  tags:          "Tags",
})

rest_post_only_properties %i{
  name
}
