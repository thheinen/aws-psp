# Import API specifics
use "awscc_base"

resource_name :aws_sagemaker_model_card
provides :aws_sagemaker_model_card, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SageMaker::ModelCard.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :content, Hash,
         required: true,
         description: ""

property :created_by, Hash,
         callbacks: {
           "Subproperty `UserProfileArn` is not a String" => lambda { |v| v[:UserProfileArn].is_a? String },
           "Subproperty `UserProfileArn`is not a valid ARN" => lambda { |v| v[:UserProfileArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `UserProfileName` is not a String" => lambda { |v| v[:UserProfileName].is_a? String },
           "Subproperty `DomainId` is not a String" => lambda { |v| v[:DomainId].is_a? String },
         },
         description: <<~'DESCRIPTION'
           Information about the user who created or modified an experiment, trial, trial component, lineage group, project, or model card.
         DESCRIPTION

property :last_modified_by, Hash,
         callbacks: {
           "Subproperty `UserProfileArn` is not a String" => lambda { |v| v[:UserProfileArn].is_a? String },
           "Subproperty `UserProfileArn`is not a valid ARN" => lambda { |v| v[:UserProfileArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `UserProfileName` is not a String" => lambda { |v| v[:UserProfileName].is_a? String },
           "Subproperty `DomainId` is not a String" => lambda { |v| v[:DomainId].is_a? String },
         },
         description: <<~'DESCRIPTION'
           Information about the user who created or modified an experiment, trial, trial component, lineage group, project, or model card.
         DESCRIPTION

property :model_card_name, String,
         required: true,
         callbacks: {
           "model_card_name is not a String" => lambda { |v| v.is_a? String },
           "model_card_name must match pattern ^[a-zA-Z0-9](-*[a-zA-Z0-9]){0,62}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9](-*[a-zA-Z0-9]){0,62}$/") },
         },
         description: <<~'DESCRIPTION'
           The unique name of the model card.
         DESCRIPTION

property :model_card_status, String,
         required: true,
         callbacks: {
           "model_card_status is not a String" => lambda { |v| v.is_a? String },
           "model_card_statusis not one of `Draft`, `PendingReview`, `Approved`, `Archived`" => lambda { |v| %w{Draft PendingReview Approved Archived}.include? v },
         },
         description: <<~'DESCRIPTION'
           The approval status of the model card within your organization. Different organizations might have different criteria for model card review and approval.
         DESCRIPTION

property :security_config, Hash,
         callbacks: {
           "Subproperty `KmsKeyId` is not a String" => lambda { |v| v[:KmsKeyId].is_a? String },
           "Subproperty `KmsKeyId` must match pattern .*" => lambda { |v| v[:KmsKeyId] =~ Regexp.new("/.*/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Key-value pairs used to manage metadata for model cards.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SageMaker::ModelCard"
rest_api_document "/AWS::SageMaker::ModelCard"

rest_property_map({
  content:           "Content",
  created_by:        "CreatedBy",
  last_modified_by:  "LastModifiedBy",
  model_card_name:   "ModelCardName",
  model_card_status: "ModelCardStatus",
  security_config:   "SecurityConfig",
  tags:              "Tags",
})

rest_post_only_properties %i{
  model_card_name security_config
}
