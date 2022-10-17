# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_redshift_cluster_subnet_group
provides :aws_redshift_cluster_subnet_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Specifies an Amazon Redshift subnet group.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         required: true,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The description of the parameter group.
         DESCRIPTION

property :subnet_ids, Array,
         required: true,
         callbacks: {
           "subnet_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The list of VPC subnet IDs
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The list of tags for the cluster parameter group.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Redshift::ClusterSubnetGroup"
rest_api_document "/AWS::Redshift::ClusterSubnetGroup"

rest_property_map({
  description: "Description",
  subnet_ids:  "SubnetIds",
  tags:        "Tags",
})

