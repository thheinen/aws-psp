# Import API specifics
use "awscc_base"

resource_name :aws_emr_studio_session_mapping
provides :aws_emr_studio_session_mapping, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  An example resource schema demonstrating some basic constructs and validation rules.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :identity_name, String,
         required: true,
         callbacks: {
           "identity_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The name of the user or group. For more information, see UserName and DisplayName in the AWS SSO Identity Store API Reference. Either IdentityName or IdentityId must be specified."

property :identity_type, String,
         required: true,
         callbacks: {
           "identity_type is not a String" => lambda { |v| v.is_a? String },
           "identity_typeis not one of `USER`, `GROUP`" => lambda { |v| %w{USER GROUP}.include? v },
         },
         description: "Specifies whether the identity to map to the Studio is a user or a group."

property :session_policy_arn, Hash,
         required: true,
         callbacks: {
           "session_policy_arn is not a String" => lambda { |v| v.is_a? String },
           "session_policy_arn must match pattern ^arn:aws(-(cn|us-gov))?:iam::([0-9]{12})?:policy\/[^.]+$" => lambda { |v| v =~ Regexp.new("/^arn:aws(-(cn|us-gov))?:iam::([0-9]{12})?:policy\/[^.]+$/") },
         },
         description: "The Amazon Resource Name (ARN) for the session policy that will be applied to the user or group. Session policies refine Studio user permissions without the need to use multiple IAM user roles."

property :studio_id, String,
         required: true,
         callbacks: {
           "studio_id is not a String" => lambda { |v| v.is_a? String },
           "studio_id needs to be 4..256 characters" => lambda { |v| v.length >= 4 && v.length <= 256 },
           "studio_id must match pattern ^es-[0-9A-Z]+" => lambda { |v| v =~ Regexp.new("/^es-[0-9A-Z]+/") },
         },
         description: "The ID of the Amazon EMR Studio to which the user or group will be mapped."

# API URLs and mappings
rest_api_collection "/AWS::EMR::StudioSessionMapping"
rest_api_document "/AWS::EMR::StudioSessionMapping"

rest_property_map({
  identity_name:      "IdentityName",
  identity_type:      "IdentityType",
  session_policy_arn: "SessionPolicyArn",
  studio_id:          "StudioId",
})

rest_post_only_properties %i{
  identity_name identity_type studio_id
}
