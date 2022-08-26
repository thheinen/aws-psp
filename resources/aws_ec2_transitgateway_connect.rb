# Import API specifics
use "awscc_base"

resource_name :aws_ec2_transitgateway_connect
provides :aws_ec2_transitgateway_connect, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::EC2::TransitGatewayConnect type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :options, Hash,
         required: true,
         callbacks: {
           "Subproperty `Protocol` is not a String" => lambda { |v| v[:Protocol].is_a? String },
         },
         description: "The Connect attachment options."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The tags for the attachment."

property :transport_transitgateway_attachment_id, String,
         required: true,
         callbacks: {
           "transport_transitgateway_attachment_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The ID of the attachment from which the Connect attachment was created."

# API URLs and mappings
rest_api_collection "/AWS::EC2::TransitGatewayConnect"
rest_api_document "/AWS::EC2::TransitGatewayConnect"

rest_property_map({
  options:                                "Options",
  tags:                                   "Tags",
  transport_transitgateway_attachment_id: "TransportTransitGatewayAttachmentId",
})

rest_post_only_properties %i{
  options transport_transitgateway_attachment_id
}
