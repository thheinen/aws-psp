# Import API specifics
use "awscc_base"

resource_name :aws_ssm_resource_policy
provides :aws_ssm_resource_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SSM::ResourcePolicy
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :policy, [Hash, String],
         required: true,
         description: <<~'DESCRIPTION'
           Actual policy statement.
         DESCRIPTION

property :resource_arn, String,
         required: true,
         callbacks: {
           "resource_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Arn of OpsItemGroup etc.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SSM::ResourcePolicy"
rest_api_document "/AWS::SSM::ResourcePolicy"

rest_property_map({
  policy:       "Policy",
  resource_arn: "ResourceArn",
})

rest_post_only_properties %i{
  resource_arn
}
