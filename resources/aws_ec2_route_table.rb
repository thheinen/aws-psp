# Import API specifics
use "awscc_base"

resource_name :aws_ec2_route_table
provides :aws_ec2_route_table, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::RouteTable
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Any tags assigned to the route table.
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
rest_api_collection "/AWS::EC2::RouteTable"
rest_api_document "/AWS::EC2::RouteTable"

rest_property_map({
  tags:   "Tags",
  vpc_id: "VpcId",
})

rest_post_only_properties %i{
  vpc_id
}
