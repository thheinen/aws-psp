# Import API specifics
use "awscc_base"

resource_name :aws_vpc_lattice_auth_policy
provides :aws_vpc_lattice_auth_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Creates or updates the auth policy.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :policy, Hash,
         required: true,
         callbacks: {
           "policy is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :resource_identifier, String,
         required: true,
         callbacks: {
           "resource_identifier is not a String" => lambda { |v| v.is_a? String },
           "resource_identifier needs to be 21..200 characters" => lambda { |v| v.length >= 21 && v.length <= 200 },
           "resource_identifier must match pattern ^((((sn)|(svc))-[0-9a-z]{17})|(arn(:[a-z0-9]+([.-][a-z0-9]+)*){2}(:([a-z0-9]+([.-][a-z0-9]+)*)?){2}:((servicenetwork/sn)|(service/svc))-[0-9a-z]{17}))$" => lambda { |v| v =~ Regexp.new("/^((((sn)|(svc))-[0-9a-z]{17})|(arn(:[a-z0-9]+([.-][a-z0-9]+)*){2}(:([a-z0-9]+([.-][a-z0-9]+)*)?){2}:((servicenetwork/sn)|(service/svc))-[0-9a-z]{17}))$/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::VpcLattice::AuthPolicy"
rest_api_document "/AWS::VpcLattice::AuthPolicy"

rest_property_map({
  policy:              "Policy",
  resource_identifier: "ResourceIdentifier",
})

rest_post_only_properties %i{
  resource_identifier
}
