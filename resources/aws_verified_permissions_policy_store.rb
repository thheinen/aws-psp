# Import API specifics
use "awscc_base"

resource_name :aws_verified_permissions_policy_store
provides :aws_verified_permissions_policy_store, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::VerifiedPermissions::PolicyStore Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :schema, Hash,
         description: ""

property :validation_settings, Hash,
         required: true,
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::VerifiedPermissions::PolicyStore"
rest_api_document "/AWS::VerifiedPermissions::PolicyStore"

rest_property_map({
  schema:              "Schema",
  validation_settings: "ValidationSettings",
})

