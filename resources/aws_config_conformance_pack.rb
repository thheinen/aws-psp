# Import API specifics
use "awscc_base"

resource_name :aws_config_conformance_pack
provides :aws_config_conformance_pack, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  A conformance pack is a collection of AWS Config rules and remediation actions that can be easily deployed as a single entity in an account and a region or across an entire AWS Organization.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :conformance_pack_input_parameters, Array,
         callbacks: {
           "conformance_pack_input_parameters is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "A list of ConformancePackInputParameter objects."

property :conformance_pack_name, String,
         required: true,
         callbacks: {
           "conformance_pack_name is not a String" => lambda { |v| v.is_a? String },
           "conformance_pack_name needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "conformance_pack_name must match pattern [a-zA-Z][-a-zA-Z0-9]*" => lambda { |v| v =~ Regexp.new("/[a-zA-Z][-a-zA-Z0-9]*/") },
         },
         description: "Name of the conformance pack which will be assigned as the unique identifier."

property :delivery_s3_bucket, String,
         callbacks: {
           "delivery_s3_bucket is not a String" => lambda { |v| v.is_a? String },
           "delivery_s3_bucket needs to be 0..63 characters" => lambda { |v| v.length >= 0 && v.length <= 63 },
         },
         description: "AWS Config stores intermediate files while processing conformance pack template."

property :delivery_s3_key_prefix, String,
         callbacks: {
           "delivery_s3_key_prefix is not a String" => lambda { |v| v.is_a? String },
           "delivery_s3_key_prefix needs to be 0..1024 characters" => lambda { |v| v.length >= 0 && v.length <= 1024 },
         },
         description: "The prefix for delivery S3 bucket."

property :template_body, String,
         callbacks: {
           "template_body is not a String" => lambda { |v| v.is_a? String },
           "template_body needs to be 1..51200 characters" => lambda { |v| v.length >= 1 && v.length <= 51200 },
         },
         description: "A string containing full conformance pack template body. You can only specify one of the template body or template S3Uri fields."

property :template_s3_uri, String,
         callbacks: {
           "template_s3_uri is not a String" => lambda { |v| v.is_a? String },
           "template_s3_uri needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
           "template_s3_uri must match pattern s3://.*" => lambda { |v| v =~ Regexp.new("/s3://.*/") },
         },
         description: "Location of file containing the template body which points to the conformance pack template that is located in an Amazon S3 bucket. You can only specify one of the template body or template S3Uri fields."

property :template_ssm_document_details, Hash,
         callbacks: {
           "Subproperty `DocumentName` is not a String" => lambda { |v| v[:DocumentName].is_a? String },
           "Subproperty `DocumentName` needs to be 3..128 characters" => lambda { |v| v[:DocumentName].length >= 3 && v[:DocumentName].length <= 128 },
           "Subproperty `DocumentVersion` is not a String" => lambda { |v| v[:DocumentVersion].is_a? String },
           "Subproperty `DocumentVersion` needs to be 1..128 characters" => lambda { |v| v[:DocumentVersion].length >= 1 && v[:DocumentVersion].length <= 128 },
         },
         description: "The TemplateSSMDocumentDetails object contains the name of the SSM document and the version of the SSM document."

# API URLs and mappings
rest_api_collection "/AWS::Config::ConformancePack"
rest_api_document "/AWS::Config::ConformancePack"

rest_property_map({
  conformance_pack_input_parameters: "ConformancePackInputParameters",
  conformance_pack_name:             "ConformancePackName",
  delivery_s3_bucket:                "DeliveryS3Bucket",
  delivery_s3_key_prefix:            "DeliveryS3KeyPrefix",
  template_body:                     "TemplateBody",
  template_s3_uri:                   "TemplateS3Uri",
  template_ssm_document_details:     "TemplateSSMDocumentDetails",
})

rest_post_only_properties %i{
  conformance_pack_name
}
