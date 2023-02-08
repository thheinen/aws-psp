# Import API specifics
use "awscc_base"

resource_name :aws_organizations_resource_policy
provides :aws_organizations_resource_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  You can use AWS::Organizations::ResourcePolicy to delegate policy management for AWS Organizations to specified member accounts to perform policy actions that are by default available only to the management account.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :content, [Hash, String],
         required: true,
         description: <<~'DESCRIPTION'
           The policy document. For AWS CloudFormation templates formatted in YAML, you can provide the policy in JSON or YAML format. AWS CloudFormation always converts a YAML policy to JSON format before submitting it.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of tags that you want to attach to the resource policy
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Organizations::ResourcePolicy"
rest_api_document "/AWS::Organizations::ResourcePolicy"

rest_property_map({
  content: "Content",
  tags:    "Tags",
})

