# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_sagemaker_model_package_group
provides :aws_sagemaker_model_package_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SageMaker::ModelPackageGroup
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :model_package_group_description, Hash,
         callbacks: {
           "model_package_group_description is not a String" => lambda { |v| v.is_a? String },
           "model_package_group_description must match pattern [\p{L}\p{M}\p{Z}\p{S}\p{N}\p{P}]*" => lambda { |v| v =~ Regexp.new("/[\p{L}\p{M}\p{Z}\p{S}\p{N}\p{P}]*/") },
         },
         description: ""

property :model_package_group_name, Hash,
         required: true,
         callbacks: {
           "model_package_group_name is not a String" => lambda { |v| v.is_a? String },
           "model_package_group_name must match pattern ^[a-zA-Z0-9](-*[a-zA-Z0-9])*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9](-*[a-zA-Z0-9])*$/") },
         },
         description: ""

property :model_package_group_policy, [Hash, String],
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SageMaker::ModelPackageGroup"
rest_api_document "/AWS::SageMaker::ModelPackageGroup"

rest_property_map({
  model_package_group_description: "ModelPackageGroupDescription",
  model_package_group_name:        "ModelPackageGroupName",
  model_package_group_policy:      "ModelPackageGroupPolicy",
  tags:                            "Tags",
})

rest_post_only_properties %i{
  model_package_group_description model_package_group_name
}
