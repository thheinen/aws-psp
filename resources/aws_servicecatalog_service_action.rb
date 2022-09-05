# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_servicecatalog_service_action
provides :aws_servicecatalog_service_action, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Schema for AWS::ServiceCatalog::ServiceAction
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :accept_language, String,
         callbacks: {
           "accept_language is not a String" => lambda { |v| v.is_a? String },
           "accept_languageis not one of `en`, `jp`, `zh`" => lambda { |v| %w{en jp zh}.include? v },
         },
         description: ""

property :definition, Array,
         required: true,
         callbacks: {
           "definition is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :definition_type, String,
         required: true,
         callbacks: {
           "definition_type is not a String" => lambda { |v| v.is_a? String },
           "definition_typeis not one of `SSM_AUTOMATION`" => lambda { |v| %w{SSM_AUTOMATION}.include? v },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::ServiceCatalog::ServiceAction"
rest_api_document "/AWS::ServiceCatalog::ServiceAction"

rest_property_map({
  accept_language: "AcceptLanguage",
  definition:      "Definition",
  definition_type: "DefinitionType",
  description:     "Description",
  name:            "Name",
})

