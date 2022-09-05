# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_appstream_stack
provides :aws_appstream_stack, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::AppStream::Stack
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :access_endpoints, Array,
         callbacks: {
           "access_endpoints is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :application_settings, Hash,
         callbacks: {
           "Subproperty `SettingsGroup` is not a String" => lambda { |v| v[:SettingsGroup].is_a? String },
           "Subproperty `Enabled` is not a Boolean" => lambda { |v| v[:Enabled].is_a? Boolean },
         },
         description: ""

property :attributes_to_delete, Array,
         callbacks: {
           "attributes_to_delete is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :delete_storage_connectors, [TrueClass, FalseClass],
         callbacks: {
           "delete_storage_connectors is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :display_name, String,
         callbacks: {
           "display_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :embed_host_domains, Array,
         callbacks: {
           "embed_host_domains is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :feedback_url, String,
         callbacks: {
           "feedback_url is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :redirect_url, String,
         callbacks: {
           "redirect_url is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :storage_connectors, Array,
         callbacks: {
           "storage_connectors is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :user_settings, Array,
         callbacks: {
           "user_settings is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::AppStream::Stack"
rest_api_document "/AWS::AppStream::Stack"

rest_property_map({
  access_endpoints:          "AccessEndpoints",
  application_settings:      "ApplicationSettings",
  attributes_to_delete:      "AttributesToDelete",
  delete_storage_connectors: "DeleteStorageConnectors",
  description:               "Description",
  display_name:              "DisplayName",
  embed_host_domains:        "EmbedHostDomains",
  feedback_url:              "FeedbackURL",
  name:                      "Name",
  redirect_url:              "RedirectURL",
  storage_connectors:        "StorageConnectors",
  tags:                      "Tags",
  user_settings:             "UserSettings",
})

rest_post_only_properties %i{
  name
}
