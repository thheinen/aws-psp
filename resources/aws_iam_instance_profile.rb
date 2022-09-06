# Import API specifics
use "awscc_base"

resource_name :aws_iam_instance_profile
provides :aws_iam_instance_profile, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::IAM::InstanceProfile
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :instance_profile_name, String,
         callbacks: {
           "instance_profile_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the instance profile to create.
         DESCRIPTION

property :path, String,
         callbacks: {
           "path is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The path to the instance profile.
         DESCRIPTION

property :roles, Array,
         required: true,
         callbacks: {
           "roles is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The name of the role to associate with the instance profile. Only one role can be assigned to an EC2 instance at a time, and all applications on the instance share the same role and permissions.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IAM::InstanceProfile"
rest_api_document "/AWS::IAM::InstanceProfile"

rest_property_map({
  instance_profile_name: "InstanceProfileName",
  path:                  "Path",
  roles:                 "Roles",
})

rest_post_only_properties %i{
  instance_profile_name path
}
