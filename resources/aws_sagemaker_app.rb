# Import API specifics
use "awscc_base"

resource_name :aws_sagemaker_app
provides :aws_sagemaker_app, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SageMaker::App
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :app_name, String,
         required: true,
         callbacks: {
           "app_name is not a String" => lambda { |v| v.is_a? String },
           "app_name needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
           "app_name must match pattern ^[a-zA-Z0-9](-*[a-zA-Z0-9]){0,62}" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9](-*[a-zA-Z0-9]){0,62}/") },
         },
         description: "The name of the app."

property :app_type, String,
         required: true,
         callbacks: {
           "app_type is not a String" => lambda { |v| v.is_a? String },
           "app_typeis not one of `JupyterServer`, `KernelGateway`, `RStudioServerPro`, `RSessionGateway`, `Canvas`" => lambda { |v| %w{JupyterServer KernelGateway RStudioServerPro RSessionGateway Canvas}.include? v },
         },
         description: "The type of app."

property :domain_id, String,
         required: true,
         callbacks: {
           "domain_id is not a String" => lambda { |v| v.is_a? String },
           "domain_id needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
         },
         description: "The domain ID."

property :resource_spec, Hash,
         callbacks: {
           "Subproperty `InstanceType` is not a String" => lambda { |v| v[:InstanceType].is_a? String },
           "Subproperty `InstanceType`is not one of `system`, `ml.t3.micro`, `ml.t3.small`, `ml.t3.medium`, `ml.t3.large`, `ml.t3.xlarge`, `ml.t3.2xlarge`, `ml.m5.large`, `ml.m5.xlarge`, `ml.m5.2xlarge`, `ml.m5.4xlarge`, `ml.m5.8xlarge`, `ml.m5.12xlarge`, `ml.m5.16xlarge`, `ml.m5.24xlarge`, `ml.c5.large`, `ml.c5.xlarge`, `ml.c5.2xlarge`, `ml.c5.4xlarge`, `ml.c5.9xlarge`, `ml.c5.12xlarge`, `ml.c5.18xlarge`, `ml.c5.24xlarge`, `ml.p3.2xlarge`, `ml.p3.8xlarge`, `ml.p3.16xlarge`, `ml.g4dn.xlarge`, `ml.g4dn.2xlarge`, `ml.g4dn.4xlarge`, `ml.g4dn.8xlarge`, `ml.g4dn.12xlarge`, `ml.g4dn.16xlarge`, `ml.r5.large`, `ml.r5.xlarge`, `ml.r5.2xlarge`, `ml.r5.4xlarge`, `ml.r5.8xlarge`, `ml.r5.12xlarge`, `ml.r5.16xlarge`, `ml.r5.24xlarge`, `ml.p3dn.24xlarge`, `ml.m5d.large`, `ml.m5d.xlarge`, `ml.m5d.2xlarge`, `ml.m5d.4xlarge`, `ml.m5d.8xlarge`, `ml.m5d.12xlarge`, `ml.m5d.16xlarge`, `ml.m5d.24xlarge`, `ml.g5.xlarge`, `ml.g5.2xlarge`, `ml.g5.4xlarge`, `ml.g5.8xlarge`, `ml.g5.12xlarge`, `ml.g5.16xlarge`, `ml.g5.24xlarge`, `ml.g5.48xlarge`" => lambda { |v| %w{system ml.t3.micro ml.t3.small ml.t3.medium ml.t3.large ml.t3.xlarge ml.t3.2xlarge ml.m5.large ml.m5.xlarge ml.m5.2xlarge ml.m5.4xlarge ml.m5.8xlarge ml.m5.12xlarge ml.m5.16xlarge ml.m5.24xlarge ml.c5.large ml.c5.xlarge ml.c5.2xlarge ml.c5.4xlarge ml.c5.9xlarge ml.c5.12xlarge ml.c5.18xlarge ml.c5.24xlarge ml.p3.2xlarge ml.p3.8xlarge ml.p3.16xlarge ml.g4dn.xlarge ml.g4dn.2xlarge ml.g4dn.4xlarge ml.g4dn.8xlarge ml.g4dn.12xlarge ml.g4dn.16xlarge ml.r5.large ml.r5.xlarge ml.r5.2xlarge ml.r5.4xlarge ml.r5.8xlarge ml.r5.12xlarge ml.r5.16xlarge ml.r5.24xlarge ml.p3dn.24xlarge ml.m5d.large ml.m5d.xlarge ml.m5d.2xlarge ml.m5d.4xlarge ml.m5d.8xlarge ml.m5d.12xlarge ml.m5d.16xlarge ml.m5d.24xlarge ml.g5.xlarge ml.g5.2xlarge ml.g5.4xlarge ml.g5.8xlarge ml.g5.12xlarge ml.g5.16xlarge ml.g5.24xlarge ml.g5.48xlarge}.include? v[:InstanceType] },
           "Subproperty `SageMakerImageArn` is not a String" => lambda { |v| v[:SageMakerImageArn].is_a? String },
           "Subproperty `SageMakerImageArn` needs to be 1..256 characters" => lambda { |v| v[:SageMakerImageArn].length >= 1 && v[:SageMakerImageArn].length <= 256 },
           "Subproperty `SageMakerImageArn` must match pattern ^arn:aws(-[\w]+)*:sagemaker:.+:[0-9]{12}:image/[a-z0-9]([-.]?[a-z0-9])*$" => lambda { |v| v[:SageMakerImageArn] =~ Regexp.new("/^arn:aws(-[\w]+)*:sagemaker:.+:[0-9]{12}:image/[a-z0-9]([-.]?[a-z0-9])*$/") },
           "Subproperty `SageMakerImageArn`is not a valid ARN" => lambda { |v| v[:SageMakerImageArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `SageMakerImageVersionArn` is not a String" => lambda { |v| v[:SageMakerImageVersionArn].is_a? String },
           "Subproperty `SageMakerImageVersionArn` needs to be 1..256 characters" => lambda { |v| v[:SageMakerImageVersionArn].length >= 1 && v[:SageMakerImageVersionArn].length <= 256 },
           "Subproperty `SageMakerImageVersionArn` must match pattern ^arn:aws(-[\w]+)*:sagemaker:.+:[0-9]{12}:image-version/[a-z0-9]([-.]?[a-z0-9])*/[0-9]+$" => lambda { |v| v[:SageMakerImageVersionArn] =~ Regexp.new("/^arn:aws(-[\w]+)*:sagemaker:.+:[0-9]{12}:image-version/[a-z0-9]([-.]?[a-z0-9])*/[0-9]+$/") },
           "Subproperty `SageMakerImageVersionArn`is not a valid ARN" => lambda { |v| v[:SageMakerImageVersionArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: "The instance type and the Amazon Resource Name (ARN) of the SageMaker image created on the instance."

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "A list of tags to apply to the app."

property :user_profile_name, String,
         required: true,
         callbacks: {
           "user_profile_name is not a String" => lambda { |v| v.is_a? String },
           "user_profile_name needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
           "user_profile_name must match pattern ^[a-zA-Z0-9](-*[a-zA-Z0-9]){0,62}" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9](-*[a-zA-Z0-9]){0,62}/") },
         },
         description: "The user profile name."

# API URLs and mappings
rest_api_collection "/AWS::SageMaker::App"
rest_api_document "/AWS::SageMaker::App"

rest_property_map({
  app_name:          "AppName",
  app_type:          "AppType",
  domain_id:         "DomainId",
  resource_spec:     "ResourceSpec",
  tags:              "Tags",
  user_profile_name: "UserProfileName",
})

rest_post_only_properties %i{
  app_name app_type domain_id tags user_profile_name
}
