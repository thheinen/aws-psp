# Import API specifics
use "awscc_base"

resource_name :aws_connect_instance
provides :aws_connect_instance, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Connect::Instance
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :attributes, Hash,
         required: true,
         description: "The attributes for the instance."

property :directory_id, String,
         callbacks: {
           "directory_id is not a String" => lambda { |v| v.is_a? String },
           "directory_id needs to be 12..12 characters" => lambda { |v| v.length >= 12 && v.length <= 12 },
           "directory_id must match pattern ^d-[0-9a-f]{10}$" => lambda { |v| v =~ Regexp.new("/^d-[0-9a-f]{10}$/") },
         },
         description: "Existing directoryId user wants to map to the new Connect instance."

property :identity_management_type, String,
         required: true,
         callbacks: {
           "identity_management_type is not a String" => lambda { |v| v.is_a? String },
           "identity_management_typeis not one of `SAML`, `CONNECT_MANAGED`, `EXISTING_DIRECTORY`" => lambda { |v| %w{SAML CONNECT_MANAGED EXISTING_DIRECTORY}.include? v },
         },
         description: "Specifies the type of directory integration for new instance."

property :instance_alias, String,
         callbacks: {
           "instance_alias is not a String" => lambda { |v| v.is_a? String },
           "instance_alias needs to be 1..62 characters" => lambda { |v| v.length >= 1 && v.length <= 62 },
           "instance_alias must match pattern ^(?!d-)([\da-zA-Z]+)([-]*[\da-zA-Z])*$" => lambda { |v| v =~ Regexp.new("/^(?!d-)([\da-zA-Z]+)([-]*[\da-zA-Z])*$/") },
         },
         description: "Alias of the new directory created as part of new instance creation."

# API URLs and mappings
rest_api_collection "/AWS::Connect::Instance"
rest_api_document "/AWS::Connect::Instance"

rest_property_map({
  attributes:               "Attributes",
  directory_id:             "DirectoryId",
  identity_management_type: "IdentityManagementType",
  instance_alias:           "InstanceAlias",
})

rest_post_only_properties %i{
  directory_id identity_management_type instance_alias
}
