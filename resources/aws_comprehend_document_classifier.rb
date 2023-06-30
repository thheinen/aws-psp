# Import API specifics
use "awscc_base"

resource_name :aws_comprehend_document_classifier
provides :aws_comprehend_document_classifier, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Document Classifier enables training document classifier models.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :data_access_role_arn, String,
         required: true,
         callbacks: {
           "data_access_role_arn is not a String" => lambda { |v| v.is_a? String },
           "data_access_role_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "data_access_role_arn must match pattern arn:aws(-[^:]+)?:iam::[0-9]{12}:role/.+" => lambda { |v| v =~ Regexp.new("/arn:aws(-[^:]+)?:iam::[0-9]{12}:role/.+/") },
         },
         description: ""

property :document_classifier_name, String,
         required: true,
         callbacks: {
           "document_classifier_name is not a String" => lambda { |v| v.is_a? String },
           "document_classifier_name needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
           "document_classifier_name must match pattern ^[a-zA-Z0-9](-*[a-zA-Z0-9])*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9](-*[a-zA-Z0-9])*$/") },
         },
         description: ""

property :input_data_config, Hash,
         required: true,
         callbacks: {
           "Subproperty `AugmentedManifests` is not a Array" => lambda { |v| v[:AugmentedManifests].is_a? Array },
           "Subproperty `DataFormat` is not a String" => lambda { |v| v[:DataFormat].is_a? String },
           "Subproperty `DataFormat`is not one of `COMPREHEND_CSV`, `AUGMENTED_MANIFEST`" => lambda { |v| %w{COMPREHEND_CSV AUGMENTED_MANIFEST}.include? v[:DataFormat] },
           "Subproperty `LabelDelimiter` is not a String" => lambda { |v| v[:LabelDelimiter].is_a? String },
           "Subproperty `LabelDelimiter` needs to be 1..1 characters" => lambda { |v| v[:LabelDelimiter].length >= 1 && v[:LabelDelimiter].length <= 1 },
           "Subproperty `LabelDelimiter` must match pattern ^[ ~!@#$%^*\-_+=|\\:;\t>?/]$" => lambda { |v| v[:LabelDelimiter] =~ Regexp.new("/^[ ~!@#$%^*\-_+=|\\:;\t>?/]$/") },
           "Subproperty `DocumentType` is not a String" => lambda { |v| v[:DocumentType].is_a? String },
           "Subproperty `DocumentType`is not one of `PLAIN_TEXT_DOCUMENT`, `SEMI_STRUCTURED_DOCUMENT`" => lambda { |v| %w{PLAIN_TEXT_DOCUMENT SEMI_STRUCTURED_DOCUMENT}.include? v[:DocumentType] },
         },
         description: ""

property :language_code, String,
         required: true,
         callbacks: {
           "language_code is not a String" => lambda { |v| v.is_a? String },
           "language_codeis not one of `en`, `es`, `fr`, `it`, `de`, `pt`" => lambda { |v| %w{en es fr it de pt}.include? v },
         },
         description: ""

property :mode, String,
         callbacks: {
           "mode is not a String" => lambda { |v| v.is_a? String },
           "modeis not one of `MULTI_CLASS`, `MULTI_LABEL`" => lambda { |v| %w{MULTI_CLASS MULTI_LABEL}.include? v },
         },
         description: ""

property :model_kms_key_id, Hash,
         callbacks: {
           "model_kms_key_id is not a String" => lambda { |v| v.is_a? String },
           "model_kms_key_id needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
         },
         description: ""

property :model_policy, String,
         callbacks: {
           "model_policy is not a String" => lambda { |v| v.is_a? String },
           "model_policy needs to be 1..20000 characters" => lambda { |v| v.length >= 1 && v.length <= 20000 },
           "model_policy must match pattern [\u0009\u000A\u000D\u0020-\u00FF]+" => lambda { |v| v =~ Regexp.new("/[\u0009\u000A\u000D\u0020-\u00FF]+/") },
         },
         description: ""

property :output_data_config, Hash,
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :version_name, String,
         callbacks: {
           "version_name is not a String" => lambda { |v| v.is_a? String },
           "version_name needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
           "version_name must match pattern ^[a-zA-Z0-9](-*[a-zA-Z0-9])*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9](-*[a-zA-Z0-9])*$/") },
         },
         description: ""

property :volume_kms_key_id, Hash,
         callbacks: {
           "volume_kms_key_id is not a String" => lambda { |v| v.is_a? String },
           "volume_kms_key_id needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
         },
         description: ""

property :vpc_config, Hash,
         callbacks: {
           "Subproperty `SecurityGroupIds` is not a Array" => lambda { |v| v[:SecurityGroupIds].is_a? Array },
           "Subproperty `Subnets` is not a Array" => lambda { |v| v[:Subnets].is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Comprehend::DocumentClassifier"
rest_api_document "/AWS::Comprehend::DocumentClassifier"

rest_property_map({
  data_access_role_arn:     "DataAccessRoleArn",
  document_classifier_name: "DocumentClassifierName",
  input_data_config:        "InputDataConfig",
  language_code:            "LanguageCode",
  mode:                     "Mode",
  model_kms_key_id:         "ModelKmsKeyId",
  model_policy:             "ModelPolicy",
  output_data_config:       "OutputDataConfig",
  tags:                     "Tags",
  version_name:             "VersionName",
  volume_kms_key_id:        "VolumeKmsKeyId",
  vpc_config:               "VpcConfig",
})

rest_post_only_properties %i{
  data_access_role_arn document_classifier_name input_data_config language_code mode model_kms_key_id output_data_config version_name volume_kms_key_id vpc_config
}
