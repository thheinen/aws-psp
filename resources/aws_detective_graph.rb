# Import API specifics
use "awscc_base"

resource_name :aws_detective_graph
provides :aws_detective_graph, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::Detective::Graph
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Detective::Graph"
rest_api_document "/AWS::Detective::Graph"

rest_property_map({
  tags: "Tags",
})

