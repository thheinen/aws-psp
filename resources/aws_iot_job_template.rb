# Import API specifics
use "awscc_base"

resource_name :aws_iot_job_template
provides :aws_iot_job_template, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Job templates enable you to preconfigure jobs so that you can deploy them to multiple sets of target devices.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :abort_config, Hash,
         callbacks: {
           "Subproperty `CriteriaList` is not a Array" => lambda { |v| v[:CriteriaList].is_a? Array },
         },
         description: "The criteria that determine when and how a job abort takes place."

property :description, String,
         required: true,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description must match pattern [^\p{C}]+" => lambda { |v| v =~ Regexp.new("/[^\p{C}]+/") },
         },
         description: "A description of the Job Template."

property :document, String,
         callbacks: {
           "document is not a String" => lambda { |v| v.is_a? String },
         },
         description: "The job document. Required if you don't specify a value for documentSource."

property :document_source, String,
         callbacks: {
           "document_source is not a String" => lambda { |v| v.is_a? String },
           "document_source needs to be 1..1350 characters" => lambda { |v| v.length >= 1 && v.length <= 1350 },
         },
         description: "An S3 link to the job document to use in the template. Required if you don't specify a value for document."

property :job_arn, String,
         callbacks: {
           "job_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: "Optional for copying a JobTemplate from a pre-existing Job configuration."

property :job_executions_retry_config, Hash,
         callbacks: {
           "Subproperty `RetryCriteriaList` is not a Array" => lambda { |v| v[:RetryCriteriaList].is_a? Array },
         },
         description: ""

property :job_executions_rollout_config, Hash,
         description: "Allows you to create a staged rollout of a job."

property :job_template_id, String,
         required: true,
         callbacks: {
           "job_template_id is not a String" => lambda { |v| v.is_a? String },
           "job_template_id needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "job_template_id must match pattern [a-zA-Z0-9_-]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9_-]+/") },
         },
         description: ""

property :presigned_url_config, Hash,
         description: "Configuration for pre-signed S3 URLs."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "Metadata that can be used to manage the JobTemplate."

property :timeout_config, Hash,
         description: "Specifies the amount of time each device has to finish its execution of the job."

# API URLs and mappings
rest_api_collection "/AWS::IoT::JobTemplate"
rest_api_document "/AWS::IoT::JobTemplate"

rest_property_map({
  abort_config:                  "AbortConfig",
  description:                   "Description",
  document:                      "Document",
  document_source:               "DocumentSource",
  job_arn:                       "JobArn",
  job_executions_retry_config:   "JobExecutionsRetryConfig",
  job_executions_rollout_config: "JobExecutionsRolloutConfig",
  job_template_id:               "JobTemplateId",
  presigned_url_config:          "PresignedUrlConfig",
  tags:                          "Tags",
  timeout_config:                "TimeoutConfig",
})

rest_post_only_properties %i{
  abort_config description document document_source job_arn job_executions_rollout_config job_template_id presigned_url_config tags timeout_config
}
