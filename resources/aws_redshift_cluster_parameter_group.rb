# Import API specifics
use "awscc_base"

resource_name :aws_redshift_cluster_parameter_group
provides :aws_redshift_cluster_parameter_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Redshift::ClusterParameterGroup
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
           A description of the parameter group.
         DESCRIPTION

property :parameter_group_family, String,
         required: true,
         callbacks: {
           "parameter_group_family is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Redshift engine version to which the cluster parameter group applies. The cluster engine version determines the set of parameters.
         DESCRIPTION

property :parameters, Array,
         callbacks: {
           "parameters is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of parameters to be modified. A maximum of 20 parameters can be modified in a single request.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Redshift::ClusterParameterGroup"
rest_api_document "/AWS::Redshift::ClusterParameterGroup"

rest_property_map({
  description:            "Description",
  parameter_group_family: "ParameterGroupFamily",
  parameters:             "Parameters",
  tags:                   "Tags",
})

rest_post_only_properties %i{
  description parameter_group_family
}
