# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_config_organization_conformance_pack
provides :aws_config_organization_conformance_pack, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::Config::OrganizationConformancePack.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :conformance_pack_input_parameters, Array,
         callbacks: {
           "conformance_pack_input_parameters is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of ConformancePackInputParameter objects.
         DESCRIPTION

property :delivery_s3_bucket, String,
         callbacks: {
           "delivery_s3_bucket is not a String" => lambda { |v| v.is_a? String },
           "delivery_s3_bucket needs to be 0..63 characters" => lambda { |v| v.length >= 0 && v.length <= 63 },
         },
         description: <<~'DESCRIPTION'
           AWS Config stores intermediate files while processing conformance pack template.
         DESCRIPTION

property :delivery_s3_key_prefix, String,
         callbacks: {
           "delivery_s3_key_prefix is not a String" => lambda { |v| v.is_a? String },
           "delivery_s3_key_prefix needs to be 0..1024 characters" => lambda { |v| v.length >= 0 && v.length <= 1024 },
         },
         description: <<~'DESCRIPTION'
           The prefix for the delivery S3 bucket.
         DESCRIPTION

property :excluded_accounts, Array,
         callbacks: {
           "excluded_accounts is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of AWS accounts to be excluded from an organization conformance pack while deploying a conformance pack.
         DESCRIPTION

property :organization_conformance_pack_name, String,
         required: true,
         callbacks: {
           "organization_conformance_pack_name is not a String" => lambda { |v| v.is_a? String },
           "organization_conformance_pack_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "organization_conformance_pack_name must match pattern [a-zA-Z][-a-zA-Z0-9]*" => lambda { |v| v =~ Regexp.new("/[a-zA-Z][-a-zA-Z0-9]*/") },
         },
         description: <<~'DESCRIPTION'
           The name of the organization conformance pack.
         DESCRIPTION

property :template_body, String,
         callbacks: {
           "template_body is not a String" => lambda { |v| v.is_a? String },
           "template_body needs to be 1..51200 characters" => lambda { |v| v.length >= 1 && v.length <= 51200 },
         },
         description: <<~'DESCRIPTION'
           A string containing full conformance pack template body.
         DESCRIPTION

property :template_s3_uri, String,
         callbacks: {
           "template_s3_uri is not a String" => lambda { |v| v.is_a? String },
           "template_s3_uri needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
           "template_s3_uri must match pattern s3://.*" => lambda { |v| v =~ Regexp.new("/s3://.*/") },
         },
         description: <<~'DESCRIPTION'
           Location of file containing the template body.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Config::OrganizationConformancePack"
rest_api_document "/AWS::Config::OrganizationConformancePack"

rest_property_map({
  conformance_pack_input_parameters:  "ConformancePackInputParameters",
  delivery_s3_bucket:                 "DeliveryS3Bucket",
  delivery_s3_key_prefix:             "DeliveryS3KeyPrefix",
  excluded_accounts:                  "ExcludedAccounts",
  organization_conformance_pack_name: "OrganizationConformancePackName",
  template_body:                      "TemplateBody",
  template_s3_uri:                    "TemplateS3Uri",
})

rest_post_only_properties %i{
  organization_conformance_pack_name
}
