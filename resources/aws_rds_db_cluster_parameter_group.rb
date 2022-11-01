# Import API specifics
use "awscc_base"

resource_name :aws_rds_db_cluster_parameter_group
provides :aws_rds_db_cluster_parameter_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::RDS::DBClusterParameterGroup resource creates a new Amazon RDS DB cluster parameter group. For more information, see Managing an Amazon Aurora DB Cluster in the Amazon Aurora User Guide.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :db_cluster_parameter_group_name, String,
         callbacks: {
           "db_cluster_parameter_group_name is not a String" => lambda { |v| v.is_a? String },
           "db_cluster_parameter_group_name must match pattern ^[a-zA-Z]{1}(?:-?[a-zA-Z0-9])*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z]{1}(?:-?[a-zA-Z0-9])*$/") },
         },
         description: ""

property :description, String,
         required: true,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A friendly description for this DB cluster parameter group.
         DESCRIPTION

property :family, String,
         required: true,
         callbacks: {
           "family is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The DB cluster parameter group family name. A DB cluster parameter group can be associated with one and only one DB cluster parameter group family, and can be applied only to a DB cluster running a DB engine and engine version compatible with that DB cluster parameter group family.
         DESCRIPTION

property :parameters, Hash,
         required: true,
         callbacks: {
           "parameters is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           An array of parameters to be modified. A maximum of 20 parameters can be modified in a single request.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The list of tags for the cluster parameter group.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::RDS::DBClusterParameterGroup"
rest_api_document "/AWS::RDS::DBClusterParameterGroup"

rest_property_map({
  db_cluster_parameter_group_name: "DBClusterParameterGroupName",
  description:                     "Description",
  family:                          "Family",
  parameters:                      "Parameters",
  tags:                            "Tags",
})

rest_post_only_properties %i{
  db_cluster_parameter_group_name description family
}
