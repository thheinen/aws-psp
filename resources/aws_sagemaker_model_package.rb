# Import API specifics
use "awscc_base"

resource_name :aws_sagemaker_model_package
provides :aws_sagemaker_model_package, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SageMaker::ModelPackage
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :additional_inference_specifications, Hash,
         callbacks: {
           "additional_inference_specifications is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :additional_inference_specifications_to_add, Hash,
         callbacks: {
           "additional_inference_specifications_to_add is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :approval_description, Hash,
         callbacks: {
           "approval_description is not a String" => lambda { |v| v.is_a? String },
           "approval_description must match pattern .*" => lambda { |v| v =~ Regexp.new("/.*/") },
         },
         description: ""

property :certify_for_marketplace, Hash,
         callbacks: {
           "certify_for_marketplace is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :client_token, Hash,
         callbacks: {
           "client_token is not a String" => lambda { |v| v.is_a? String },
           "client_token needs to be 1..36 characters" => lambda { |v| v.length >= 1 && v.length <= 36 },
           "client_token must match pattern ^[a-zA-Z0-9-]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9-]+$/") },
         },
         description: ""

property :customer_metadata_properties, Hash,
         callbacks: {
           "customer_metadata_properties is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :domain, Hash,
         callbacks: {
           "domain is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :drift_check_baselines, Hash,
         description: ""

property :inference_specification, Hash,
         callbacks: {
           "Subproperty `Containers` is not a Array" => lambda { |v| v[:Containers].is_a? Array },
           "Subproperty `SupportedContentTypes` is not a Array" => lambda { |v| v[:SupportedContentTypes].is_a? Array },
           "Subproperty `SupportedRealtimeInferenceInstanceTypes` is not a Array" => lambda { |v| v[:SupportedRealtimeInferenceInstanceTypes].is_a? Array },
           "Subproperty `SupportedResponseMIMETypes` is not a Array" => lambda { |v| v[:SupportedResponseMIMETypes].is_a? Array },
           "Subproperty `SupportedTransformInstanceTypes` is not a Array" => lambda { |v| v[:SupportedTransformInstanceTypes].is_a? Array },
         },
         description: ""

property :last_modified_time, Hash,
         callbacks: {
           "last_modified_time is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :metadata_properties, Hash,
         callbacks: {
           "Subproperty `CommitId` is not a String" => lambda { |v| v[:CommitId].is_a? String },
           "Subproperty `CommitId` must match pattern .*" => lambda { |v| v[:CommitId] =~ Regexp.new("/.*/") },
           "Subproperty `GeneratedBy` is not a String" => lambda { |v| v[:GeneratedBy].is_a? String },
           "Subproperty `GeneratedBy` must match pattern .*" => lambda { |v| v[:GeneratedBy] =~ Regexp.new("/.*/") },
           "Subproperty `ProjectId` is not a String" => lambda { |v| v[:ProjectId].is_a? String },
           "Subproperty `ProjectId` must match pattern .*" => lambda { |v| v[:ProjectId] =~ Regexp.new("/.*/") },
           "Subproperty `Repository` is not a String" => lambda { |v| v[:Repository].is_a? String },
           "Subproperty `Repository` must match pattern .*" => lambda { |v| v[:Repository] =~ Regexp.new("/.*/") },
         },
         description: ""

property :model_approval_status, Hash,
         callbacks: {
           "model_approval_status is not a String" => lambda { |v| v.is_a? String },
           "model_approval_statusis not one of `Approved`, `Rejected`, `PendingManualApproval`" => lambda { |v| %w{Approved Rejected PendingManualApproval}.include? v },
         },
         description: ""

property :model_metrics, Hash,
         description: ""

property :model_package_description, Hash,
         callbacks: {
           "model_package_description is not a String" => lambda { |v| v.is_a? String },
           "model_package_description must match pattern [\p{L}\p{M}\p{Z}\p{S}\p{N}\p{P}]*" => lambda { |v| v =~ Regexp.new("/[\p{L}\p{M}\p{Z}\p{S}\p{N}\p{P}]*/") },
         },
         description: ""

property :model_package_group_name, Hash,
         callbacks: {
           "model_package_group_name is not a String" => lambda { |v| v.is_a? String },
           "model_package_group_name needs to be 1..170 characters" => lambda { |v| v.length >= 1 && v.length <= 170 },
           "model_package_group_name must match pattern (arn:aws[a-z\-]*:sagemaker:[a-z0-9\-]*:[0-9]{12}:[a-z\-]*\/)?([a-zA-Z0-9]([a-zA-Z0-9-]){0,62})(?<!-)$" => lambda { |v| v =~ Regexp.new("/(arn:aws[a-z\-]*:sagemaker:[a-z0-9\-]*:[0-9]{12}:[a-z\-]*\/)?([a-zA-Z0-9]([a-zA-Z0-9-]){0,62})(?<!-)$/") },
         },
         description: ""

property :model_package_name, Hash,
         callbacks: {
           "model_package_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :model_package_status_details, Hash,
         callbacks: {
           "Subproperty `ImageScanStatuses` is not a Array" => lambda { |v| v[:ImageScanStatuses].is_a? Array },
           "Subproperty `ValidationStatuses` is not a Array" => lambda { |v| v[:ValidationStatuses].is_a? Array },
         },
         description: ""

property :model_package_version, Hash,
         callbacks: {
           "model_package_version is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: ""

property :sample_payload_url, Hash,
         callbacks: {
           "sample_payload_url is not a String" => lambda { |v| v.is_a? String },
           "sample_payload_url must match pattern ^(https|s3)://([^/]+)/?(.*)$" => lambda { |v| v =~ Regexp.new("/^(https|s3)://([^/]+)/?(.*)$/") },
         },
         description: ""

property :source_algorithm_specification, Hash,
         callbacks: {
           "Subproperty `SourceAlgorithms` is not a Array" => lambda { |v| v[:SourceAlgorithms].is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

property :task, Hash,
         callbacks: {
           "task is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :validation_specification, Hash,
         callbacks: {
           "Subproperty `ValidationProfiles` is not a Array" => lambda { |v| v[:ValidationProfiles].is_a? Array },
           "Subproperty `ValidationRole` is not a String" => lambda { |v| v[:ValidationRole].is_a? String },
           "Subproperty `ValidationRole` needs to be 20..2048 characters" => lambda { |v| v[:ValidationRole].length >= 20 && v[:ValidationRole].length <= 2048 },
           "Subproperty `ValidationRole` must match pattern ^arn:aws[a-z\-]*:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+$" => lambda { |v| v[:ValidationRole] =~ Regexp.new("/^arn:aws[a-z\-]*:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+$/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::SageMaker::ModelPackage"
rest_api_document "/AWS::SageMaker::ModelPackage"

rest_property_map({
  additional_inference_specifications:        "AdditionalInferenceSpecifications",
  additional_inference_specifications_to_add: "AdditionalInferenceSpecificationsToAdd",
  approval_description:                       "ApprovalDescription",
  certify_for_marketplace:                    "CertifyForMarketplace",
  client_token:                               "ClientToken",
  customer_metadata_properties:               "CustomerMetadataProperties",
  domain:                                     "Domain",
  drift_check_baselines:                      "DriftCheckBaselines",
  inference_specification:                    "InferenceSpecification",
  last_modified_time:                         "LastModifiedTime",
  metadata_properties:                        "MetadataProperties",
  model_approval_status:                      "ModelApprovalStatus",
  model_metrics:                              "ModelMetrics",
  model_package_description:                  "ModelPackageDescription",
  model_package_group_name:                   "ModelPackageGroupName",
  model_package_name:                         "ModelPackageName",
  model_package_status_details:               "ModelPackageStatusDetails",
  model_package_version:                      "ModelPackageVersion",
  sample_payload_url:                         "SamplePayloadUrl",
  source_algorithm_specification:             "SourceAlgorithmSpecification",
  tags:                                       "Tags",
  task:                                       "Task",
  validation_specification:                   "ValidationSpecification",
})

rest_post_only_properties %i{
  client_token domain drift_check_baselines inference_specification metadata_properties model_metrics model_package_description model_package_group_name sample_payload_url source_algorithm_specification task validation_specification
}
