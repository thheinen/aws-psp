# Import API specifics
use "awscc_base"

resource_name :aws_eks_nodegroup
provides :aws_eks_nodegroup, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::EKS::Nodegroup
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :ami_type, String,
         callbacks: {
           "ami_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The AMI type for your node group."

property :capacity_type, String,
         callbacks: {
           "capacity_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The capacity type of your managed node group."

property :cluster_name, String,
         required: true,
         callbacks: {
           "cluster_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: "Name of the cluster to create the node group in."

property :disk_size, Integer,
         callbacks: {
           "disk_size is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: "The root device disk size (in GiB) for your node group instances."

property :force_update_enabled, [TrueClass, FalseClass],
         callbacks: {
           "force_update_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: "Force the update if the existing node group's pods are unable to be drained due to a pod disruption budget issue."

property :instance_types, Array,
         callbacks: {
           "instance_types is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "Specify the instance types for a node group."

property :labels, Hash,
         callbacks: {
           "labels is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: "The Kubernetes labels to be applied to the nodes in the node group when they are created."

property :launch_template, Hash,
         callbacks: {
           "Subproperty `Id` is not a String" => lambda { |v| v[:Id].is_a? String },
           "Subproperty `Version` is not a String" => lambda { |v| v[:Version].is_a? String },
           "Subproperty `Name` is not a String" => lambda { |v| v[:Name].is_a? String },
         },
         description: "An object representing a node group's launch template specification."

property :node_role, String,
         required: true,
         callbacks: {
           "node_role is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The Amazon Resource Name (ARN) of the IAM role to associate with your node group."

property :nodegroup_name, String,
         callbacks: {
           "nodegroup_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The unique name to give your node group."

property :release_version, String,
         callbacks: {
           "release_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The AMI version of the Amazon EKS-optimized AMI to use with your node group."

property :remote_access, Hash,
         callbacks: {
           "Subproperty `SourceSecurityGroups` is not a Array" => lambda { |v| v[:SourceSecurityGroups].is_a? Array },
           "Subproperty `Ec2SshKey` is not a String" => lambda { |v| v[:Ec2SshKey].is_a? String },
         },
         description: "The remote access (SSH) configuration to use with your node group."

property :scaling_config, Hash,
         callbacks: {
           "Subproperty `MinSize` is not a Integer" => lambda { |v| v[:MinSize].is_a? Integer },
           "Subproperty `DesiredSize` is not a Integer" => lambda { |v| v[:DesiredSize].is_a? Integer },
           "Subproperty `MaxSize` is not a Integer" => lambda { |v| v[:MaxSize].is_a? Integer },
         },
         description: "The scaling configuration details for the Auto Scaling group that is created for your node group."

property :subnets, Array,
         required: true,
         callbacks: {
           "subnets is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The subnets to use for the Auto Scaling group that is created for your node group."

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: "The metadata, as key-value pairs, to apply to the node group to assist with categorization and organization. Follows same schema as Labels for consistency."

property :taints, Array,
         callbacks: {
           "taints is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The Kubernetes taints to be applied to the nodes in the node group when they are created."

property :update_config, Hash,
         callbacks: {
           "Subproperty `MaxUnavailable` is not a Number" => lambda { |v| v[:MaxUnavailable].is_a? Number },
           "Subproperty `MaxUnavailablePercentage` is not a Number" => lambda { |v| v[:MaxUnavailablePercentage].is_a? Number },
         },
         description: "The node group update configuration."

property :version, String,
         callbacks: {
           "version is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The Kubernetes version to use for your managed nodes."

# API URLs and mappings
rest_api_collection "/AWS::EKS::Nodegroup"
rest_api_document "/AWS::EKS::Nodegroup"

rest_property_map({
  ami_type:             "AmiType",
  capacity_type:        "CapacityType",
  cluster_name:         "ClusterName",
  disk_size:            "DiskSize",
  force_update_enabled: "ForceUpdateEnabled",
  instance_types:       "InstanceTypes",
  labels:               "Labels",
  launch_template:      "LaunchTemplate",
  node_role:            "NodeRole",
  nodegroup_name:       "NodegroupName",
  release_version:      "ReleaseVersion",
  remote_access:        "RemoteAccess",
  scaling_config:       "ScalingConfig",
  subnets:              "Subnets",
  tags:                 "Tags",
  taints:               "Taints",
  update_config:        "UpdateConfig",
  version:              "Version",
})

rest_post_only_properties %i{
  ami_type capacity_type cluster_name disk_size instance_types node_role nodegroup_name remote_access subnets
}
