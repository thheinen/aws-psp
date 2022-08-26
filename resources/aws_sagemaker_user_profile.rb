# Import API specifics
use "awscc_base"

resource_name :aws_sagemaker_user_profile
provides :aws_sagemaker_user_profile, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SageMaker::UserProfile
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :domain_id, String,
         required: true,
         callbacks: {
           "domain_id is not a String" => lambda { |v| v.is_a? String },
           "domain_id needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
         },
         description: <<~'DESCRIPTION'
           The ID of the associated Domain.
         DESCRIPTION

property :single_sign_on_user_identifier, String,
         callbacks: {
           "single_sign_on_user_identifier is not a String" => lambda { |v| v.is_a? String },
           "single_sign_on_user_identifier must match pattern UserName" => lambda { |v| v =~ Regexp.new("/UserName/") },
         },
         description: <<~'DESCRIPTION'
           A specifier for the type of value specified in SingleSignOnUserValue. Currently, the only supported value is "UserName". If the Domain's AuthMode is SSO, this field is required. If the Domain's AuthMode is not SSO, this field cannot be specified.
         DESCRIPTION

property :single_sign_on_user_value, String,
         callbacks: {
           "single_sign_on_user_value is not a String" => lambda { |v| v.is_a? String },
           "single_sign_on_user_value needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
         },
         description: <<~'DESCRIPTION'
           The username of the associated AWS Single Sign-On User for this UserProfile. If the Domain's AuthMode is SSO, this field is required, and must match a valid username of a user in your directory. If the Domain's AuthMode is not SSO, this field cannot be specified.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of tags to apply to the user profile.
         DESCRIPTION

property :user_profile_name, String,
         required: true,
         callbacks: {
           "user_profile_name is not a String" => lambda { |v| v.is_a? String },
           "user_profile_name needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
         },
         description: <<~'DESCRIPTION'
           A name for the UserProfile.
         DESCRIPTION

property :user_settings, Hash,
         callbacks: {
           "Subproperty `ExecutionRole` is not a String" => lambda { |v| v[:ExecutionRole].is_a? String },
           "Subproperty `ExecutionRole` needs to be 20..2048 characters" => lambda { |v| v[:ExecutionRole].length >= 20 && v[:ExecutionRole].length <= 2048 },
           "Subproperty `ExecutionRole` must match pattern ^arn:aws[a-z\-]*:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+$" => lambda { |v| v[:ExecutionRole] =~ Regexp.new("/^arn:aws[a-z\-]*:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+$/") },
           "Subproperty `SecurityGroups` is not a Array" => lambda { |v| v[:SecurityGroups].is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A collection of settings.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SageMaker::UserProfile"
rest_api_document "/AWS::SageMaker::UserProfile"

rest_property_map({
  domain_id:                      "DomainId",
  single_sign_on_user_identifier: "SingleSignOnUserIdentifier",
  single_sign_on_user_value:      "SingleSignOnUserValue",
  tags:                           "Tags",
  user_profile_name:              "UserProfileName",
  user_settings:                  "UserSettings",
})

rest_post_only_properties %i{
  domain_id single_sign_on_user_identifier single_sign_on_user_value tags user_profile_name user_settings/r_studio_server_pro_app_settings/access_status user_settings/r_studio_server_pro_app_settings/user_group
}
