# Import API specifics
use "awscc_base"

resource_name :aws_cloudtrail_resource_policy
provides :aws_cloudtrail_resource_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::CloudTrail::ResourcePolicy
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :resource_arn, String,
         required: true,
         callbacks: {
           "resource_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ARN of the AWS CloudTrail resource to which the policy applies.
         DESCRIPTION

property :resource_policy, [Hash, String],
         required: true,
         description: <<~'DESCRIPTION'
           A policy document containing permissions to add to the specified resource. In IAM, you must provide policy documents in JSON format. However, in CloudFormation you can provide the policy in JSON or YAML format because CloudFormation converts YAML to JSON before submitting it to IAM.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::CloudTrail::ResourcePolicy"
rest_api_document "/AWS::CloudTrail::ResourcePolicy"

rest_property_map({
  resource_arn:    "ResourceArn",
  resource_policy: "ResourcePolicy",
})

rest_post_only_properties %i{
  resource_arn
}
