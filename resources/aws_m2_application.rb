# Import API specifics
use "awscc_base"

resource_name :aws_m2_application
provides :aws_m2_application, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Represents an application that runs on an AWS Mainframe Modernization Environment
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :definition, Hash,
         required: true,
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..500 characters" => lambda { |v| v.length >= 0 && v.length <= 500 },
         },
         description: ""

property :engine_type, Hash,
         required: true,
         callbacks: {
           "engine_type is not a String" => lambda { |v| v.is_a? String },
           "engine_typeis not one of `microfocus`, `bluage`" => lambda { |v| %w{microfocus bluage}.include? v },
         },
         description: ""

property :kms_key_id, String,
         callbacks: {
           "kms_key_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID or the Amazon Resource Name (ARN) of the customer managed KMS Key used for encrypting application-related resources.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name must match pattern ^[A-Za-z0-9][A-Za-z0-9_\-]{1,59}$" => lambda { |v| v =~ Regexp.new("/^[A-Za-z0-9][A-Za-z0-9_\-]{1,59}$/") },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::M2::Application"
rest_api_document "/AWS::M2::Application"

rest_property_map({
  definition:  "Definition",
  description: "Description",
  engine_type: "EngineType",
  kms_key_id:  "KmsKeyId",
  name:        "Name",
  tags:        "Tags",
})

rest_post_only_properties %i{
  engine_type kms_key_id name
}
