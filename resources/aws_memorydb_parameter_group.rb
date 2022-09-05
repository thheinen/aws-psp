# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_memorydb_parameter_group
provides :aws_memorydb_parameter_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::MemoryDB::ParameterGroup resource creates an Amazon MemoryDB ParameterGroup.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A description of the parameter group.
         DESCRIPTION

property :family, String,
         required: true,
         callbacks: {
           "family is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the parameter group family that this parameter group is compatible with.
         DESCRIPTION

property :parameter_group_name, String,
         required: true,
         callbacks: {
           "parameter_group_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the parameter group.
         DESCRIPTION

property :parameters, Hash,
         callbacks: {
           "parameters is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           An map of parameter names and values for the parameter update. You must supply at least one parameter name and value; subsequent arguments are optional.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this parameter group.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::MemoryDB::ParameterGroup"
rest_api_document "/AWS::MemoryDB::ParameterGroup"

rest_property_map({
  description:          "Description",
  family:               "Family",
  parameter_group_name: "ParameterGroupName",
  parameters:           "Parameters",
  tags:                 "Tags",
})

rest_post_only_properties %i{
  description family parameter_group_name
}
