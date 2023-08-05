# Import API specifics
use "awscc_base"

resource_name :aws_vpc_lattice_resource_policy
provides :aws_vpc_lattice_resource_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Retrieves information about the resource policy. The resource policy is an IAM policy created by AWS RAM on behalf of the resource owner when they share a resource.
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

property :resource_arn, String,
         required: true,
         callbacks: {
           "resource_arn is not a String" => lambda { |v| v.is_a? String },
           "resource_arn needs to be 20..200 characters" => lambda { |v| v.length >= 20 && v.length <= 200 },
           "resource_arn must match pattern ^arn(:[a-z0-9]+([.-][a-z0-9]+)*){2}(:([a-z0-9]+([.-][a-z0-9]+)*)?){2}:((servicenetwork/sn)|(service/svc))-[0-9a-z]{17}$" => lambda { |v| v =~ Regexp.new("/^arn(:[a-z0-9]+([.-][a-z0-9]+)*){2}(:([a-z0-9]+([.-][a-z0-9]+)*)?){2}:((servicenetwork/sn)|(service/svc))-[0-9a-z]{17}$/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::VpcLattice::ResourcePolicy"
rest_api_document "/AWS::VpcLattice::ResourcePolicy"

rest_property_map({
  policy:       "Policy",
  resource_arn: "ResourceArn",
})

rest_post_only_properties %i{
  resource_arn
}
