# Import API specifics
use "awscc_base"

resource_name :aws_work_spaces_web_ip_access_settings
provides :aws_work_spaces_web_ip_access_settings, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::WorkSpacesWeb::IpAccessSettings Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :additional_encryption_context, Hash,
         callbacks: {
           "additional_encryption_context is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :customer_managed_key, String,
         callbacks: {
           "customer_managed_key is not a String" => lambda { |v| v.is_a? String },
           "customer_managed_key needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "customer_managed_key must match pattern ^arn:[\w+=\/,.@-]+:kms:[a-zA-Z0-9\-]*:[a-zA-Z0-9]{1,12}:key\/[a-zA-Z0-9-]+$" => lambda { |v| v =~ Regexp.new("/^arn:[\w+=\/,.@-]+:kms:[a-zA-Z0-9\-]*:[a-zA-Z0-9]{1,12}:key\/[a-zA-Z0-9-]+$/") },
         },
         description: ""

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "description must match pattern ^.+$" => lambda { |v| v =~ Regexp.new("/^.+$/") },
         },
         description: ""

property :display_name, String,
         callbacks: {
           "display_name is not a String" => lambda { |v| v.is_a? String },
           "display_name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "display_name must match pattern ^.+$" => lambda { |v| v =~ Regexp.new("/^.+$/") },
         },
         description: ""

property :ip_rules, Array,
         required: true,
         callbacks: {
           "ip_rules is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::WorkSpacesWeb::IpAccessSettings"
rest_api_document "/AWS::WorkSpacesWeb::IpAccessSettings"

rest_property_map({
  additional_encryption_context: "AdditionalEncryptionContext",
  customer_managed_key:          "CustomerManagedKey",
  description:                   "Description",
  display_name:                  "DisplayName",
  ip_rules:                      "IpRules",
  tags:                          "Tags",
})

rest_post_only_properties %i{
  additional_encryption_context customer_managed_key
}
