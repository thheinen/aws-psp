# Import API specifics
use "awscc_base"

resource_name :aws_s3_object_lambda_access_point_policy
provides :aws_s3_object_lambda_access_point_policy, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  AWS::S3ObjectLambda::AccessPointPolicy resource is an Amazon S3ObjectLambda policy type that you can use to control permissions for your S3ObjectLambda
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :object_lambda_access_point, String,
         required: true,
         callbacks: {
           "object_lambda_access_point is not a String" => lambda { |v| v.is_a? String },
           "object_lambda_access_point needs to be 3..45 characters" => lambda { |v| v.length >= 3 && v.length <= 45 },
           "object_lambda_access_point must match pattern ^[a-z0-9]([a-z0-9\-]*[a-z0-9])?$" => lambda { |v| v =~ Regexp.new("/^[a-z0-9]([a-z0-9\-]*[a-z0-9])?$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the Amazon S3 ObjectLambdaAccessPoint to which the policy applies.
         DESCRIPTION

property :policy_document, Hash,
         required: true,
         callbacks: {
           "policy_document is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           A policy document containing permissions to add to the specified ObjectLambdaAccessPoint. For more information, see Access Policy Language Overview (https://docs.aws.amazon.com/AmazonS3/latest/dev/access-policy-language-overview.html) in the Amazon Simple Storage Service Developer Guide.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::S3ObjectLambda::AccessPointPolicy"
rest_api_document "/AWS::S3ObjectLambda::AccessPointPolicy"

rest_property_map({
  object_lambda_access_point: "ObjectLambdaAccessPoint",
  policy_document:            "PolicyDocument",
})

rest_post_only_properties %i{
  object_lambda_access_point
}
