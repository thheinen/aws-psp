# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_ecr_registry_policy
provides :aws_ecr_registry_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::ECR::RegistryPolicy is used to specify permissions for another AWS account and is used when configuring cross-account replication. For more information, see Registry permissions in the Amazon Elastic Container Registry User Guide: https://docs.aws.amazon.com/AmazonECR/latest/userguide/registry-permissions.html
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :policy_text, Hash,
         required: true,
         callbacks: {
           "policy_text is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           The JSON policy text to apply to your registry. The policy text follows the same format as IAM policy text. For more information, see Registry permissions (https://docs.aws.amazon.com/AmazonECR/latest/userguide/registry-permissions.html) in the Amazon Elastic Container Registry User Guide.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ECR::RegistryPolicy"
rest_api_document "/AWS::ECR::RegistryPolicy"

rest_property_map({
  policy_text: "PolicyText",
})

