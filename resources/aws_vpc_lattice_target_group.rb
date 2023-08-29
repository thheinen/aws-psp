# Import API specifics
use "awscc_base"

resource_name :aws_vpc_lattice_target_group
provides :aws_vpc_lattice_target_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  A target group is a collection of targets, or compute resources, that run your application or service. A target group can only be used by a single service.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :config, Hash,
         callbacks: {
           "Subproperty `Port` is not a Integer" => lambda { |v| v[:Port].is_a? Integer },
           "Subproperty `Protocol` is not a String" => lambda { |v| v[:Protocol].is_a? String },
           "Subproperty `Protocol`is not one of `HTTP`, `HTTPS`" => lambda { |v| %w{HTTP HTTPS}.include? v[:Protocol] },
           "Subproperty `ProtocolVersion` is not a String" => lambda { |v| v[:ProtocolVersion].is_a? String },
           "Subproperty `ProtocolVersion`is not one of `HTTP1`, `HTTP2`, `GRPC`" => lambda { |v| %w{HTTP1 HTTP2 GRPC}.include? v[:ProtocolVersion] },
           "Subproperty `IpAddressType` is not a String" => lambda { |v| v[:IpAddressType].is_a? String },
           "Subproperty `IpAddressType`is not one of `IPV4`, `IPV6`" => lambda { |v| %w{IPV4 IPV6}.include? v[:IpAddressType] },
           "Subproperty `LambdaEventStructureVersion` is not a String" => lambda { |v| v[:LambdaEventStructureVersion].is_a? String },
           "Subproperty `LambdaEventStructureVersion`is not one of `V1`, `V2`" => lambda { |v| %w{V1 V2}.include? v[:LambdaEventStructureVersion] },
           "Subproperty `VpcIdentifier` is not a String" => lambda { |v| v[:VpcIdentifier].is_a? String },
           "Subproperty `VpcIdentifier` needs to be 5..2048 characters" => lambda { |v| v[:VpcIdentifier].length >= 5 && v[:VpcIdentifier].length <= 2048 },
           "Subproperty `VpcIdentifier` must match pattern ^vpc-(([0-9a-z]{8})|([0-9a-z]{17}))$" => lambda { |v| v[:VpcIdentifier] =~ Regexp.new("/^vpc-(([0-9a-z]{8})|([0-9a-z]{17}))$/") },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 3..128 characters" => lambda { |v| v.length >= 3 && v.length <= 128 },
           "name must match pattern ^(?!tg-)(?![-])(?!.*[-]$)(?!.*[-]{2})[a-z0-9-]+$" => lambda { |v| v =~ Regexp.new("/^(?!tg-)(?![-])(?!.*[-]$)(?!.*[-]{2})[a-z0-9-]+$/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :targets, Array,
         callbacks: {
           "targets is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :type, String,
         required: true,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
           "typeis not one of `IP`, `LAMBDA`, `INSTANCE`, `ALB`" => lambda { |v| %w{IP LAMBDA INSTANCE ALB}.include? v },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::VpcLattice::TargetGroup"
rest_api_document "/AWS::VpcLattice::TargetGroup"

rest_property_map({
  config:  "Config",
  name:    "Name",
  tags:    "Tags",
  targets: "Targets",
  type:    "Type",
})

rest_post_only_properties %i{
  config/ip_address_type config/lambda_event_structure_version config/port config/protocol config/protocol_version config/vpc_identifier name type
}
