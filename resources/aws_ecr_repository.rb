# Import API specifics
use "awscc_base"

resource_name :aws_ecr_repository
provides :aws_ecr_repository, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::ECR::Repository resource specifies an Amazon Elastic Container Registry (Amazon ECR) repository, where users can push and pull Docker images. For more information, see https://docs.aws.amazon.com/AmazonECR/latest/userguide/Repositories.html
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :encryption_configuration, Hash,
         description: ""

property :image_scanning_configuration, Hash,
         description: ""

property :image_tag_mutability, String,
         callbacks: {
           "image_tag_mutability is not a String" => lambda { |v| v.is_a? String },
           "image_tag_mutabilityis not one of `MUTABLE`, `IMMUTABLE`" => lambda { |v| %w{MUTABLE IMMUTABLE}.include? v },
         },
         description: "The image tag mutability setting for the repository."

property :lifecycle_policy, Hash,
         description: ""

property :repository_name, String,
         callbacks: {
           "repository_name is not a String" => lambda { |v| v.is_a? String },
           "repository_name needs to be 2..256 characters" => lambda { |v| v.length >= 2 && v.length <= 256 },
           "repository_name must match pattern ^(?=.{2,256}$)((?:[a-z0-9]+(?:[._-][a-z0-9]+)*/)*[a-z0-9]+(?:[._-][a-z0-9]+)*)$" => lambda { |v| v =~ Regexp.new("/^(?=.{2,256}$)((?:[a-z0-9]+(?:[._-][a-z0-9]+)*/)*[a-z0-9]+(?:[._-][a-z0-9]+)*)$/") },
         },
         description: "The name to use for the repository. The repository name may be specified on its own (such as nginx-web-app) or it can be prepended with a namespace to group the repository into a category (such as project-a/nginx-web-app). If you don't specify a name, AWS CloudFormation generates a unique physical ID and uses that ID for the repository name. For more information, see https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-name.html."

property :repository_policy_text, [Hash, String],
         description: "The JSON repository policy text to apply to the repository. For more information, see https://docs.aws.amazon.com/AmazonECR/latest/userguide/RepositoryPolicyExamples.html in the Amazon Elastic Container Registry User Guide. "

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "An array of key-value pairs to apply to this resource."

# API URLs and mappings
rest_api_collection "/AWS::ECR::Repository"
rest_api_document "/AWS::ECR::Repository"

rest_property_map({
  encryption_configuration:     "EncryptionConfiguration",
  image_scanning_configuration: "ImageScanningConfiguration",
  image_tag_mutability:         "ImageTagMutability",
  lifecycle_policy:             "LifecyclePolicy",
  repository_name:              "RepositoryName",
  repository_policy_text:       "RepositoryPolicyText",
  tags:                         "Tags",
})

rest_post_only_properties %i{
  encryption_configuration encryption_configuration/encryption_type encryption_configuration/kms_key repository_name
}
