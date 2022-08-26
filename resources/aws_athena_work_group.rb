# Import API specifics
use "awscc_base"

resource_name :aws_athena_work_group
provides :aws_athena_work_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::Athena::WorkGroup
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..1024 characters" => lambda { |v| v.length >= 0 && v.length <= 1024 },
         },
         description: "The workgroup description."

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name must match pattern [a-zA-Z0-9._-]{1,128}" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9._-]{1,128}/") },
         },
         description: "The workGroup name."

property :recursive_delete_option, [TrueClass, FalseClass],
         callbacks: {
           "recursive_delete_option is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: "The option to delete the workgroup and its contents even if the workgroup contains any named queries."

property :state, String,
         callbacks: {
           "state is not a String" => lambda { |v| v.is_a? String },
           "stateis not one of `ENABLED`, `DISABLED`" => lambda { |v| %w{ENABLED DISABLED}.include? v },
         },
         description: "The state of the workgroup: ENABLED or DISABLED."

property :tags, Hash,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "One or more tags, separated by commas, that you want to attach to the workgroup as you create it"

property :work_group_configuration, Hash,
         description: "The workgroup configuration"

property :work_group_configuration_updates, Hash,
         description: "The workgroup configuration update object"

# API URLs and mappings
rest_api_collection "/AWS::Athena::WorkGroup"
rest_api_document "/AWS::Athena::WorkGroup"

rest_property_map({
  description:                      "Description",
  name:                             "Name",
  recursive_delete_option:          "RecursiveDeleteOption",
  state:                            "State",
  tags:                             "Tags",
  work_group_configuration:         "WorkGroupConfiguration",
  work_group_configuration_updates: "WorkGroupConfigurationUpdates",
})

rest_post_only_properties %i{
  name
}
