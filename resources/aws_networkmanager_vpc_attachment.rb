# Import API specifics
use "awscc_base"

resource_name :aws_networkmanager_vpc_attachment
provides :aws_networkmanager_vpc_attachment, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  AWS::NetworkManager::VpcAttachment Resoruce Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :core_network_id, String,
         callbacks: {
           "core_network_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of a core network for the VPC attachment.
         DESCRIPTION

property :options, Hash,
         callbacks: {
           "Subproperty `Ipv6Support` is not a Boolean" => lambda { |v| v[:Ipv6Support].is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Vpc options of the attachment.
         DESCRIPTION

property :subnet_arns, Array,
         callbacks: {
           "subnet_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Subnet Arn list
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Tags for the attachment.
         DESCRIPTION

property :vpc_arn, String,
         callbacks: {
           "vpc_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ARN of the VPC.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::NetworkManager::VpcAttachment"
rest_api_document "/AWS::NetworkManager::VpcAttachment"

rest_property_map({
  core_network_id: "CoreNetworkId",
  options:         "Options",
  subnet_arns:     "SubnetArns",
  tags:            "Tags",
  vpc_arn:         "VpcArn",
})

rest_post_only_properties %i{
  core_network_id vpc_arn
}
