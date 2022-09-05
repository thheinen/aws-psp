# Import API specifics
use "awscc_base"

resource_name :aws_customer_profiles_object_type
provides :aws_customer_profiles_object_type, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  An ObjectType resource of Amazon Connect Customer Profiles
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :allow_profile_creation, [TrueClass, FalseClass],
         callbacks: {
           "allow_profile_creation is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Indicates whether a profile should be created when data is received.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..1000 characters" => lambda { |v| v.length >= 1 && v.length <= 1000 },
         },
         description: <<~'DESCRIPTION'
           Description of the profile object type.
         DESCRIPTION

property :domain_name, String,
         required: true,
         callbacks: {
           "domain_name is not a String" => lambda { |v| v.is_a? String },
           "domain_name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "domain_name must match pattern ^[a-zA-Z0-9_-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_-]+$/") },
         },
         description: <<~'DESCRIPTION'
           The unique name of the domain.
         DESCRIPTION

property :encryption_key, String,
         callbacks: {
           "encryption_key is not a String" => lambda { |v| v.is_a? String },
           "encryption_key needs to be 0..255 characters" => lambda { |v| v.length >= 0 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           The default encryption key
         DESCRIPTION

property :expiration_days, Integer,
         callbacks: {
           "expiration_days is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The default number of days until the data within the domain expires.
         DESCRIPTION

property :fields, Array,
         callbacks: {
           "fields is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of the name and ObjectType field.
         DESCRIPTION

property :keys, Array,
         callbacks: {
           "keys is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of unique keys that can be used to map data to the profile.
         DESCRIPTION

property :object_type_name, String,
         callbacks: {
           "object_type_name is not a String" => lambda { |v| v.is_a? String },
           "object_type_name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "object_type_name must match pattern ^[a-zA-Z_][a-zA-Z_0-9-]*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z_][a-zA-Z_0-9-]*$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the profile object type.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags (keys and values) associated with the integration.
         DESCRIPTION

property :template_id, String,
         callbacks: {
           "template_id is not a String" => lambda { |v| v.is_a? String },
           "template_id needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "template_id must match pattern ^[a-zA-Z0-9_-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_-]+$/") },
         },
         description: <<~'DESCRIPTION'
           A unique identifier for the object template.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::CustomerProfiles::ObjectType"
rest_api_document "/AWS::CustomerProfiles::ObjectType"

rest_property_map({
  allow_profile_creation: "AllowProfileCreation",
  description:            "Description",
  domain_name:            "DomainName",
  encryption_key:         "EncryptionKey",
  expiration_days:        "ExpirationDays",
  fields:                 "Fields",
  keys:                   "Keys",
  object_type_name:       "ObjectTypeName",
  tags:                   "Tags",
  template_id:            "TemplateId",
})

rest_post_only_properties %i{
  domain_name object_type_name
}
