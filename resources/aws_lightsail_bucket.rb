# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_lightsail_bucket
provides :aws_lightsail_bucket, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Lightsail::Bucket
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :access_rules, Hash,
         callbacks: {
           "Subproperty `GetObject` is not a String" => lambda { |v| v[:GetObject].is_a? String },
           "Subproperty `AllowPublicOverrides` is not a Boolean" => lambda { |v| v[:AllowPublicOverrides].is_a? Boolean },
         },
         description: ""

property :bucket_name, String,
         required: true,
         callbacks: {
           "bucket_name is not a String" => lambda { |v| v.is_a? String },
           "bucket_name needs to be 3..54 characters" => lambda { |v| v.length >= 3 && v.length <= 54 },
           "bucket_name must match pattern ^[a-z0-9][a-z0-9-]{1,52}[a-z0-9]$" => lambda { |v| v =~ Regexp.new("/^[a-z0-9][a-z0-9-]{1,52}[a-z0-9]$/") },
         },
         description: <<~'DESCRIPTION'
           The name for the bucket.
         DESCRIPTION

property :bundle_id, String,
         required: true,
         callbacks: {
           "bundle_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the bundle to use for the bucket.
         DESCRIPTION

property :object_versioning, [TrueClass, FalseClass],
         callbacks: {
           "object_versioning is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Specifies whether to enable or disable versioning of objects in the bucket.
         DESCRIPTION

property :read_only_access_accounts, Array,
         callbacks: {
           "read_only_access_accounts is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of strings to specify the AWS account IDs that can access the bucket.
         DESCRIPTION

property :resources_receiving_access, Array,
         callbacks: {
           "resources_receiving_access is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The names of the Lightsail resources for which to set bucket access.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Lightsail::Bucket"
rest_api_document "/AWS::Lightsail::Bucket"

rest_property_map({
  access_rules:               "AccessRules",
  bucket_name:                "BucketName",
  bundle_id:                  "BundleId",
  object_versioning:          "ObjectVersioning",
  read_only_access_accounts:  "ReadOnlyAccessAccounts",
  resources_receiving_access: "ResourcesReceivingAccess",
  tags:                       "Tags",
})

rest_post_only_properties %i{
  bucket_name
}
