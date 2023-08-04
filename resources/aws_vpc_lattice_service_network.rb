# Import API specifics
use "awscc_base"

resource_name :aws_vpc_lattice_service_network
provides :aws_vpc_lattice_service_network, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  A service network is a logical boundary for a collection of services. You can associate services and VPCs with a service network.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :auth_type, String,
         callbacks: {
           "auth_type is not a String" => lambda { |v| v.is_a? String },
           "auth_typeis not one of `NONE`, `AWS_IAM`" => lambda { |v| %w{NONE AWS_IAM}.include? v },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 3..63 characters" => lambda { |v| v.length >= 3 && v.length <= 63 },
           "name must match pattern ^(?!servicenetwork-)(?![-])(?!.*[-]$)(?!.*[-]{2})[a-z0-9-]+$" => lambda { |v| v =~ Regexp.new("/^(?!servicenetwork-)(?![-])(?!.*[-]$)(?!.*[-]{2})[a-z0-9-]+$/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::VpcLattice::ServiceNetwork"
rest_api_document "/AWS::VpcLattice::ServiceNetwork"

rest_property_map({
  auth_type: "AuthType",
  name:      "Name",
  tags:      "Tags",
})

rest_post_only_properties %i{
  name
}
