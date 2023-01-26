# Import API specifics
use "awscc_base"

resource_name :aws_open_search_serverless_vpc_endpoint
provides :aws_open_search_serverless_vpc_endpoint, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Amazon OpenSearchServerless vpc endpoint resource
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 3..32 characters" => lambda { |v| v.length >= 3 && v.length <= 32 },
           "name must match pattern ^[a-z][a-z0-9-]{2,31}$" => lambda { |v| v =~ Regexp.new("/^[a-z][a-z0-9-]{2,31}$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the VPC Endpoint
         DESCRIPTION

property :security_group_ids, Array,
         callbacks: {
           "security_group_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The ID of one or more security groups to associate with the endpoint network interface
         DESCRIPTION

property :subnet_ids, Array,
         callbacks: {
           "subnet_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The ID of one or more subnets in which to create an endpoint network interface
         DESCRIPTION

property :vpc_id, String,
         required: true,
         callbacks: {
           "vpc_id is not a String" => lambda { |v| v.is_a? String },
           "vpc_id needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "vpc_id must match pattern ^vpc-[0-9a-z]*$" => lambda { |v| v =~ Regexp.new("/^vpc-[0-9a-z]*$/") },
         },
         description: <<~'DESCRIPTION'
           The ID of the VPC in which the endpoint will be used.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::OpenSearchServerless::VpcEndpoint"
rest_api_document "/AWS::OpenSearchServerless::VpcEndpoint"

rest_property_map({
  name:               "Name",
  security_group_ids: "SecurityGroupIds",
  subnet_ids:         "SubnetIds",
  vpc_id:             "VpcId",
})

rest_post_only_properties %i{
  name vpc_id
}
