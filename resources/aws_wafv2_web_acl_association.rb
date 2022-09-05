# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_wafv2_web_acl_association
provides :aws_wafv2_web_acl_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Associates WebACL to Application Load Balancer, CloudFront or API Gateway.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :resource_arn, Hash,
         required: true,
         callbacks: {
           "resource_arn is not a String" => lambda { |v| v.is_a? String },
           "resource_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
         },
         description: ""

property :web_acl_arn, Hash,
         required: true,
         callbacks: {
           "web_acl_arn is not a String" => lambda { |v| v.is_a? String },
           "web_acl_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::WAFv2::WebACLAssociation"
rest_api_document "/AWS::WAFv2::WebACLAssociation"

rest_property_map({
  resource_arn: "ResourceArn",
  web_acl_arn:  "WebACLArn",
})

rest_post_only_properties %i{
  resource_arn web_acl_arn
}
