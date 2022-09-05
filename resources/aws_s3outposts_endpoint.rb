# Import API specifics
use "awscc_base"

resource_name :aws_s3outposts_endpoint
provides :aws_s3outposts_endpoint, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type Definition for AWS::S3Outposts::Endpoint
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :access_type, String,
         callbacks: {
           "access_type is not a String" => lambda { |v| v.is_a? String },
           "access_typeis not one of `CustomerOwnedIp`, `Private`" => lambda { |v| %w{CustomerOwnedIp Private}.include? v },
         },
         description: <<~'DESCRIPTION'
           The type of access for the on-premise network connectivity for the Outpost endpoint. To access endpoint from an on-premises network, you must specify the access type and provide the customer owned Ipv4 pool.
         DESCRIPTION

property :customer_owned_ipv4_pool, String,
         callbacks: {
           "customer_owned_ipv4_pool is not a String" => lambda { |v| v.is_a? String },
           "customer_owned_ipv4_pool must match pattern ^ipv4pool-coip-([0-9a-f]{17})$" => lambda { |v| v =~ Regexp.new("/^ipv4pool-coip-([0-9a-f]{17})$/") },
         },
         description: <<~'DESCRIPTION'
           The ID of the customer-owned IPv4 pool for the Endpoint. IP addresses will be allocated from this pool for the endpoint.
         DESCRIPTION

property :outpost_id, String,
         required: true,
         callbacks: {
           "outpost_id is not a String" => lambda { |v| v.is_a? String },
           "outpost_id must match pattern ^(op-[a-f0-9]{17}|\d{12}|ec2)$" => lambda { |v| v =~ Regexp.new("/^(op-[a-f0-9]{17}|\d{12}|ec2)$/") },
         },
         description: <<~'DESCRIPTION'
           The id of the customer outpost on which the bucket resides.
         DESCRIPTION

property :security_group_id, String,
         required: true,
         callbacks: {
           "security_group_id is not a String" => lambda { |v| v.is_a? String },
           "security_group_id needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "security_group_id must match pattern ^sg-([0-9a-f]{8}|[0-9a-f]{17})$" => lambda { |v| v =~ Regexp.new("/^sg-([0-9a-f]{8}|[0-9a-f]{17})$/") },
         },
         description: <<~'DESCRIPTION'
           The ID of the security group to use with the endpoint.
         DESCRIPTION

property :subnet_id, String,
         required: true,
         callbacks: {
           "subnet_id is not a String" => lambda { |v| v.is_a? String },
           "subnet_id needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "subnet_id must match pattern ^subnet-([0-9a-f]{8}|[0-9a-f]{17})$" => lambda { |v| v =~ Regexp.new("/^subnet-([0-9a-f]{8}|[0-9a-f]{17})$/") },
         },
         description: <<~'DESCRIPTION'
           The ID of the subnet in the selected VPC. The subnet must belong to the Outpost.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::S3Outposts::Endpoint"
rest_api_document "/AWS::S3Outposts::Endpoint"

rest_property_map({
  access_type:              "AccessType",
  customer_owned_ipv4_pool: "CustomerOwnedIpv4Pool",
  outpost_id:               "OutpostId",
  security_group_id:        "SecurityGroupId",
  subnet_id:                "SubnetId",
})

rest_post_only_properties %i{
  access_type customer_owned_ipv4_pool outpost_id security_group_id subnet_id
}
