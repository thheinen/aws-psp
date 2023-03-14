# Import API specifics
use "awscc_base"

resource_name :aws_comprehend_flywheel
provides :aws_comprehend_flywheel, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::Comprehend::Flywheel resource creates an Amazon Comprehend Flywheel that enables customer to train their model.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :active_model_arn, String,
         callbacks: {
           "active_model_arn is not a String" => lambda { |v| v.is_a? String },
           "active_model_arn must match pattern arn:aws(-[^:]+)?:comprehend:[a-zA-Z0-9-]*:[0-9]{12}:(document-classifier|entity-recognizer)/[a-zA-Z0-9](-*[a-zA-Z0-9])*(/version/[a-zA-Z0-9](-*[a-zA-Z0-9])*)?" => lambda { |v| v =~ Regexp.new("/arn:aws(-[^:]+)?:comprehend:[a-zA-Z0-9-]*:[0-9]{12}:(document-classifier|entity-recognizer)/[a-zA-Z0-9](-*[a-zA-Z0-9])*(/version/[a-zA-Z0-9](-*[a-zA-Z0-9])*)?/") },
         },
         description: ""

property :data_access_role_arn, String,
         required: true,
         callbacks: {
           "data_access_role_arn is not a String" => lambda { |v| v.is_a? String },
           "data_access_role_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "data_access_role_arn must match pattern arn:aws(-[^:]+)?:iam::[0-9]{12}:role/.+" => lambda { |v| v =~ Regexp.new("/arn:aws(-[^:]+)?:iam::[0-9]{12}:role/.+/") },
         },
         description: ""

property :data_lake_s3_uri, String,
         required: true,
         callbacks: {
           "data_lake_s3_uri is not a String" => lambda { |v| v.is_a? String },
           "data_lake_s3_uri must match pattern s3://[a-z0-9][\.\-a-z0-9]{1,61}[a-z0-9](/.*)?" => lambda { |v| v =~ Regexp.new("/s3://[a-z0-9][\.\-a-z0-9]{1,61}[a-z0-9](/.*)?/") },
         },
         description: ""

property :data_security_config, Hash,
         description: ""

property :flywheel_name, String,
         required: true,
         callbacks: {
           "flywheel_name is not a String" => lambda { |v| v.is_a? String },
           "flywheel_name needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
           "flywheel_name must match pattern ^[a-zA-Z0-9](-*[a-zA-Z0-9])*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9](-*[a-zA-Z0-9])*$/") },
         },
         description: ""

property :model_type, String,
         callbacks: {
           "model_type is not a String" => lambda { |v| v.is_a? String },
           "model_typeis not one of `DOCUMENT_CLASSIFIER`, `ENTITY_RECOGNIZER`" => lambda { |v| %w{DOCUMENT_CLASSIFIER ENTITY_RECOGNIZER}.include? v },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :task_config, Hash,
         callbacks: {
           "Subproperty `LanguageCode` is not a String" => lambda { |v| v[:LanguageCode].is_a? String },
           "Subproperty `LanguageCode`is not one of `en`, `es`, `fr`, `it`, `de`, `pt`" => lambda { |v| %w{en es fr it de pt}.include? v[:LanguageCode] },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Comprehend::Flywheel"
rest_api_document "/AWS::Comprehend::Flywheel"

rest_property_map({
  active_model_arn:     "ActiveModelArn",
  data_access_role_arn: "DataAccessRoleArn",
  data_lake_s3_uri:     "DataLakeS3Uri",
  data_security_config: "DataSecurityConfig",
  flywheel_name:        "FlywheelName",
  model_type:           "ModelType",
  tags:                 "Tags",
  task_config:          "TaskConfig",
})

rest_post_only_properties %i{
  data_lake_s3_uri flywheel_name model_type task_config
}
