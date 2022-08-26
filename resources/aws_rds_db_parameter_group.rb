# Import API specifics
use "awscc_base"

resource_name :aws_rds_db_parameter_group
provides :aws_rds_db_parameter_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::RDS::DBParameterGroup resource creates a custom parameter group for an RDS database family
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         required: true,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: "Provides the customer-specified description for this DB parameter group."

property :family, String,
         required: true,
         callbacks: {
           "family is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The DB parameter group family name."

property :parameters, Hash,
         callbacks: {
           "parameters is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: "An array of parameter names and values for the parameter update."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "An array of key-value pairs to apply to this resource."

# API URLs and mappings
rest_api_collection "/AWS::RDS::DBParameterGroup"
rest_api_document "/AWS::RDS::DBParameterGroup"

rest_property_map({
  description: "Description",
  family:      "Family",
  parameters:  "Parameters",
  tags:        "Tags",
})

rest_post_only_properties %i{
  description family
}
