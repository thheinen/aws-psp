# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_eks_cluster
provides :aws_eks_cluster, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  An object representing an Amazon EKS cluster.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :encryption_config, Array,
         callbacks: {
           "encryption_config is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :kubernetes_network_config, Hash,
         callbacks: {
           "Subproperty `ServiceIpv4Cidr` is not a String" => lambda { |v| v[:ServiceIpv4Cidr].is_a? String },
           "Subproperty `ServiceIpv6Cidr` is not a String" => lambda { |v| v[:ServiceIpv6Cidr].is_a? String },
           "Subproperty `IpFamily` is not a String" => lambda { |v| v[:IpFamily].is_a? String },
           "Subproperty `IpFamily`is not one of `ipv4`, `ipv6`" => lambda { |v| %w{ipv4 ipv6}.include? v[:IpFamily] },
         },
         description: ""

property :logging, Hash,
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "name must match pattern ^[0-9A-Za-z][A-Za-z0-9\-_]*" => lambda { |v| v =~ Regexp.new("/^[0-9A-Za-z][A-Za-z0-9\-_]*/") },
         },
         description: <<~'DESCRIPTION'
           The unique name to give to your cluster.
         DESCRIPTION

property :resources_vpc_config, Hash,
         required: true,
         callbacks: {
           "Subproperty `EndpointPublicAccess` is not a Boolean" => lambda { |v| v[:EndpointPublicAccess].is_a? Boolean },
           "Subproperty `PublicAccessCidrs` is not a Array" => lambda { |v| v[:PublicAccessCidrs].is_a? Array },
           "Subproperty `EndpointPrivateAccess` is not a Boolean" => lambda { |v| v[:EndpointPrivateAccess].is_a? Boolean },
           "Subproperty `SecurityGroupIds` is not a Array" => lambda { |v| v[:SecurityGroupIds].is_a? Array },
           "Subproperty `SubnetIds` is not a Array" => lambda { |v| v[:SubnetIds].is_a? Array },
         },
         description: ""

property :role_arn, String,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the IAM role that provides permissions for the Kubernetes control plane to make calls to AWS API operations on your behalf.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

property :version, String,
         callbacks: {
           "version is not a String" => lambda { |v| v.is_a? String },
           "version must match pattern 1\.\d\d" => lambda { |v| v =~ Regexp.new("/1\.\d\d/") },
         },
         description: <<~'DESCRIPTION'
           The desired Kubernetes version for your cluster. If you don't specify a value here, the latest version available in Amazon EKS is used.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EKS::Cluster"
rest_api_document "/AWS::EKS::Cluster"

rest_property_map({
  encryption_config:         "EncryptionConfig",
  kubernetes_network_config: "KubernetesNetworkConfig",
  logging:                   "Logging",
  name:                      "Name",
  resources_vpc_config:      "ResourcesVpcConfig",
  role_arn:                  "RoleArn",
  tags:                      "Tags",
  version:                   "Version",
})

rest_post_only_properties %i{
  encryption_config kubernetes_network_config name resources_vpc_config/security_group_ids resources_vpc_config/subnet_ids role_arn
}
