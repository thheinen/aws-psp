# Import API specifics
use "awscc_base"

resource_name :aws_wisdom_assistant_association
provides :aws_wisdom_assistant_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::Wisdom::AssistantAssociation Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :assistant_id, String,
         required: true,
         callbacks: {
           "assistant_id is not a String" => lambda { |v| v.is_a? String },
           "assistant_id must match pattern ^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$" => lambda { |v| v =~ Regexp.new("/^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$/") },
         },
         description: ""

property :association, Hash,
         required: true,
         callbacks: {
           "Subproperty `KnowledgeBaseId` is not a String" => lambda { |v| v[:KnowledgeBaseId].is_a? String },
           "Subproperty `KnowledgeBaseId` must match pattern ^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$" => lambda { |v| v[:KnowledgeBaseId] =~ Regexp.new("/^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$/") },
         },
         description: ""

property :association_type, Hash,
         required: true,
         callbacks: {
           "association_type is not a String" => lambda { |v| v.is_a? String },
           "association_typeis not one of `KNOWLEDGE_BASE`" => lambda { |v| %w{KNOWLEDGE_BASE}.include? v },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Wisdom::AssistantAssociation"
rest_api_document "/AWS::Wisdom::AssistantAssociation"

rest_property_map({
  assistant_id:     "AssistantId",
  association:      "Association",
  association_type: "AssociationType",
  tags:             "Tags",
})

rest_post_only_properties %i{
  assistant_id association association_type tags
}
