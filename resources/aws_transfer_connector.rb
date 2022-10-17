# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_transfer_connector
provides :aws_transfer_connector, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Transfer::Connector
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :access_role, String,
         required: true,
         callbacks: {
           "access_role is not a String" => lambda { |v| v.is_a? String },
           "access_role needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "access_role must match pattern arn:.*role/.*" => lambda { |v| v =~ Regexp.new("/arn:.*role/.*/") },
         },
         description: <<~'DESCRIPTION'
           Specifies the access role for the connector.
         DESCRIPTION

property :as2_config, Hash,
         required: true,
         callbacks: {
           "Subproperty `LocalProfileId` is not a String" => lambda { |v| v[:LocalProfileId].is_a? String },
           "Subproperty `LocalProfileId` needs to be 19..19 characters" => lambda { |v| v[:LocalProfileId].length >= 19 && v[:LocalProfileId].length <= 19 },
           "Subproperty `LocalProfileId` must match pattern ^p-([0-9a-f]{17})$" => lambda { |v| v[:LocalProfileId] =~ Regexp.new("/^p-([0-9a-f]{17})$/") },
           "Subproperty `PartnerProfileId` is not a String" => lambda { |v| v[:PartnerProfileId].is_a? String },
           "Subproperty `PartnerProfileId` needs to be 19..19 characters" => lambda { |v| v[:PartnerProfileId].length >= 19 && v[:PartnerProfileId].length <= 19 },
           "Subproperty `PartnerProfileId` must match pattern ^p-([0-9a-f]{17})$" => lambda { |v| v[:PartnerProfileId] =~ Regexp.new("/^p-([0-9a-f]{17})$/") },
           "Subproperty `MessageSubject` is not a String" => lambda { |v| v[:MessageSubject].is_a? String },
           "Subproperty `MessageSubject` needs to be 1..1024 characters" => lambda { |v| v[:MessageSubject].length >= 1 && v[:MessageSubject].length <= 1024 },
           "Subproperty `MessageSubject` must match pattern ^[\p{Print}\p{Blank}]+" => lambda { |v| v[:MessageSubject] =~ Regexp.new("/^[\p{Print}\p{Blank}]+/") },
           "Subproperty `Compression` is not a String" => lambda { |v| v[:Compression].is_a? String },
           "Subproperty `Compression`is not one of `ZLIB`, `DISABLED`" => lambda { |v| %w{ZLIB DISABLED}.include? v[:Compression] },
           "Subproperty `EncryptionAlgorithm` is not a String" => lambda { |v| v[:EncryptionAlgorithm].is_a? String },
           "Subproperty `EncryptionAlgorithm`is not one of `AES128_CBC`, `AES192_CBC`, `AES256_CBC`" => lambda { |v| %w{AES128_CBC AES192_CBC AES256_CBC}.include? v[:EncryptionAlgorithm] },
           "Subproperty `SigningAlgorithm` is not a String" => lambda { |v| v[:SigningAlgorithm].is_a? String },
           "Subproperty `SigningAlgorithm`is not one of `SHA256`, `SHA384`, `SHA512`, `SHA1`, `NONE`" => lambda { |v| %w{SHA256 SHA384 SHA512 SHA1 NONE}.include? v[:SigningAlgorithm] },
           "Subproperty `MdnSigningAlgorithm` is not a String" => lambda { |v| v[:MdnSigningAlgorithm].is_a? String },
           "Subproperty `MdnSigningAlgorithm`is not one of `SHA256`, `SHA384`, `SHA512`, `SHA1`, `NONE`, `DEFAULT`" => lambda { |v| %w{SHA256 SHA384 SHA512 SHA1 NONE DEFAULT}.include? v[:MdnSigningAlgorithm] },
           "Subproperty `MdnResponse` is not a String" => lambda { |v| v[:MdnResponse].is_a? String },
           "Subproperty `MdnResponse`is not one of `SYNC`, `NONE`" => lambda { |v| %w{SYNC NONE}.include? v[:MdnResponse] },
         },
         description: <<~'DESCRIPTION'
           Configuration for an AS2 connector.
         DESCRIPTION

property :logging_role, String,
         callbacks: {
           "logging_role is not a String" => lambda { |v| v.is_a? String },
           "logging_role needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "logging_role must match pattern arn:.*role/.*" => lambda { |v| v =~ Regexp.new("/arn:.*role/.*/") },
         },
         description: <<~'DESCRIPTION'
           Specifies the logging role for the connector.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Key-value pairs that can be used to group and search for workflows. Tags are metadata attached to workflows for any purpose.
         DESCRIPTION

property :url, String,
         required: true,
         callbacks: {
           "url is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           URL for Connector
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Transfer::Connector"
rest_api_document "/AWS::Transfer::Connector"

rest_property_map({
  access_role:  "AccessRole",
  as2_config:   "As2Config",
  logging_role: "LoggingRole",
  tags:         "Tags",
  url:          "Url",
})

