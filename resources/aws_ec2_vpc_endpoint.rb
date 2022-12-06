# Import API specifics
use "awscc_base"

resource_name :aws_ec2_vpc_endpoint
provides :aws_ec2_vpc_endpoint, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::VPCEndpoint
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :policy_document, [String, Hash],
         description: <<~'DESCRIPTION'
           A policy to attach to the endpoint that controls access to the service.
         DESCRIPTION

property :private_dns_enabled, [TrueClass, FalseClass],
         callbacks: {
           "private_dns_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Indicate whether to associate a private hosted zone with the specified VPC.
         DESCRIPTION

property :route_table_ids, Array,
         callbacks: {
           "route_table_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           One or more route table IDs.
         DESCRIPTION

property :security_group_ids, Array,
         callbacks: {
           "security_group_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The ID of one or more security groups to associate with the endpoint network interface.
         DESCRIPTION

property :service_name, String,
         required: true,
         callbacks: {
           "service_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The service name.
         DESCRIPTION

property :subnet_ids, Array,
         callbacks: {
           "subnet_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The ID of one or more subnets in which to create an endpoint network interface.
         DESCRIPTION

property :vpc_endpoint_type, String,
         callbacks: {
           "vpc_endpoint_type is not a String" => lambda { |v| v.is_a? String },
           "vpc_endpoint_typeis not one of `Interface`, `Gateway`, `GatewayLoadBalancer`" => lambda { |v| %w{Interface Gateway GatewayLoadBalancer}.include? v },
         },
         description: ""

property :vpc_id, String,
         required: true,
         callbacks: {
           "vpc_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the VPC in which the endpoint will be used.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::VPCEndpoint"
rest_api_document "/AWS::EC2::VPCEndpoint"

rest_property_map({
  policy_document:     "PolicyDocument",
  private_dns_enabled: "PrivateDnsEnabled",
  route_table_ids:     "RouteTableIds",
  security_group_ids:  "SecurityGroupIds",
  service_name:        "ServiceName",
  subnet_ids:          "SubnetIds",
  vpc_endpoint_type:   "VpcEndpointType",
  vpc_id:              "VpcId",
})

rest_post_only_properties %i{
  service_name vpc_endpoint_type vpc_id
}
