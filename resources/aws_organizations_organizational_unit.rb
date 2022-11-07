# Import API specifics
use "awscc_base"

resource_name :aws_organizations_organizational_unit
provides :aws_organizations_organizational_unit, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  You can use organizational units (OUs) to group accounts together to administer as a single unit. This greatly simplifies the management of your accounts. For example, you can attach a policy-based control to an OU, and all accounts within the OU automatically inherit the policy. You can create multiple OUs within a single organization, and you can create OUs within other OUs. Each OU can contain multiple accounts, and you can move accounts from one OU to another. However, OU names must be unique within a parent OU or root.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "name must match pattern [\s\S]*" => lambda { |v| v =~ Regexp.new("/[\s\S]*/") },
         },
         description: <<~'DESCRIPTION'
           The friendly name of this OU.
         DESCRIPTION

property :parent_id, String,
         required: true,
         callbacks: {
           "parent_id is not a String" => lambda { |v| v.is_a? String },
           "parent_id must match pattern ^(r-[0-9a-z]{4,32})|(ou-[0-9a-z]{4,32}-[a-z0-9]{8,32})$" => lambda { |v| v =~ Regexp.new("/^(r-[0-9a-z]{4,32})|(ou-[0-9a-z]{4,32}-[a-z0-9]{8,32})$/") },
         },
         description: <<~'DESCRIPTION'
           The unique identifier (ID) of the parent root or OU that you want to create the new OU in.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of tags that you want to attach to the newly created OU.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Organizations::OrganizationalUnit"
rest_api_document "/AWS::Organizations::OrganizationalUnit"

rest_property_map({
  name:      "Name",
  parent_id: "ParentId",
  tags:      "Tags",
})

rest_post_only_properties %i{
  parent_id
}
