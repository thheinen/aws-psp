# Import API specifics
use "awscc_base"

resource_name :aws_aps_rule_groups_namespace
provides :aws_aps_rule_groups_namespace, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  RuleGroupsNamespace schema for cloudformation.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :data, String,
         required: true,
         callbacks: {
           "data is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The RuleGroupsNamespace data.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
         },
         description: <<~'DESCRIPTION'
           The RuleGroupsNamespace name.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

property :workspace, String,
         required: true,
         callbacks: {
           "workspace is not a String" => lambda { |v| v.is_a? String },
           "workspace must match pattern ^arn:(aws|aws-us-gov|aws-cn):aps:[a-z0-9-]+:[0-9]+:workspace/[a-zA-Z0-9-]+$" => lambda { |v| v =~ Regexp.new("/^arn:(aws|aws-us-gov|aws-cn):aps:[a-z0-9-]+:[0-9]+:workspace/[a-zA-Z0-9-]+$/") },
         },
         description: <<~'DESCRIPTION'
           Required to identify a specific APS Workspace associated with this RuleGroupsNamespace.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::APS::RuleGroupsNamespace"
rest_api_document "/AWS::APS::RuleGroupsNamespace"

rest_property_map({
  data:      "Data",
  name:      "Name",
  tags:      "Tags",
  workspace: "Workspace",
})

rest_post_only_properties %i{
  name
}
