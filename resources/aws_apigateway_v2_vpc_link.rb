# Import API specifics
use "awscc_base"

resource_name :aws_apigateway_v2_vpc_link
provides :aws_apigateway_v2_vpc_link, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ApiGatewayV2::VpcLink
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :security_group_ids, Array,
         callbacks: {
           "security_group_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :subnet_ids, Array,
         required: true,
         callbacks: {
           "subnet_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           This resource type use map for Tags, suggest to use List of Tag
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ApiGatewayV2::VpcLink"
rest_api_document "/AWS::ApiGatewayV2::VpcLink"

rest_property_map({
  name:               "Name",
  security_group_ids: "SecurityGroupIds",
  subnet_ids:         "SubnetIds",
  tags:               "Tags",
})

rest_post_only_properties %i{
  security_group_ids subnet_ids
}
