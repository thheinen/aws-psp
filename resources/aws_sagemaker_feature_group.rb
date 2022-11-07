# Import API specifics
use "awscc_base"

resource_name :aws_sagemaker_feature_group
provides :aws_sagemaker_feature_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SageMaker::FeatureGroup
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Description about the FeatureGroup.
         DESCRIPTION

property :event_time_feature_name, String,
         required: true,
         callbacks: {
           "event_time_feature_name is not a String" => lambda { |v| v.is_a? String },
           "event_time_feature_name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "event_time_feature_name must match pattern ^[a-zA-Z0-9](-*[a-zA-Z0-9]){0,63}" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9](-*[a-zA-Z0-9]){0,63}/") },
         },
         description: <<~'DESCRIPTION'
           The Event Time Feature Name.
         DESCRIPTION

property :feature_definitions, Array,
         required: true,
         callbacks: {
           "feature_definitions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An Array of Feature Definition
         DESCRIPTION

property :feature_group_name, String,
         required: true,
         callbacks: {
           "feature_group_name is not a String" => lambda { |v| v.is_a? String },
           "feature_group_name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "feature_group_name must match pattern ^[a-zA-Z0-9](-*[a-zA-Z0-9]){0,63}" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9](-*[a-zA-Z0-9]){0,63}/") },
         },
         description: <<~'DESCRIPTION'
           The Name of the FeatureGroup.
         DESCRIPTION

property :offline_store_config, Hash,
         callbacks: {
           "Subproperty `DisableGlueTableCreation` is not a Boolean" => lambda { |v| v[:DisableGlueTableCreation].is_a? Boolean },
         },
         description: ""

property :online_store_config, Hash,
         callbacks: {
           "Subproperty `EnableOnlineStore` is not a Boolean" => lambda { |v| v[:EnableOnlineStore].is_a? Boolean },
         },
         description: ""

property :record_identifier_feature_name, String,
         required: true,
         callbacks: {
           "record_identifier_feature_name is not a String" => lambda { |v| v.is_a? String },
           "record_identifier_feature_name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "record_identifier_feature_name must match pattern ^[a-zA-Z0-9](-*[a-zA-Z0-9]){0,63}" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9](-*[a-zA-Z0-9]){0,63}/") },
         },
         description: <<~'DESCRIPTION'
           The Record Identifier Feature Name.
         DESCRIPTION

property :role_arn, String,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
           "role_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "role_arn must match pattern ^arn:aws[a-z\-]*:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+$" => lambda { |v| v =~ Regexp.new("/^arn:aws[a-z\-]*:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+$/") },
         },
         description: <<~'DESCRIPTION'
           Role Arn
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pair to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SageMaker::FeatureGroup"
rest_api_document "/AWS::SageMaker::FeatureGroup"

rest_property_map({
  description:                    "Description",
  event_time_feature_name:        "EventTimeFeatureName",
  feature_definitions:            "FeatureDefinitions",
  feature_group_name:             "FeatureGroupName",
  offline_store_config:           "OfflineStoreConfig",
  online_store_config:            "OnlineStoreConfig",
  record_identifier_feature_name: "RecordIdentifierFeatureName",
  role_arn:                       "RoleArn",
  tags:                           "Tags",
})

rest_post_only_properties %i{
  description event_time_feature_name feature_group_name offline_store_config online_store_config record_identifier_feature_name role_arn tags
}
