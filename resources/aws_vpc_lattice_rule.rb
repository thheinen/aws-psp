# Import API specifics
use "awscc_base"

resource_name :aws_vpc_lattice_rule
provides :aws_vpc_lattice_rule, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Creates a listener rule. Each listener has a default rule for checking connection requests, but you can define additional rules. Each rule consists of a priority, one or more actions, and one or more conditions.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :action, Hash,
         required: true,
         description: ""

property :listener_identifier, String,
         callbacks: {
           "listener_identifier is not a String" => lambda { |v| v.is_a? String },
           "listener_identifier needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "listener_identifier must match pattern ^((listener-[0-9a-z]{17})|(arn(:[a-z0-9]+([.-][a-z0-9]+)*){2}(:([a-z0-9]+([.-][a-z0-9]+)*)?){2}:service/svc-[0-9a-z]{17}/listener/listener-[0-9a-z]{17}))$" => lambda { |v| v =~ Regexp.new("/^((listener-[0-9a-z]{17})|(arn(:[a-z0-9]+([.-][a-z0-9]+)*){2}(:([a-z0-9]+([.-][a-z0-9]+)*)?){2}:service/svc-[0-9a-z]{17}/listener/listener-[0-9a-z]{17}))$/") },
         },
         description: ""

property :match, Hash,
         required: true,
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 3..63 characters" => lambda { |v| v.length >= 3 && v.length <= 63 },
           "name must match pattern ^(?!rule-)(?![-])(?!.*[-]$)(?!.*[-]{2})[a-z0-9-]+$" => lambda { |v| v =~ Regexp.new("/^(?!rule-)(?![-])(?!.*[-]$)(?!.*[-]{2})[a-z0-9-]+$/") },
         },
         description: ""

property :priority, Integer,
         required: true,
         callbacks: {
           "priority is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :service_identifier, String,
         callbacks: {
           "service_identifier is not a String" => lambda { |v| v.is_a? String },
           "service_identifier needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "service_identifier must match pattern ^((svc-[0-9a-z]{17})|(arn(:[a-z0-9]+([.-][a-z0-9]+)*){2}(:([a-z0-9]+([.-][a-z0-9]+)*)?){2}:service/svc-[0-9a-z]{17}))$" => lambda { |v| v =~ Regexp.new("/^((svc-[0-9a-z]{17})|(arn(:[a-z0-9]+([.-][a-z0-9]+)*){2}(:([a-z0-9]+([.-][a-z0-9]+)*)?){2}:service/svc-[0-9a-z]{17}))$/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::VpcLattice::Rule"
rest_api_document "/AWS::VpcLattice::Rule"

rest_property_map({
  action:              "Action",
  listener_identifier: "ListenerIdentifier",
  match:               "Match",
  name:                "Name",
  priority:            "Priority",
  service_identifier:  "ServiceIdentifier",
  tags:                "Tags",
})

rest_post_only_properties %i{
  listener_identifier name service_identifier
}
