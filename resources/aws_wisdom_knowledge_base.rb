# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_wisdom_knowledge_base
provides :aws_wisdom_knowledge_base, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::Wisdom::KnowledgeBase Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: ""

property :knowledge_base_type, Hash,
         required: true,
         callbacks: {
           "knowledge_base_type is not a String" => lambda { |v| v.is_a? String },
           "knowledge_base_typeis not one of `EXTERNAL`, `CUSTOM`" => lambda { |v| %w{EXTERNAL CUSTOM}.include? v },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: ""

property :rendering_configuration, Hash,
         callbacks: {
           "Subproperty `TemplateUri` is not a String" => lambda { |v| v[:TemplateUri].is_a? String },
           "Subproperty `TemplateUri` needs to be 1..4096 characters" => lambda { |v| v[:TemplateUri].length >= 1 && v[:TemplateUri].length <= 4096 },
         },
         description: ""

property :server_side_encryption_configuration, Hash,
         callbacks: {
           "Subproperty `KmsKeyId` is not a String" => lambda { |v| v[:KmsKeyId].is_a? String },
           "Subproperty `KmsKeyId` needs to be 1..4096 characters" => lambda { |v| v[:KmsKeyId].length >= 1 && v[:KmsKeyId].length <= 4096 },
         },
         description: ""

property :source_configuration, Hash,
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Wisdom::KnowledgeBase"
rest_api_document "/AWS::Wisdom::KnowledgeBase"

rest_property_map({
  description:                          "Description",
  knowledge_base_type:                  "KnowledgeBaseType",
  name:                                 "Name",
  rendering_configuration:              "RenderingConfiguration",
  server_side_encryption_configuration: "ServerSideEncryptionConfiguration",
  source_configuration:                 "SourceConfiguration",
  tags:                                 "Tags",
})

rest_post_only_properties %i{
  description knowledge_base_type name server_side_encryption_configuration source_configuration tags
}
