# Import API specifics
use "awscc_base"

resource_name :aws_msk_cluster_policy
provides :aws_msk_cluster_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::MSK::ClusterPolicy
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :cluster_arn, String,
         required: true,
         callbacks: {
           "cluster_arn is not a String" => lambda { |v| v.is_a? String },
           "cluster_arn must match pattern ^arn:[\w-]+:kafka:[\w-]+:\d+:cluster.*\Z" => lambda { |v| v =~ Regexp.new("/^arn:[\w-]+:kafka:[\w-]+:\d+:cluster.*\Z/") },
         },
         description: <<~'DESCRIPTION'
           The arn of the cluster for the resource policy.
         DESCRIPTION

property :policy, Hash,
         required: true,
         callbacks: {
           "policy is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           A policy document containing permissions to add to the specified cluster.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::MSK::ClusterPolicy"
rest_api_document "/AWS::MSK::ClusterPolicy"

rest_property_map({
  cluster_arn: "ClusterArn",
  policy:      "Policy",
})

rest_post_only_properties %i{
  cluster_arn
}
