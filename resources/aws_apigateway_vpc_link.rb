# Import API specifics
use "awscc_base"

resource_name :aws_apigateway_vpc_link
provides :aws_apigateway_vpc_link, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Schema for AWS ApiGateway VpcLink
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A description of the VPC link.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A name for the VPC link.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of arbitrary tags (key-value pairs) to associate with the stage.
         DESCRIPTION

property :target_arns, Array,
         required: true,
         callbacks: {
           "target_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The ARN of network load balancer of the VPC targeted by the VPC link. The network load balancer must be owned by the same AWS account of the API owner.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ApiGateway::VpcLink"
rest_api_document "/AWS::ApiGateway::VpcLink"

rest_property_map({
  description: "Description",
  name:        "Name",
  tags:        "Tags",
  target_arns: "TargetArns",
})

rest_post_only_properties %i{
  target_arns
}
