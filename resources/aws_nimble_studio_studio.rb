# Import API specifics
use "awscc_base"

resource_name :aws_nimble_studio_studio
provides :aws_nimble_studio_studio, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Represents a studio that contains other Nimble Studio resources
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :admin_role_arn, String,
         required: true,
         callbacks: {
           "admin_role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           <p>The IAM role that Studio Admins will assume when logging in to the Nimble Studio portal.</p>
         DESCRIPTION

property :display_name, String,
         required: true,
         callbacks: {
           "display_name is not a String" => lambda { |v| v.is_a? String },
           "display_name needs to be 0..64 characters" => lambda { |v| v.length >= 0 && v.length <= 64 },
         },
         description: <<~'DESCRIPTION'
           <p>A friendly name for the studio.</p>
         DESCRIPTION

property :studio_encryption_configuration, Hash,
         callbacks: {
           "Subproperty `KeyArn` is not a String" => lambda { |v| v[:KeyArn].is_a? String },
           "Subproperty `KeyArn` must match pattern ^arn:.*" => lambda { |v| v[:KeyArn] =~ Regexp.new("/^arn:.*/") },
           "Subproperty `KeyArn`is not a valid ARN" => lambda { |v| v[:KeyArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: ""

property :studio_name, String,
         required: true,
         callbacks: {
           "studio_name is not a String" => lambda { |v| v.is_a? String },
           "studio_name needs to be 3..64 characters" => lambda { |v| v.length >= 3 && v.length <= 64 },
           "studio_name must match pattern ^[a-z0-9]*$" => lambda { |v| v =~ Regexp.new("/^[a-z0-9]*$/") },
         },
         description: <<~'DESCRIPTION'
           <p>The studio name that is used in the URL of the Nimble Studio portal when accessed by Nimble Studio users.</p>
         DESCRIPTION

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :user_role_arn, String,
         required: true,
         callbacks: {
           "user_role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           <p>The IAM role that Studio Users will assume when logging in to the Nimble Studio portal.</p>
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::NimbleStudio::Studio"
rest_api_document "/AWS::NimbleStudio::Studio"

rest_property_map({
  admin_role_arn:                  "AdminRoleArn",
  display_name:                    "DisplayName",
  studio_encryption_configuration: "StudioEncryptionConfiguration",
  studio_name:                     "StudioName",
  tags:                            "Tags",
  user_role_arn:                   "UserRoleArn",
})

rest_post_only_properties %i{
  studio_name tags
}
