# Import API specifics
use "awscc_base"

resource_name :aws_ec2_transitgateway_attachment
provides :aws_ec2_transitgateway_attachment, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::TransitGatewayAttachment
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :options, Hash,
         callbacks: {
           "Subproperty `DnsSupport` is not a String" => lambda { |v| v[:DnsSupport].is_a? String },
           "Subproperty `Ipv6Support` is not a String" => lambda { |v| v[:Ipv6Support].is_a? String },
           "Subproperty `ApplianceModeSupport` is not a String" => lambda { |v| v[:ApplianceModeSupport].is_a? String },
         },
         description: <<~'DESCRIPTION'
           The options for the transit gateway vpc attachment.
         DESCRIPTION

property :subnet_ids, Array,
         required: true,
         callbacks: {
           "subnet_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :transitgateway_id, String,
         required: true,
         callbacks: {
           "transitgateway_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :vpc_id, String,
         required: true,
         callbacks: {
           "vpc_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::EC2::TransitGatewayAttachment"
rest_api_document "/AWS::EC2::TransitGatewayAttachment"

rest_property_map({
  options:           "Options",
  subnet_ids:        "SubnetIds",
  tags:              "Tags",
  transitgateway_id: "TransitGatewayId",
  vpc_id:            "VpcId",
})

rest_post_only_properties %i{
  transitgateway_id vpc_id
}
