# Import API specifics
use "awscc_base"

resource_name :aws_vpc_lattice_listener
provides :aws_vpc_lattice_listener, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Creates a listener for a service. Before you start using your Amazon VPC Lattice service, you must add one or more listeners. A listener is a process that checks for connection requests to your services.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :default_action, Hash,
         required: true,
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 3..63 characters" => lambda { |v| v.length >= 3 && v.length <= 63 },
           "name must match pattern ^(?!listener-)(?![-])(?!.*[-]$)(?!.*[-]{2})[a-z0-9-]+$" => lambda { |v| v =~ Regexp.new("/^(?!listener-)(?![-])(?!.*[-]$)(?!.*[-]{2})[a-z0-9-]+$/") },
         },
         description: ""

property :port, Integer,
         callbacks: {
           "port is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :protocol, String,
         required: true,
         callbacks: {
           "protocol is not a String" => lambda { |v| v.is_a? String },
           "protocolis not one of `HTTP`, `HTTPS`" => lambda { |v| %w{HTTP HTTPS}.include? v },
         },
         description: ""

property :service_identifier, String,
         callbacks: {
           "service_identifier is not a String" => lambda { |v| v.is_a? String },
           "service_identifier needs to be 21..2048 characters" => lambda { |v| v.length >= 21 && v.length <= 2048 },
           "service_identifier must match pattern ^((svc-[0-9a-z]{17})|(arn:[a-z0-9\-]+:vpc-lattice:[a-zA-Z0-9\-]+:\d{12}:service/svc-[0-9a-z]{17}))$" => lambda { |v| v =~ Regexp.new("/^((svc-[0-9a-z]{17})|(arn:[a-z0-9\-]+:vpc-lattice:[a-zA-Z0-9\-]+:\d{12}:service/svc-[0-9a-z]{17}))$/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::VpcLattice::Listener"
rest_api_document "/AWS::VpcLattice::Listener"

rest_property_map({
  default_action:     "DefaultAction",
  name:               "Name",
  port:               "Port",
  protocol:           "Protocol",
  service_identifier: "ServiceIdentifier",
  tags:               "Tags",
})

rest_post_only_properties %i{
  name port protocol service_identifier
}
