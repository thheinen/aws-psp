# Import API specifics
use "awscc_base"

resource_name :aws_sagemaker_image_version
provides :aws_sagemaker_image_version, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SageMaker::ImageVersion
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :alias, Hash,
         callbacks: {
           "alias is not a String" => lambda { |v| v.is_a? String },
           "alias needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "alias must match pattern (?!^[.-])^([a-zA-Z0-9-_.]+)$" => lambda { |v| v =~ Regexp.new("/(?!^[.-])^([a-zA-Z0-9-_.]+)$/") },
         },
         description: ""

property :aliases, Hash,
         callbacks: {
           "aliases is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :base_image, Hash,
         required: true,
         callbacks: {
           "base_image is not a String" => lambda { |v| v.is_a? String },
           "base_image needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "base_image must match pattern .+" => lambda { |v| v =~ Regexp.new("/.+/") },
         },
         description: ""

property :horovod, Hash,
         callbacks: {
           "horovod is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: ""

property :image_name, Hash,
         required: true,
         callbacks: {
           "image_name is not a String" => lambda { |v| v.is_a? String },
           "image_name needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
           "image_name must match pattern ^[A-Za-z0-9]([-.]?[A-Za-z0-9])*$" => lambda { |v| v =~ Regexp.new("/^[A-Za-z0-9]([-.]?[A-Za-z0-9])*$/") },
         },
         description: ""

property :job_type, Hash,
         callbacks: {
           "job_type is not a String" => lambda { |v| v.is_a? String },
           "job_typeis not one of `TRAINING`, `INFERENCE`, `NOTEBOOK_KERNEL`" => lambda { |v| %w{TRAINING INFERENCE NOTEBOOK_KERNEL}.include? v },
         },
         description: ""

property :ml_framework, Hash,
         callbacks: {
           "ml_framework is not a String" => lambda { |v| v.is_a? String },
           "ml_framework needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "ml_framework must match pattern ^[a-zA-Z]+ ?\d+\.\d+(\.\d+)?$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z]+ ?\d+\.\d+(\.\d+)?$/") },
         },
         description: ""

property :processor, Hash,
         callbacks: {
           "processor is not a String" => lambda { |v| v.is_a? String },
           "processoris not one of `CPU`, `GPU`" => lambda { |v| %w{CPU GPU}.include? v },
         },
         description: ""

property :programming_lang, Hash,
         callbacks: {
           "programming_lang is not a String" => lambda { |v| v.is_a? String },
           "programming_lang needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "programming_lang must match pattern ^[a-zA-Z]+ ?\d+\.\d+(\.\d+)?$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z]+ ?\d+\.\d+(\.\d+)?$/") },
         },
         description: ""

property :release_notes, Hash,
         callbacks: {
           "release_notes is not a String" => lambda { |v| v.is_a? String },
           "release_notes needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "release_notes must match pattern .*" => lambda { |v| v =~ Regexp.new("/.*/") },
         },
         description: ""

property :vendor_guidance, Hash,
         callbacks: {
           "vendor_guidance is not a String" => lambda { |v| v.is_a? String },
           "vendor_guidanceis not one of `NOT_PROVIDED`, `STABLE`, `TO_BE_ARCHIVED`, `ARCHIVED`" => lambda { |v| %w{NOT_PROVIDED STABLE TO_BE_ARCHIVED ARCHIVED}.include? v },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::SageMaker::ImageVersion"
rest_api_document "/AWS::SageMaker::ImageVersion"

rest_property_map({
  alias:            "Alias",
  aliases:          "Aliases",
  base_image:       "BaseImage",
  horovod:          "Horovod",
  image_name:       "ImageName",
  job_type:         "JobType",
  ml_framework:     "MLFramework",
  processor:        "Processor",
  programming_lang: "ProgrammingLang",
  release_notes:    "ReleaseNotes",
  vendor_guidance:  "VendorGuidance",
})

rest_post_only_properties %i{
  base_image image_name
}
