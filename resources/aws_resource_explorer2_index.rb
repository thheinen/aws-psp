# Import API specifics
use "awscc_base"

resource_name :aws_resource_explorer2_index
provides :aws_resource_explorer2_index, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::ResourceExplorer2::Index Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :type, Hash,
         required: true,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
           "typeis not one of `LOCAL`, `AGGREGATOR`" => lambda { |v| %w{LOCAL AGGREGATOR}.include? v },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::ResourceExplorer2::Index"
rest_api_document "/AWS::ResourceExplorer2::Index"

rest_property_map({
  tags: "Tags",
  type: "Type",
})

