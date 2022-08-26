# Import API specifics
use "awscc_base"

resource_name :aws_redshift_endpoint_access
provides :aws_redshift_endpoint_access, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for a Redshift-managed VPC endpoint.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :cluster_identifier, String,
         required: true,
         callbacks: {
           "cluster_identifier is not a String" => lambda { |v| v.is_a? String },
         },
         description: "A unique identifier for the cluster. You use this identifier to refer to the cluster for any subsequent cluster operations such as deleting or modifying. All alphabetical characters must be lower case, no hypens at the end, no two consecutive hyphens. Cluster name should be unique for all clusters within an AWS account"

property :endpoint_name, String,
         required: true,
         callbacks: {
           "endpoint_name is not a String" => lambda { |v| v.is_a? String },
           "endpoint_name must match pattern ^(?=^[a-z][a-z0-9]*(-[a-z0-9]+)*$).{1,30}$" => lambda { |v| v =~ Regexp.new("/^(?=^[a-z][a-z0-9]*(-[a-z0-9]+)*$).{1,30}$/") },
         },
         description: "The name of the endpoint."

property :resource_owner, String,
         callbacks: {
           "resource_owner is not a String" => lambda { |v| v.is_a? String },
           "resource_owner must match pattern ^\d{12}$" => lambda { |v| v =~ Regexp.new("/^\d{12}$/") },
         },
         description: "The AWS account ID of the owner of the cluster."

property :subnet_group_name, String,
         required: true,
         callbacks: {
           "subnet_group_name is not a String" => lambda { |v| v.is_a? String },
           "subnet_group_name must match pattern ^(?=^[a-zA-Z0-9-]+$).{1,255}$" => lambda { |v| v =~ Regexp.new("/^(?=^[a-zA-Z0-9-]+$).{1,255}$/") },
         },
         description: "The subnet group name where Amazon Redshift chooses to deploy the endpoint."

property :vpc_security_group_ids, Array,
         required: true,
         callbacks: {
           "vpc_security_group_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "A list of vpc security group ids to apply to the created endpoint access."

# API URLs and mappings
rest_api_collection "/AWS::Redshift::EndpointAccess"
rest_api_document "/AWS::Redshift::EndpointAccess"

rest_property_map({
  cluster_identifier:     "ClusterIdentifier",
  endpoint_name:          "EndpointName",
  resource_owner:         "ResourceOwner",
  subnet_group_name:      "SubnetGroupName",
  vpc_security_group_ids: "VpcSecurityGroupIds",
})

rest_post_only_properties %i{
  cluster_identifier endpoint_name resource_owner subnet_group_name
}
