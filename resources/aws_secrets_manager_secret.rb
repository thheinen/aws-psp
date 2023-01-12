# Import API specifics
use "awscc_base"

resource_name :aws_secrets_manager_secret
provides :aws_secrets_manager_secret, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SecretsManager::Secret
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           (Optional) Specifies a user-provided description of the secret.
         DESCRIPTION

property :generate_secret_string, Hash,
         callbacks: {
           "Subproperty `ExcludeUppercase` is not a Boolean" => lambda { |v| v[:ExcludeUppercase].is_a? Boolean },
           "Subproperty `RequireEachIncludedType` is not a Boolean" => lambda { |v| v[:RequireEachIncludedType].is_a? Boolean },
           "Subproperty `IncludeSpace` is not a Boolean" => lambda { |v| v[:IncludeSpace].is_a? Boolean },
           "Subproperty `ExcludeCharacters` is not a String" => lambda { |v| v[:ExcludeCharacters].is_a? String },
           "Subproperty `GenerateStringKey` is not a String" => lambda { |v| v[:GenerateStringKey].is_a? String },
           "Subproperty `PasswordLength` is not a Integer" => lambda { |v| v[:PasswordLength].is_a? Integer },
           "Subproperty `ExcludePunctuation` is not a Boolean" => lambda { |v| v[:ExcludePunctuation].is_a? Boolean },
           "Subproperty `ExcludeLowercase` is not a Boolean" => lambda { |v| v[:ExcludeLowercase].is_a? Boolean },
           "Subproperty `SecretStringTemplate` is not a String" => lambda { |v| v[:SecretStringTemplate].is_a? String },
           "Subproperty `ExcludeNumbers` is not a Boolean" => lambda { |v| v[:ExcludeNumbers].is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           (Optional) Specifies text data that you want to encrypt and store in this new version of the secret.
         DESCRIPTION

property :kms_key_id, String,
         callbacks: {
           "kms_key_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           (Optional) Specifies the ARN, Key ID, or alias of the AWS KMS customer master key (CMK) used to encrypt the SecretString.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The friendly name of the secret. You can use forward slashes in the name to represent a path hierarchy.
         DESCRIPTION

property :replica_regions, Array,
         callbacks: {
           "replica_regions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           (Optional) A list of ReplicaRegion objects. The ReplicaRegion type consists of a Region (required) and the KmsKeyId which can be an ARN, Key ID, or Alias.
         DESCRIPTION

property :secret_string, String,
         callbacks: {
           "secret_string is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           (Optional) Specifies text data that you want to encrypt and store in this new version of the secret.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The list of user-defined tags associated with the secret. Use tags to manage your AWS resources. For additional information about tags, see TagResource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SecretsManager::Secret"
rest_api_document "/AWS::SecretsManager::Secret"

rest_property_map({
  description:            "Description",
  generate_secret_string: "GenerateSecretString",
  kms_key_id:             "KmsKeyId",
  name:                   "Name",
  replica_regions:        "ReplicaRegions",
  secret_string:          "SecretString",
  tags:                   "Tags",
})

rest_post_only_properties %i{
  name
}
