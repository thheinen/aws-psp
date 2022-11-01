# Import API specifics
use "awscc_base"

resource_name :aws_rds_option_group
provides :aws_rds_option_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::RDS::OptionGroup resource creates an option group, to enable and configure features that are specific to a particular DB engine.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :engine_name, String,
         required: true,
         callbacks: {
           "engine_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Indicates the name of the engine that this option group can be applied to.
         DESCRIPTION

property :major_engine_version, String,
         required: true,
         callbacks: {
           "major_engine_version is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Indicates the major engine version associated with this option group.
         DESCRIPTION

property :option_configurations, Array,
         callbacks: {
           "option_configurations is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Indicates what options are available in the option group.
         DESCRIPTION

property :option_group_description, String,
         required: true,
         callbacks: {
           "option_group_description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Provides a description of the option group.
         DESCRIPTION

property :option_group_name, String,
         callbacks: {
           "option_group_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Specifies the name of the option group.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::RDS::OptionGroup"
rest_api_document "/AWS::RDS::OptionGroup"

rest_property_map({
  engine_name:              "EngineName",
  major_engine_version:     "MajorEngineVersion",
  option_configurations:    "OptionConfigurations",
  option_group_description: "OptionGroupDescription",
  option_group_name:        "OptionGroupName",
  tags:                     "Tags",
})

rest_post_only_properties %i{
  engine_name major_engine_version option_group_description option_group_name
}
