# Import API specifics
use "awscc_base"

resource_name :aws_lambda_layer_version_permission
provides :aws_lambda_layer_version_permission, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Schema for Lambda LayerVersionPermission
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :action, String,
         required: true,
         callbacks: {
           "action is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The API action that grants access to the layer.
         DESCRIPTION

property :layer_version_arn, String,
         required: true,
         callbacks: {
           "layer_version_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name or Amazon Resource Name (ARN) of the layer.
         DESCRIPTION

property :organization_id, String,
         callbacks: {
           "organization_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           With the principal set to *, grant permission to all accounts in the specified organization.
         DESCRIPTION

property :principal, String,
         required: true,
         callbacks: {
           "principal is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           An account ID, or * to grant layer usage permission to all accounts in an organization, or all AWS accounts (if organizationId is not specified).
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Lambda::LayerVersionPermission"
rest_api_document "/AWS::Lambda::LayerVersionPermission"

rest_property_map({
  action:            "Action",
  layer_version_arn: "LayerVersionArn",
  organization_id:   "OrganizationId",
  principal:         "Principal",
})

rest_post_only_properties %i{
  action layer_version_arn organization_id principal
}
