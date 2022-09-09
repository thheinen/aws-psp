# Import API specifics
use "awscc_base"

resource_name :aws_eks_fargate_profile
provides :aws_eks_fargate_profile, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Schema for AWS::EKS::FargateProfile
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :cluster_name, String,
         required: true,
         callbacks: {
           "cluster_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Name of the Cluster
         DESCRIPTION

property :fargate_profile_name, String,
         callbacks: {
           "fargate_profile_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Name of FargateProfile
         DESCRIPTION

property :pod_execution_role_arn, String,
         required: true,
         callbacks: {
           "pod_execution_role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The IAM policy arn for pods
         DESCRIPTION

property :selectors, Array,
         required: true,
         callbacks: {
           "selectors is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :subnets, Array,
         callbacks: {
           "subnets is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EKS::FargateProfile"
rest_api_document "/AWS::EKS::FargateProfile"

rest_property_map({
  cluster_name:           "ClusterName",
  fargate_profile_name:   "FargateProfileName",
  pod_execution_role_arn: "PodExecutionRoleArn",
  selectors:              "Selectors",
  subnets:                "Subnets",
  tags:                   "Tags",
})

rest_post_only_properties %i{
  cluster_name fargate_profile_name pod_execution_role_arn selectors subnets
}
