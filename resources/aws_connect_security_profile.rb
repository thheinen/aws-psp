# Import API specifics
use "awscc_base"

resource_name :aws_connect_security_profile
provides :aws_connect_security_profile, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Connect::SecurityProfile
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :allowed_access_control_tags, Array,
         callbacks: {
           "allowed_access_control_tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The list of tags that a security profile uses to restrict access to resources in Amazon Connect.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..250 characters" => lambda { |v| v.length >= 0 && v.length <= 250 },
         },
         description: <<~'DESCRIPTION'
           The description of the security profile.
         DESCRIPTION

property :instance_arn, String,
         required: true,
         callbacks: {
           "instance_arn is not a String" => lambda { |v| v.is_a? String },
           "instance_arn must match pattern ^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$" => lambda { |v| v =~ Regexp.new("/^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$/") },
         },
         description: <<~'DESCRIPTION'
           The identifier of the Amazon Connect instance.
         DESCRIPTION

property :permissions, Array,
         callbacks: {
           "permissions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Permissions assigned to the security profile.
         DESCRIPTION

property :security_profile_name, String,
         required: true,
         callbacks: {
           "security_profile_name is not a String" => lambda { |v| v.is_a? String },
           "security_profile_name needs to be 1..127 characters" => lambda { |v| v.length >= 1 && v.length <= 127 },
           "security_profile_name must match pattern ^[ a-zA-Z0-9_@-]+$" => lambda { |v| v =~ Regexp.new("/^[ a-zA-Z0-9_@-]+$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the security profile.
         DESCRIPTION

property :tag_restricted_resources, Array,
         callbacks: {
           "tag_restricted_resources is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The list of resources that a security profile applies tag restrictions to in Amazon Connect.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags used to organize, track, or control access for this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Connect::SecurityProfile"
rest_api_document "/AWS::Connect::SecurityProfile"

rest_property_map({
  allowed_access_control_tags: "AllowedAccessControlTags",
  description:                 "Description",
  instance_arn:                "InstanceArn",
  permissions:                 "Permissions",
  security_profile_name:       "SecurityProfileName",
  tag_restricted_resources:    "TagRestrictedResources",
  tags:                        "Tags",
})

rest_post_only_properties %i{
  instance_arn security_profile_name
}
