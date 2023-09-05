# Import API specifics
use "awscc_base"

resource_name :aws_ssm_parameter
provides :aws_ssm_parameter, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SSM::Parameter
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :allowed_pattern, String,
         callbacks: {
           "allowed_pattern is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The regular expression used to validate the parameter value.
         DESCRIPTION

property :data_type, String,
         callbacks: {
           "data_type is not a String" => lambda { |v| v.is_a? String },
           "data_typeis not one of `text`, `aws:ec2:image`" => lambda { |v| %w{text aws:ec2:image}.include? v },
         },
         description: <<~'DESCRIPTION'
           The corresponding DataType of the parameter.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The information about the parameter.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the parameter.
         DESCRIPTION

property :policies, String,
         callbacks: {
           "policies is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The policies attached to the parameter.
         DESCRIPTION

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           A key-value pair to associate with a resource.
         DESCRIPTION

property :tier, String,
         callbacks: {
           "tier is not a String" => lambda { |v| v.is_a? String },
           "tieris not one of `Standard`, `Advanced`, `Intelligent-Tiering`" => lambda { |v| %w{Standard Advanced Intelligent-Tiering}.include? v },
         },
         description: <<~'DESCRIPTION'
           The corresponding tier of the parameter.
         DESCRIPTION

property :type, String,
         required: true,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
           "typeis not one of `String`, `StringList`, `SecureString`" => lambda { |v| %w{String StringList SecureString}.include? v },
         },
         description: <<~'DESCRIPTION'
           The type of the parameter.
         DESCRIPTION

property :value, String,
         required: true,
         callbacks: {
           "value is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The value associated with the parameter.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SSM::Parameter"
rest_api_document "/AWS::SSM::Parameter"

rest_property_map({
  allowed_pattern: "AllowedPattern",
  data_type:       "DataType",
  description:     "Description",
  name:            "Name",
  policies:        "Policies",
  tags:            "Tags",
  tier:            "Tier",
  type:            "Type",
  value:           "Value",
})

rest_post_only_properties %i{
  name
}
