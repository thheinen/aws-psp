# Import API specifics
use "awscc_base"

resource_name :aws_app_runner_vpc_ingress_connection
provides :aws_app_runner_vpc_ingress_connection, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::AppRunner::VpcIngressConnection resource is an App Runner resource that specifies an App Runner VpcIngressConnection.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :ingress_vpc_configuration, Hash,
         required: true,
         callbacks: {
           "Subproperty `VpcId` is not a String" => lambda { |v| v[:VpcId].is_a? String },
           "Subproperty `VpcEndpointId` is not a String" => lambda { |v| v[:VpcEndpointId].is_a? String },
         },
         description: ""

property :service_arn, String,
         required: true,
         callbacks: {
           "service_arn is not a String" => lambda { |v| v.is_a? String },
           "service_arn needs to be 1..1011 characters" => lambda { |v| v.length >= 1 && v.length <= 1011 },
           "service_arn must match pattern arn:aws(-[\w]+)*:[a-z0-9-\.]{0,63}:[a-z0-9-\.]{0,63}:[0-9]{12}:(\w|/|-){1,1011}" => lambda { |v| v =~ Regexp.new("/arn:aws(-[\w]+)*:[a-z0-9-\.]{0,63}:[a-z0-9-\.]{0,63}:[0-9]{12}:(\w|/|-){1,1011}/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the service.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :vpc_ingress_connection_name, String,
         callbacks: {
           "vpc_ingress_connection_name is not a String" => lambda { |v| v.is_a? String },
           "vpc_ingress_connection_name needs to be 4..40 characters" => lambda { |v| v.length >= 4 && v.length <= 40 },
           "vpc_ingress_connection_name must match pattern [A-Za-z0-9][A-Za-z0-9\-_]{3,39}" => lambda { |v| v =~ Regexp.new("/[A-Za-z0-9][A-Za-z0-9\-_]{3,39}/") },
         },
         description: <<~'DESCRIPTION'
           The customer-provided Vpc Ingress Connection name.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::AppRunner::VpcIngressConnection"
rest_api_document "/AWS::AppRunner::VpcIngressConnection"

rest_property_map({
  ingress_vpc_configuration:   "IngressVpcConfiguration",
  service_arn:                 "ServiceArn",
  tags:                        "Tags",
  vpc_ingress_connection_name: "VpcIngressConnectionName",
})

rest_post_only_properties %i{
  service_arn tags vpc_ingress_connection_name
}
