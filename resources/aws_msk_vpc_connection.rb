# Import API specifics
use "awscc_base"

resource_name :aws_msk_vpc_connection
provides :aws_msk_vpc_connection, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::MSK::VpcConnection
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :authentication, Hash,
         required: true,
         callbacks: {
           "authentication is not a String" => lambda { |v| v.is_a? String },
           "authentication needs to be 3..10 characters" => lambda { |v| v.length >= 3 && v.length <= 10 },
           "authenticationis not one of `SASL_IAM`, `SASL_SCRAM`, `TLS`" => lambda { |v| %w{SASL_IAM SASL_SCRAM TLS}.include? v },
         },
         description: ""

property :client_subnets, Hash,
         required: true,
         callbacks: {
           "client_subnets is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :security_groups, Hash,
         required: true,
         callbacks: {
           "security_groups is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :target_cluster_arn, String,
         required: true,
         callbacks: {
           "target_cluster_arn is not a String" => lambda { |v| v.is_a? String },
           "target_cluster_arn must match pattern ^arn:[\w-]+:kafka:[\w-]+:\d+:cluster.*\Z" => lambda { |v| v =~ Regexp.new("/^arn:[\w-]+:kafka:[\w-]+:\d+:cluster.*\Z/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the target cluster
         DESCRIPTION

property :vpc_id, Hash,
         required: true,
         callbacks: {
           "vpc_id is not a String" => lambda { |v| v.is_a? String },
           "vpc_id must match pattern ^(vpc-)([a-z0-9]+)\Z" => lambda { |v| v =~ Regexp.new("/^(vpc-)([a-z0-9]+)\Z/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::MSK::VpcConnection"
rest_api_document "/AWS::MSK::VpcConnection"

rest_property_map({
  authentication:     "Authentication",
  client_subnets:     "ClientSubnets",
  security_groups:    "SecurityGroups",
  tags:               "Tags",
  target_cluster_arn: "TargetClusterArn",
  vpc_id:             "VpcId",
})

rest_post_only_properties %i{
  authentication client_subnets security_groups target_cluster_arn vpc_id
}
