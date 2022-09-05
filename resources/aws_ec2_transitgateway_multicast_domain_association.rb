# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_ec2_transitgateway_multicast_domain_association
provides :aws_ec2_transitgateway_multicast_domain_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::EC2::TransitGatewayMulticastDomainAssociation type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :subnet_id, String,
         required: true,
         callbacks: {
           "subnet_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The IDs of the subnets to associate with the transit gateway multicast domain.
         DESCRIPTION

property :transitgateway_attachment_id, String,
         required: true,
         callbacks: {
           "transitgateway_attachment_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the transit gateway attachment.
         DESCRIPTION

property :transitgateway_multicast_domain_id, String,
         required: true,
         callbacks: {
           "transitgateway_multicast_domain_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the transit gateway multicast domain.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::TransitGatewayMulticastDomainAssociation"
rest_api_document "/AWS::EC2::TransitGatewayMulticastDomainAssociation"

rest_property_map({
  subnet_id:                          "SubnetId",
  transitgateway_attachment_id:       "TransitGatewayAttachmentId",
  transitgateway_multicast_domain_id: "TransitGatewayMulticastDomainId",
})

rest_post_only_properties %i{
  subnet_id transitgateway_attachment_id transitgateway_multicast_domain_id
}
