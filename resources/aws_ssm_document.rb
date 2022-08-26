# Import API specifics
use "awscc_base"

resource_name :aws_ssm_document
provides :aws_ssm_document, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::SSM::Document resource is an SSM document in AWS Systems Manager that defines the actions that Systems Manager performs, which can be used to set up and run commands on your instances.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :attachments, Array,
         callbacks: {
           "attachments is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "A list of key and value pairs that describe attachments to a version of a document."

property :content, [Hash, String],
         required: true,
         description: "The content for the Systems Manager document in JSON, YAML or String format."

property :document_format, String,
         callbacks: {
           "document_format is not a String" => lambda { |v| v.is_a? String },
           "document_formatis not one of `YAML`, `JSON`, `TEXT`" => lambda { |v| %w{YAML JSON TEXT}.include? v },
         },
         description: "Specify the document format for the request. The document format can be either JSON or YAML. JSON is the default format."

property :document_type, String,
         callbacks: {
           "document_type is not a String" => lambda { |v| v.is_a? String },
           "document_typeis not one of `ApplicationConfiguration`, `ApplicationConfigurationSchema`, `Automation`, `Automation.ChangeTemplate`, `ChangeCalendar`, `CloudFormation`, `Command`, `DeploymentStrategy`, `Package`, `Policy`, `ProblemAnalysis`, `ProblemAnalysisTemplate`, `Session`" => lambda { |v| %w{ApplicationConfiguration ApplicationConfigurationSchema Automation Automation.ChangeTemplate ChangeCalendar CloudFormation Command DeploymentStrategy Package Policy ProblemAnalysis ProblemAnalysisTemplate Session}.include? v },
         },
         description: "The type of document to create."

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name must match pattern ^[a-zA-Z0-9_\-.]{3,128}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_\-.]{3,128}$/") },
         },
         description: "A name for the Systems Manager document."

property :requires, Array,
         callbacks: {
           "requires is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "A list of SSM documents required by a document. For example, an ApplicationConfiguration document requires an ApplicationConfigurationSchema document."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "Optional metadata that you assign to a resource. Tags enable you to categorize a resource in different ways, such as by purpose, owner, or environment."

property :target_type, String,
         callbacks: {
           "target_type is not a String" => lambda { |v| v.is_a? String },
           "target_type must match pattern ^\/[\w\.\-\:\/]*$" => lambda { |v| v =~ Regexp.new("/^\/[\w\.\-\:\/]*$/") },
         },
         description: "Specify a target type to define the kinds of resources the document can run on."

property :update_method, String,
         callbacks: {
           "update_method is not a String" => lambda { |v| v.is_a? String },
           "update_methodis not one of `Replace`, `NewVersion`" => lambda { |v| %w{Replace NewVersion}.include? v },
         },
         description: "Update method - when set to 'Replace', the update will replace the existing document; when set to 'NewVersion', the update will create a new version."

property :version_name, String,
         callbacks: {
           "version_name is not a String" => lambda { |v| v.is_a? String },
           "version_name must match pattern ^[a-zA-Z0-9_\-.]{1,128}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_\-.]{1,128}$/") },
         },
         description: "An optional field specifying the version of the artifact you are creating with the document. This value is unique across all versions of a document, and cannot be changed."

# API URLs and mappings
rest_api_collection "/AWS::SSM::Document"
rest_api_document "/AWS::SSM::Document"

rest_property_map({
  attachments:     "Attachments",
  content:         "Content",
  document_format: "DocumentFormat",
  document_type:   "DocumentType",
  name:            "Name",
  requires:        "Requires",
  tags:            "Tags",
  target_type:     "TargetType",
  update_method:   "UpdateMethod",
  version_name:    "VersionName",
})

rest_post_only_properties %i{
  document_type name
}
