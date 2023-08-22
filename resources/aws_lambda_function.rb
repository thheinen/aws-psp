# Import API specifics
use "awscc_base"

resource_name :aws_lambda_function
provides :aws_lambda_function, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Lambda::Function in region
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :architectures, Array,
         callbacks: {
           "architectures is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :code, Hash,
         required: true,
         callbacks: {
           "Subproperty `S3ObjectVersion` is not a String" => lambda { |v| v[:S3ObjectVersion].is_a? String },
           "Subproperty `S3ObjectVersion` needs to be 1..1024 characters" => lambda { |v| v[:S3ObjectVersion].length >= 1 && v[:S3ObjectVersion].length <= 1024 },
           "Subproperty `S3Bucket` is not a String" => lambda { |v| v[:S3Bucket].is_a? String },
           "Subproperty `S3Bucket` needs to be 3..63 characters" => lambda { |v| v[:S3Bucket].length >= 3 && v[:S3Bucket].length <= 63 },
           "Subproperty `S3Bucket` must match pattern ^[0-9A-Za-z\.\-_]*(?<!\.)$" => lambda { |v| v[:S3Bucket] =~ Regexp.new("/^[0-9A-Za-z\.\-_]*(?<!\.)$/") },
           "Subproperty `ZipFile` is not a String" => lambda { |v| v[:ZipFile].is_a? String },
           "Subproperty `S3Key` is not a String" => lambda { |v| v[:S3Key].is_a? String },
           "Subproperty `S3Key` needs to be 1..1024 characters" => lambda { |v| v[:S3Key].length >= 1 && v[:S3Key].length <= 1024 },
           "Subproperty `ImageUri` is not a String" => lambda { |v| v[:ImageUri].is_a? String },
         },
         description: <<~'DESCRIPTION'
           The code for the function.
         DESCRIPTION

property :code_signing_config_arn, String,
         callbacks: {
           "code_signing_config_arn is not a String" => lambda { |v| v.is_a? String },
           "code_signing_config_arn must match pattern arn:(aws[a-zA-Z-]*)?:lambda:[a-z]{2}((-gov)|(-iso(b?)))?-[a-z]+-\d{1}:\d{12}:code-signing-config:csc-[a-z0-9]{17}" => lambda { |v| v =~ Regexp.new("/arn:(aws[a-zA-Z-]*)?:lambda:[a-z]{2}((-gov)|(-iso(b?)))?-[a-z]+-\d{1}:\d{12}:code-signing-config:csc-[a-z0-9]{17}/") },
         },
         description: <<~'DESCRIPTION'
           A unique Arn for CodeSigningConfig resource
         DESCRIPTION

property :dead_letter_config, Hash,
         callbacks: {
           "Subproperty `TargetArn` is not a String" => lambda { |v| v[:TargetArn].is_a? String },
           "Subproperty `TargetArn` must match pattern ^(arn:(aws[a-zA-Z-]*)?:[a-z0-9-.]+:.*)|()$" => lambda { |v| v[:TargetArn] =~ Regexp.new("/^(arn:(aws[a-zA-Z-]*)?:[a-z0-9-.]+:.*)|()$/") },
           "Subproperty `TargetArn`is not a valid ARN" => lambda { |v| v[:TargetArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: <<~'DESCRIPTION'
           A dead letter queue configuration that specifies the queue or topic where Lambda sends asynchronous events when they fail processing.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A description of the function.
         DESCRIPTION

property :environment, Hash,
         callbacks: {
           "Subproperty `Variables` is not a Object" => lambda { |v| v[:Variables].is_a? Object },
         },
         description: <<~'DESCRIPTION'
           Environment variables that are accessible from function code during execution.
         DESCRIPTION

property :ephemeral_storage, Hash,
         callbacks: {
           "Subproperty `Size` is not a Integer" => lambda { |v| v[:Size].is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           A function's ephemeral storage settings.
         DESCRIPTION

property :file_system_configs, Array,
         callbacks: {
           "file_system_configs is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Connection settings for an Amazon EFS file system. To connect a function to a file system, a mount target must be available in every Availability Zone that your function connects to. If your template contains an AWS::EFS::MountTarget resource, you must also specify a DependsOn attribute to ensure that the mount target is created or updated before the function.
         DESCRIPTION

property :function_name, String,
         callbacks: {
           "function_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The name of the Lambda function, up to 64 characters in length. If you don't specify a name, AWS CloudFormation generates one.
         DESCRIPTION

property :handler, String,
         callbacks: {
           "handler is not a String" => lambda { |v| v.is_a? String },
           "handler must match pattern ^[^\s]+$" => lambda { |v| v =~ Regexp.new("/^[^\s]+$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the method within your code that Lambda calls to execute your function. The format includes the file name. It can also include namespaces and other qualifiers, depending on the runtime
         DESCRIPTION

property :image_config, Hash,
         callbacks: {
           "Subproperty `WorkingDirectory` is not a String" => lambda { |v| v[:WorkingDirectory].is_a? String },
           "Subproperty `Command` is not a Array" => lambda { |v| v[:Command].is_a? Array },
           "Subproperty `EntryPoint` is not a Array" => lambda { |v| v[:EntryPoint].is_a? Array },
         },
         description: <<~'DESCRIPTION'
           ImageConfig
         DESCRIPTION

property :kms_key_arn, String,
         callbacks: {
           "kms_key_arn is not a String" => lambda { |v| v.is_a? String },
           "kms_key_arn must match pattern ^(arn:(aws[a-zA-Z-]*)?:[a-z0-9-.]+:.*)|()$" => lambda { |v| v =~ Regexp.new("/^(arn:(aws[a-zA-Z-]*)?:[a-z0-9-.]+:.*)|()$/") },
         },
         description: <<~'DESCRIPTION'
           The ARN of the AWS Key Management Service (AWS KMS) key that's used to encrypt your function's environment variables. If it's not provided, AWS Lambda uses a default service key.
         DESCRIPTION

property :layers, Array,
         callbacks: {
           "layers is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of function layers to add to the function's execution environment. Specify each layer by its ARN, including the version.
         DESCRIPTION

property :memory_size, Integer,
         callbacks: {
           "memory_size is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The amount of memory that your function has access to. Increasing the function's memory also increases its CPU allocation. The default value is 128 MB. The value must be a multiple of 64 MB.
         DESCRIPTION

property :package_type, String,
         callbacks: {
           "package_type is not a String" => lambda { |v| v.is_a? String },
           "package_typeis not one of `Image`, `Zip`" => lambda { |v| %w{Image Zip}.include? v },
         },
         description: <<~'DESCRIPTION'
           PackageType.
         DESCRIPTION

property :reserved_concurrent_executions, Integer,
         callbacks: {
           "reserved_concurrent_executions is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of simultaneous executions to reserve for the function.
         DESCRIPTION

property :role, String,
         required: true,
         callbacks: {
           "role is not a String" => lambda { |v| v.is_a? String },
           "role must match pattern ^arn:(aws[a-zA-Z-]*)?:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+$" => lambda { |v| v =~ Regexp.new("/^arn:(aws[a-zA-Z-]*)?:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+$/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the function's execution role.
         DESCRIPTION

property :runtime, String,
         callbacks: {
           "runtime is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The identifier of the function's runtime.
         DESCRIPTION

property :runtime_management_config, Hash,
         callbacks: {
           "Subproperty `UpdateRuntimeOn` is not a String" => lambda { |v| v[:UpdateRuntimeOn].is_a? String },
           "Subproperty `UpdateRuntimeOn`is not one of `Auto`, `FunctionUpdate`, `Manual`" => lambda { |v| %w{Auto FunctionUpdate Manual}.include? v[:UpdateRuntimeOn] },
           "Subproperty `RuntimeVersionArn` is not a String" => lambda { |v| v[:RuntimeVersionArn].is_a? String },
           "Subproperty `RuntimeVersionArn`is not a valid ARN" => lambda { |v| v[:RuntimeVersionArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: <<~'DESCRIPTION'
           RuntimeManagementConfig
         DESCRIPTION

property :snap_start, Hash,
         callbacks: {
           "Subproperty `ApplyOn` is not a String" => lambda { |v| v[:ApplyOn].is_a? String },
           "Subproperty `ApplyOn`is not one of `PublishedVersions`, `None`" => lambda { |v| %w{PublishedVersions None}.include? v[:ApplyOn] },
         },
         description: <<~'DESCRIPTION'
           The SnapStart setting of your function
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of tags to apply to the function.
         DESCRIPTION

property :timeout, Integer,
         callbacks: {
           "timeout is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The amount of time that Lambda allows a function to run before stopping it. The default is 3 seconds. The maximum allowed value is 900 seconds.
         DESCRIPTION

property :tracing_config, Hash,
         callbacks: {
           "Subproperty `Mode` is not a String" => lambda { |v| v[:Mode].is_a? String },
           "Subproperty `Mode`is not one of `Active`, `PassThrough`" => lambda { |v| %w{Active PassThrough}.include? v[:Mode] },
         },
         description: <<~'DESCRIPTION'
           Set Mode to Active to sample and trace a subset of incoming requests with AWS X-Ray.
         DESCRIPTION

property :vpc_config, Hash,
         callbacks: {
           "Subproperty `SecurityGroupIds` is not a Array" => lambda { |v| v[:SecurityGroupIds].is_a? Array },
           "Subproperty `SubnetIds` is not a Array" => lambda { |v| v[:SubnetIds].is_a? Array },
         },
         description: <<~'DESCRIPTION'
           For network connectivity to AWS resources in a VPC, specify a list of security groups and subnets in the VPC.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Lambda::Function"
rest_api_document "/AWS::Lambda::Function"

rest_property_map({
  architectures:                  "Architectures",
  code:                           "Code",
  code_signing_config_arn:        "CodeSigningConfigArn",
  dead_letter_config:             "DeadLetterConfig",
  description:                    "Description",
  environment:                    "Environment",
  ephemeral_storage:              "EphemeralStorage",
  file_system_configs:            "FileSystemConfigs",
  function_name:                  "FunctionName",
  handler:                        "Handler",
  image_config:                   "ImageConfig",
  kms_key_arn:                    "KmsKeyArn",
  layers:                         "Layers",
  memory_size:                    "MemorySize",
  package_type:                   "PackageType",
  reserved_concurrent_executions: "ReservedConcurrentExecutions",
  role:                           "Role",
  runtime:                        "Runtime",
  runtime_management_config:      "RuntimeManagementConfig",
  snap_start:                     "SnapStart",
  tags:                           "Tags",
  timeout:                        "Timeout",
  tracing_config:                 "TracingConfig",
  vpc_config:                     "VpcConfig",
})

rest_post_only_properties %i{
  function_name
}
