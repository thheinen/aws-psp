# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_eks_addon
provides :aws_eks_addon, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Schema for AWS::EKS::Addon
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :addon_name, String,
         required: true,
         callbacks: {
           "addon_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Name of Addon
         DESCRIPTION

property :addon_version, String,
         callbacks: {
           "addon_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Version of Addon
         DESCRIPTION

property :cluster_name, String,
         required: true,
         callbacks: {
           "cluster_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Name of Cluster
         DESCRIPTION

property :resolve_conflicts, String,
         callbacks: {
           "resolve_conflicts is not a String" => lambda { |v| v.is_a? String },
           "resolve_conflictsis not one of `NONE`, `OVERWRITE`" => lambda { |v| %w{NONE OVERWRITE}.include? v },
         },
         description: <<~'DESCRIPTION'
           Resolve parameter value conflicts
         DESCRIPTION

property :service_account_role_arn, String,
         callbacks: {
           "service_account_role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           IAM role to bind to the add-on's service account
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EKS::Addon"
rest_api_document "/AWS::EKS::Addon"

rest_property_map({
  addon_name:               "AddonName",
  addon_version:            "AddonVersion",
  cluster_name:             "ClusterName",
  resolve_conflicts:        "ResolveConflicts",
  service_account_role_arn: "ServiceAccountRoleArn",
  tags:                     "Tags",
})

rest_post_only_properties %i{
  addon_name cluster_name
}
