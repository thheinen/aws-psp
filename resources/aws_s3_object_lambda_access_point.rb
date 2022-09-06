# Import API specifics
use "awscc_base"

resource_name :aws_s3_object_lambda_access_point
provides :aws_s3_object_lambda_access_point, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::S3ObjectLambda::AccessPoint resource is an Amazon S3ObjectLambda resource type that you can use to add computation to S3 actions
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 3..45 characters" => lambda { |v| v.length >= 3 && v.length <= 45 },
           "name must match pattern ^[a-z0-9]([a-z0-9\-]*[a-z0-9])?$" => lambda { |v| v =~ Regexp.new("/^[a-z0-9]([a-z0-9\-]*[a-z0-9])?$/") },
         },
         description: <<~'DESCRIPTION'
           The name you want to assign to this Object lambda Access Point.
         DESCRIPTION

property :object_lambda_configuration, Hash,
         required: true,
         callbacks: {
           "Subproperty `SupportingAccessPoint` is not a String" => lambda { |v| v[:SupportingAccessPoint].is_a? String },
           "Subproperty `SupportingAccessPoint` needs to be 1..2048 characters" => lambda { |v| v[:SupportingAccessPoint].length >= 1 && v[:SupportingAccessPoint].length <= 2048 },
           "Subproperty `AllowedFeatures` is not a Array" => lambda { |v| v[:AllowedFeatures].is_a? Array },
           "Subproperty `CloudWatchMetricsEnabled` is not a Boolean" => lambda { |v| v[:CloudWatchMetricsEnabled].is_a? Boolean },
           "Subproperty `TransformationConfigurations` is not a Array" => lambda { |v| v[:TransformationConfigurations].is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The Object lambda Access Point Configuration that configures transformations to be applied on the objects on specified S3 Actions
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::S3ObjectLambda::AccessPoint"
rest_api_document "/AWS::S3ObjectLambda::AccessPoint"

rest_property_map({
  name:                        "Name",
  object_lambda_configuration: "ObjectLambdaConfiguration",
})

rest_post_only_properties %i{
  name
}
