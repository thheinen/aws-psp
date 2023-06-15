# Import API specifics
use "awscc_base"

resource_name :aws_mediaconnect_gateway
provides :aws_mediaconnect_gateway, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::MediaConnect::Gateway
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :egress_cidr_blocks, Array,
         required: true,
         callbacks: {
           "egress_cidr_blocks is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The range of IP addresses that contribute content or initiate output requests for flows communicating with this gateway. These IP addresses should be in the form of a Classless Inter-Domain Routing (CIDR) block; for example, 10.0.0.0/16.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the gateway. This name can not be modified after the gateway is created.
         DESCRIPTION

property :networks, Array,
         required: true,
         callbacks: {
           "networks is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The list of networks in the gateway.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::MediaConnect::Gateway"
rest_api_document "/AWS::MediaConnect::Gateway"

rest_property_map({
  egress_cidr_blocks: "EgressCidrBlocks",
  name:               "Name",
  networks:           "Networks",
})

rest_post_only_properties %i{
  egress_cidr_blocks name networks networks/cidr_block networks/name
}
