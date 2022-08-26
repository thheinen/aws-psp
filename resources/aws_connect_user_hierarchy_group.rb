# Import API specifics
use "awscc_base"

resource_name :aws_connect_user_hierarchy_group
provides :aws_connect_user_hierarchy_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Connect::UserHierarchyGroup
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :instance_arn, String,
         required: true,
         callbacks: {
           "instance_arn is not a String" => lambda { |v| v.is_a? String },
           "instance_arn must match pattern ^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$" => lambda { |v| v =~ Regexp.new("/^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$/") },
         },
         description: "The identifier of the Amazon Connect instance."

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
         },
         description: "The name of the user hierarchy group."

property :parent_group_arn, Hash,
         callbacks: {
           "parent_group_arn is not a String" => lambda { |v| v.is_a? String },
           "parent_group_arn must match pattern ^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*/agent-group/[-a-zA-Z0-9]*$" => lambda { |v| v =~ Regexp.new("/^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*/agent-group/[-a-zA-Z0-9]*$/") },
         },
         description: "The Amazon Resource Name (ARN) for the parent user hierarchy group."

# API URLs and mappings
rest_api_collection "/AWS::Connect::UserHierarchyGroup"
rest_api_document "/AWS::Connect::UserHierarchyGroup"

rest_property_map({
  instance_arn:     "InstanceArn",
  name:             "Name",
  parent_group_arn: "ParentGroupArn",
})

rest_post_only_properties %i{
  parent_group_arn
}
