# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_servicecatalog_service_action_association
provides :aws_servicecatalog_service_action_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Schema for AWS::ServiceCatalog::ServiceActionAssociation
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :product_id, String,
         required: true,
         callbacks: {
           "product_id is not a String" => lambda { |v| v.is_a? String },
           "product_id needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "product_id must match pattern ^[a-zA-Z0-9][a-zA-Z0-9_-]{1,99}\Z" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9][a-zA-Z0-9_-]{1,99}\Z/") },
         },
         description: ""

property :provisioning_artifact_id, String,
         required: true,
         callbacks: {
           "provisioning_artifact_id is not a String" => lambda { |v| v.is_a? String },
           "provisioning_artifact_id needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "provisioning_artifact_id must match pattern ^[a-zA-Z0-9][a-zA-Z0-9_-]{1,99}\Z" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9][a-zA-Z0-9_-]{1,99}\Z/") },
         },
         description: ""

property :service_action_id, String,
         required: true,
         callbacks: {
           "service_action_id is not a String" => lambda { |v| v.is_a? String },
           "service_action_id needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "service_action_id must match pattern ^[a-zA-Z0-9][a-zA-Z0-9_-]{1,99}\Z" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9][a-zA-Z0-9_-]{1,99}\Z/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::ServiceCatalog::ServiceActionAssociation"
rest_api_document "/AWS::ServiceCatalog::ServiceActionAssociation"

rest_property_map({
  product_id:               "ProductId",
  provisioning_artifact_id: "ProvisioningArtifactId",
  service_action_id:        "ServiceActionId",
})

rest_post_only_properties %i{
  product_id provisioning_artifact_id service_action_id
}
