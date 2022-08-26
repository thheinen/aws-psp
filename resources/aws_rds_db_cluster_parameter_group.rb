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

property :description, String,
         required: true,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: "A friendly description for this DB cluster parameter group."

property :family, String,
         required: true,
         callbacks: {
           "family is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The DB cluster parameter group family name. A DB cluster parameter group can be associated with one and only one DB cluster parameter group family, and can be applied only to a DB cluster running a DB engine and engine version compatible with that DB cluster parameter group family."

property :parameters, Hash,
         required: true,
         callbacks: {
           "parameters is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: "An array of parameters to be modified. A maximum of 20 parameters can be modified in a single request."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "The list of tags for the cluster parameter group."

# API URLs and mappings
rest_api_collection "/AWS::RDS::DBClusterParameterGroup"
rest_api_document "/AWS::RDS::DBClusterParameterGroup"

rest_property_map({
  description: "Description",
  family:      "Family",
  parameters:  "Parameters",
  tags:        "Tags",
})

rest_post_only_properties %i{
  description family
}
