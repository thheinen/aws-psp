# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_ec2_carrier_gateway
provides :aws_ec2_carrier_gateway, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  An example resource schema demonstrating some basic constructs and validation rules.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :tags, Hash,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags for the carrier gateway.
         DESCRIPTION

property :vpc_id, String,
         required: true,
         callbacks: {
           "vpc_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the VPC.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::CarrierGateway"
rest_api_document "/AWS::EC2::CarrierGateway"

rest_property_map({
  tags:   "Tags",
  vpc_id: "VpcId",
})

rest_post_only_properties %i{
  vpc_id
}
