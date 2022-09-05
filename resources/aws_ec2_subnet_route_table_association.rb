# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_ec2_subnet_route_table_association
provides :aws_ec2_subnet_route_table_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::SubnetRouteTableAssociation
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :route_table_id, String,
         required: true,
         callbacks: {
           "route_table_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :subnet_id, String,
         required: true,
         callbacks: {
           "subnet_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::EC2::SubnetRouteTableAssociation"
rest_api_document "/AWS::EC2::SubnetRouteTableAssociation"

rest_property_map({
  route_table_id: "RouteTableId",
  subnet_id:      "SubnetId",
})

rest_post_only_properties %i{
  route_table_id subnet_id
}
