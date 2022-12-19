# Import API specifics
use "awscc_base"

resource_name :aws_greengrass_v2_component_version
provides :aws_greengrass_v2_component_version, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource for Greengrass component version.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :inline_recipe, String,
         callbacks: {
           "inline_recipe is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :lambda_function, Hash,
         callbacks: {
           "Subproperty `LambdaArn` is not a String" => lambda { |v| v[:LambdaArn].is_a? String },
           "Subproperty `LambdaArn` must match pattern ^arn:aws(-(cn|us-gov))?:lambda:(([a-z]+-)+[0-9])?:([0-9]{12})?:[^.]+$" => lambda { |v| v[:LambdaArn] =~ Regexp.new("/^arn:aws(-(cn|us-gov))?:lambda:(([a-z]+-)+[0-9])?:([0-9]{12})?:[^.]+$/") },
           "Subproperty `LambdaArn`is not a valid ARN" => lambda { |v| v[:LambdaArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `ComponentName` is not a String" => lambda { |v| v[:ComponentName].is_a? String },
           "Subproperty `ComponentVersion` is not a String" => lambda { |v| v[:ComponentVersion].is_a? String },
           "Subproperty `ComponentPlatforms` is not a Array" => lambda { |v| v[:ComponentPlatforms].is_a? Array },
           "Subproperty `ComponentDependencies` is not a Object" => lambda { |v| v[:ComponentDependencies].is_a? Object },
         },
         description: ""

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::GreengrassV2::ComponentVersion"
rest_api_document "/AWS::GreengrassV2::ComponentVersion"

rest_property_map({
  inline_recipe:   "InlineRecipe",
  lambda_function: "LambdaFunction",
  tags:            "Tags",
})

rest_post_only_properties %i{
  inline_recipe lambda_function
}
