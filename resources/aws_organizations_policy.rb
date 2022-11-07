# Import API specifics
use "awscc_base"

resource_name :aws_organizations_policy
provides :aws_organizations_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Policies in AWS Organizations enable you to manage different features of the AWS accounts in your organization.  You can use policies when all features are enabled in your organization.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :content, String,
         required: true,
         callbacks: {
           "content is not a String" => lambda { |v| v.is_a? String },
           "content needs to be 1..1000000 characters" => lambda { |v| v.length >= 1 && v.length <= 1000000 },
           "content must match pattern [\s\S]*" => lambda { |v| v =~ Regexp.new("/[\s\S]*/") },
         },
         description: <<~'DESCRIPTION'
           The Policy text content
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description must match pattern [\s\S]*" => lambda { |v| v =~ Regexp.new("/[\s\S]*/") },
         },
         description: <<~'DESCRIPTION'
           Human readable description of the policy
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "name must match pattern [\s\S]*" => lambda { |v| v =~ Regexp.new("/[\s\S]*/") },
         },
         description: <<~'DESCRIPTION'
           Name of the Policy
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of tags that you want to attach to the newly created policy. For each tag in the list, you must specify both a tag key and a value. You can set the value to an empty string, but you can't set it to null.
         DESCRIPTION

property :target_ids, Array,
         callbacks: {
           "target_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           List of unique identifiers (IDs) of the root, OU, or account that you want to attach the policy to
         DESCRIPTION

property :type, String,
         required: true,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
           "typeis not one of `SERVICE_CONTROL_POLICY`, `AISERVICES_OPT_OUT_POLICY`, `BACKUP_POLICY`, `TAG_POLICY`" => lambda { |v| %w{SERVICE_CONTROL_POLICY AISERVICES_OPT_OUT_POLICY BACKUP_POLICY TAG_POLICY}.include? v },
         },
         description: <<~'DESCRIPTION'
           The type of policy to create. You can specify one of the following values: AISERVICES_OPT_OUT_POLICY, BACKUP_POLICY, SERVICE_CONTROL_POLICY, TAG_POLICY
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Organizations::Policy"
rest_api_document "/AWS::Organizations::Policy"

rest_property_map({
  content:     "Content",
  description: "Description",
  name:        "Name",
  tags:        "Tags",
  target_ids:  "TargetIds",
  type:        "Type",
})

rest_post_only_properties %i{
  type
}
