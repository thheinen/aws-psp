# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_groundstation_dataflow_endpoint_group
provides :aws_groundstation_dataflow_endpoint_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  AWS Ground Station DataflowEndpointGroup schema for CloudFormation
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :endpoint_details, Array,
         required: true,
         callbacks: {
           "endpoint_details is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::GroundStation::DataflowEndpointGroup"
rest_api_document "/AWS::GroundStation::DataflowEndpointGroup"

rest_property_map({
  endpoint_details: "EndpointDetails",
  tags:             "Tags",
})

