# Import API specifics
use "awscc_base"

resource_name :aws_work_spaces_web_browser_settings
provides :aws_work_spaces_web_browser_settings, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::WorkSpacesWeb::BrowserSettings Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :additional_encryption_context, Hash,
         callbacks: {
           "additional_encryption_context is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :browser_policy, String,
         callbacks: {
           "browser_policy is not a String" => lambda { |v| v.is_a? String },
           "browser_policy needs to be 2..131072 characters" => lambda { |v| v.length >= 2 && v.length <= 131072 },
           "browser_policy must match pattern \{[\S\s]*\}\s*" => lambda { |v| v =~ Regexp.new("/\{[\S\s]*\}\s*/") },
         },
         description: ""

property :customer_managed_key, String,
         callbacks: {
           "customer_managed_key is not a String" => lambda { |v| v.is_a? String },
           "customer_managed_key needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "customer_managed_key must match pattern ^arn:[\w+=\/,.@-]+:kms:[a-zA-Z0-9\-]*:[a-zA-Z0-9]{1,12}:key\/[a-zA-Z0-9-]+$" => lambda { |v| v =~ Regexp.new("/^arn:[\w+=\/,.@-]+:kms:[a-zA-Z0-9\-]*:[a-zA-Z0-9]{1,12}:key\/[a-zA-Z0-9-]+$/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::WorkSpacesWeb::BrowserSettings"
rest_api_document "/AWS::WorkSpacesWeb::BrowserSettings"

rest_property_map({
  additional_encryption_context: "AdditionalEncryptionContext",
  browser_policy:                "BrowserPolicy",
  customer_managed_key:          "CustomerManagedKey",
  tags:                          "Tags",
})

rest_post_only_properties %i{
  additional_encryption_context customer_managed_key
}
