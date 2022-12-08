# Import API specifics
use "awscc_base"

resource_name :aws_ec2_egress_only_internet_gateway
provides :aws_ec2_egress_only_internet_gateway, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::EgressOnlyInternetGateway
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :vpc_id, String,
         required: true,
         callbacks: {
           "vpc_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the VPC for which to create the egress-only internet gateway.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::EgressOnlyInternetGateway"
rest_api_document "/AWS::EC2::EgressOnlyInternetGateway"

rest_property_map({
  vpc_id: "VpcId",
})

rest_post_only_properties %i{
  vpc_id
}
