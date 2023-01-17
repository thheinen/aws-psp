# Import API specifics
use "awscc_base"

resource_name :aws_event_schemas_registry_policy
provides :aws_event_schemas_registry_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EventSchemas::RegistryPolicy
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :policy, Hash,
         required: true,
         callbacks: {
           "policy is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :registry_name, String,
         required: true,
         callbacks: {
           "registry_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :revision_id, String,
         callbacks: {
           "revision_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::EventSchemas::RegistryPolicy"
rest_api_document "/AWS::EventSchemas::RegistryPolicy"

rest_property_map({
  policy:        "Policy",
  registry_name: "RegistryName",
  revision_id:   "RevisionId",
})

