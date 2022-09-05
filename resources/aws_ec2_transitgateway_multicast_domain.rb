# Import API specifics
use "awscc_base"

resource_name :aws_ec2_transitgateway_multicast_domain
provides :aws_ec2_transitgateway_multicast_domain, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::EC2::TransitGatewayMulticastDomain type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :options, Hash,
         callbacks: {
           "Subproperty `AutoAcceptSharedAssociations` is not a String" => lambda { |v| v[:AutoAcceptSharedAssociations].is_a? String },
           "Subproperty `Igmpv2Support` is not a String" => lambda { |v| v[:Igmpv2Support].is_a? String },
           "Subproperty `StaticSourcesSupport` is not a String" => lambda { |v| v[:StaticSourcesSupport].is_a? String },
         },
         description: <<~'DESCRIPTION'
           The options for the transit gateway multicast domain.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags for the transit gateway multicast domain.
         DESCRIPTION

property :transitgateway_id, String,
         required: true,
         callbacks: {
           "transitgateway_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the transit gateway.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::TransitGatewayMulticastDomain"
rest_api_document "/AWS::EC2::TransitGatewayMulticastDomain"

rest_property_map({
  options:           "Options",
  tags:              "Tags",
  transitgateway_id: "TransitGatewayId",
})

rest_post_only_properties %i{
  transitgateway_id
}
