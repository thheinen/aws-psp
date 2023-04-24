# Import API specifics
use "awscc_base"

resource_name :aws_quicksight_vpc_connection
provides :aws_quicksight_vpc_connection, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of the AWS::QuickSight::VPCConnection Resource Type.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :availability_status, Hash,
         callbacks: {
           "availability_status is not a String" => lambda { |v| v.is_a? String },
           "availability_statusis not one of `AVAILABLE`, `UNAVAILABLE`, `PARTIALLY_AVAILABLE`" => lambda { |v| %w{AVAILABLE UNAVAILABLE PARTIALLY_AVAILABLE}.include? v },
         },
         description: ""

property :aws_account_id, String,
         callbacks: {
           "aws_account_id is not a String" => lambda { |v| v.is_a? String },
           "aws_account_id needs to be 12..12 characters" => lambda { |v| v.length >= 12 && v.length <= 12 },
           "aws_account_id must match pattern ^[0-9]{12}$" => lambda { |v| v =~ Regexp.new("/^[0-9]{12}$/") },
         },
         description: ""

property :dns_resolvers, Hash,
         callbacks: {
           "dns_resolvers is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
         },
         description: ""

property :role_arn, Hash,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :security_group_ids, Hash,
         callbacks: {
           "security_group_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :subnet_ids, Hash,
         callbacks: {
           "subnet_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :vpc_connection_id, Hash,
         callbacks: {
           "vpc_connection_id is not a String" => lambda { |v| v.is_a? String },
           "vpc_connection_id needs to be 1..1000 characters" => lambda { |v| v.length >= 1 && v.length <= 1000 },
           "vpc_connection_id must match pattern [\w\-]+" => lambda { |v| v =~ Regexp.new("/[\w\-]+/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::QuickSight::VPCConnection"
rest_api_document "/AWS::QuickSight::VPCConnection"

rest_property_map({
  availability_status: "AvailabilityStatus",
  aws_account_id:      "AwsAccountId",
  dns_resolvers:       "DnsResolvers",
  name:                "Name",
  role_arn:            "RoleArn",
  security_group_ids:  "SecurityGroupIds",
  subnet_ids:          "SubnetIds",
  tags:                "Tags",
  vpc_connection_id:   "VPCConnectionId",
})

rest_post_only_properties %i{
  aws_account_id vpc_connection_id
}
