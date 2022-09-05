# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_iam_server_certificate
provides :aws_iam_server_certificate, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::IAM::ServerCertificate
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :certificate_body, String,
         callbacks: {
           "certificate_body is not a String" => lambda { |v| v.is_a? String },
           "certificate_body needs to be 1..16384 characters" => lambda { |v| v.length >= 1 && v.length <= 16384 },
           "certificate_body must match pattern [\u0009\u000A\u000D\u0020-\u00FF]+" => lambda { |v| v =~ Regexp.new("/[\u0009\u000A\u000D\u0020-\u00FF]+/") },
         },
         description: ""

property :certificate_chain, String,
         callbacks: {
           "certificate_chain is not a String" => lambda { |v| v.is_a? String },
           "certificate_chain needs to be 1..2097152 characters" => lambda { |v| v.length >= 1 && v.length <= 2097152 },
           "certificate_chain must match pattern [\u0009\u000A\u000D\u0020-\u00FF]+" => lambda { |v| v =~ Regexp.new("/[\u0009\u000A\u000D\u0020-\u00FF]+/") },
         },
         description: ""

property :path, String,
         callbacks: {
           "path is not a String" => lambda { |v| v.is_a? String },
           "path needs to be 1..512 characters" => lambda { |v| v.length >= 1 && v.length <= 512 },
           "path must match pattern (\u002F)|(\u002F[\u0021-\u007F]+\u002F)" => lambda { |v| v =~ Regexp.new("/(\u002F)|(\u002F[\u0021-\u007F]+\u002F)/") },
         },
         description: ""

property :private_key, String,
         callbacks: {
           "private_key is not a String" => lambda { |v| v.is_a? String },
           "private_key needs to be 1..16384 characters" => lambda { |v| v.length >= 1 && v.length <= 16384 },
           "private_key must match pattern [\u0009\u000A\u000D\u0020-\u00FF]+" => lambda { |v| v =~ Regexp.new("/[\u0009\u000A\u000D\u0020-\u00FF]+/") },
         },
         description: ""

property :server_certificate_name, String,
         callbacks: {
           "server_certificate_name is not a String" => lambda { |v| v.is_a? String },
           "server_certificate_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "server_certificate_name must match pattern [\w+=,.@-]+" => lambda { |v| v =~ Regexp.new("/[\w+=,.@-]+/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::IAM::ServerCertificate"
rest_api_document "/AWS::IAM::ServerCertificate"

rest_property_map({
  certificate_body:        "CertificateBody",
  certificate_chain:       "CertificateChain",
  path:                    "Path",
  private_key:             "PrivateKey",
  server_certificate_name: "ServerCertificateName",
  tags:                    "Tags",
})

rest_post_only_properties %i{
  certificate_body certificate_chain private_key server_certificate_name
}
