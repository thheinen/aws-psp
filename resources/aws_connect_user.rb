# Import API specifics
use "awscc_base"

resource_name :aws_connect_user
provides :aws_connect_user, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Connect::User
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :directory_user_id, String,
         callbacks: {
           "directory_user_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The identifier of the user account in the directory used for identity management.
         DESCRIPTION

property :hierarchy_group_arn, String,
         callbacks: {
           "hierarchy_group_arn is not a String" => lambda { |v| v.is_a? String },
           "hierarchy_group_arn must match pattern ^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*/agent-group/[-a-zA-Z0-9]*$" => lambda { |v| v =~ Regexp.new("/^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*/agent-group/[-a-zA-Z0-9]*$/") },
         },
         description: <<~'DESCRIPTION'
           The identifier of the hierarchy group for the user.
         DESCRIPTION

property :identity_info, Hash,
         description: <<~'DESCRIPTION'
           The information about the identity of the user.
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

property :password, String,
         callbacks: {
           "password is not a String" => lambda { |v| v.is_a? String },
           "password must match pattern ^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d\S]{8,64}$" => lambda { |v| v =~ Regexp.new("/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d\S]{8,64}$/") },
         },
         description: <<~'DESCRIPTION'
           The password for the user account. A password is required if you are using Amazon Connect for identity management. Otherwise, it is an error to include a password.
         DESCRIPTION

property :phone_config, Hash,
         required: true,
         description: <<~'DESCRIPTION'
           The phone settings for the user.
         DESCRIPTION

property :routing_profile_arn, String,
         required: true,
         callbacks: {
           "routing_profile_arn is not a String" => lambda { |v| v.is_a? String },
           "routing_profile_arn must match pattern ^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*/routing-profile/[-a-zA-Z0-9]*$" => lambda { |v| v =~ Regexp.new("/^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*/routing-profile/[-a-zA-Z0-9]*$/") },
         },
         description: <<~'DESCRIPTION'
           The identifier of the routing profile for the user.
         DESCRIPTION

property :security_profile_arns, Array,
         required: true,
         callbacks: {
           "security_profile_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           One or more security profile arns for the user
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           One or more tags.
         DESCRIPTION

property :username, String,
         required: true,
         callbacks: {
           "username is not a String" => lambda { |v| v.is_a? String },
           "username needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "username must match pattern [a-zA-Z0-9\_\-\.\@]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9\_\-\.\@]+/") },
         },
         description: <<~'DESCRIPTION'
           The user name for the account.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Connect::User"
rest_api_document "/AWS::Connect::User"

rest_property_map({
  directory_user_id:     "DirectoryUserId",
  hierarchy_group_arn:   "HierarchyGroupArn",
  identity_info:         "IdentityInfo",
  instance_arn:          "InstanceArn",
  password:              "Password",
  phone_config:          "PhoneConfig",
  routing_profile_arn:   "RoutingProfileArn",
  security_profile_arns: "SecurityProfileArns",
  tags:                  "Tags",
  username:              "Username",
})

