# Import API specifics
use "awscc_base"

resource_name :aws_app_runner_vpc_connector
provides :aws_app_runner_vpc_connector, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::AppRunner::VpcConnector resource specifies an App Runner VpcConnector.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :security_groups, Array,
         callbacks: {
           "security_groups is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of IDs of security groups that App Runner should use for access to AWS resources under the specified subnets. If not specified, App Runner uses the default security group of the Amazon VPC. The default security group allows all outbound traffic.
         DESCRIPTION

property :subnets, Array,
         required: true,
         callbacks: {
           "subnets is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of IDs of subnets that App Runner should use when it associates your service with a custom Amazon VPC. Specify IDs of subnets of a single Amazon VPC. App Runner determines the Amazon VPC from the subnets you specify.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of metadata items that you can associate with your VPC connector resource. A tag is a key-value pair.
         DESCRIPTION

property :vpc_connector_name, String,
         callbacks: {
           "vpc_connector_name is not a String" => lambda { |v| v.is_a? String },
           "vpc_connector_name needs to be 4..40 characters" => lambda { |v| v.length >= 4 && v.length <= 40 },
           "vpc_connector_name must match pattern ^[A-Za-z0-9][A-Za-z0-9-\\_]{3,39}$" => lambda { |v| v =~ Regexp.new("/^[A-Za-z0-9][A-Za-z0-9-\\_]{3,39}$/") },
         },
         description: <<~'DESCRIPTION'
           A name for the VPC connector. If you don't specify a name, AWS CloudFormation generates a name for your VPC connector.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::AppRunner::VpcConnector"
rest_api_document "/AWS::AppRunner::VpcConnector"

rest_property_map({
  security_groups:    "SecurityGroups",
  subnets:            "Subnets",
  tags:               "Tags",
  vpc_connector_name: "VpcConnectorName",
})

rest_post_only_properties %i{
  security_groups subnets tags vpc_connector_name
}
