# Import API specifics
use "awscc_base"

resource_name :aws_work_spaces_web_portal
provides :aws_work_spaces_web_portal, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::WorkSpacesWeb::Portal Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :additional_encryption_context, Hash,
         callbacks: {
           "additional_encryption_context is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

property :authentication_type, Hash,
         callbacks: {
           "authentication_type is not a String" => lambda { |v| v.is_a? String },
           "authentication_typeis not one of `Standard`, `IAM_Identity_Center`" => lambda { |v| %w{Standard IAM_Identity_Center}.include? v },
         },
         description: ""

property :browser_settings_arn, String,
         callbacks: {
           "browser_settings_arn is not a String" => lambda { |v| v.is_a? String },
           "browser_settings_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "browser_settings_arn must match pattern ^arn:[\w+=\/,.@-]+:[a-zA-Z0-9\-]+:[a-zA-Z0-9\-]*:[a-zA-Z0-9]{1,12}:[a-zA-Z]+(\/[a-fA-F0-9\-]{36})+$" => lambda { |v| v =~ Regexp.new("/^arn:[\w+=\/,.@-]+:[a-zA-Z0-9\-]+:[a-zA-Z0-9\-]*:[a-zA-Z0-9]{1,12}:[a-zA-Z]+(\/[a-fA-F0-9\-]{36})+$/") },
         },
         description: ""

property :customer_managed_key, String,
         callbacks: {
           "customer_managed_key is not a String" => lambda { |v| v.is_a? String },
           "customer_managed_key needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "customer_managed_key must match pattern ^arn:[\w+=\/,.@-]+:kms:[a-zA-Z0-9\-]*:[a-zA-Z0-9]{1,12}:key\/[a-zA-Z0-9-]+$" => lambda { |v| v =~ Regexp.new("/^arn:[\w+=\/,.@-]+:kms:[a-zA-Z0-9\-]*:[a-zA-Z0-9]{1,12}:key\/[a-zA-Z0-9-]+$/") },
         },
         description: ""

property :display_name, String,
         callbacks: {
           "display_name is not a String" => lambda { |v| v.is_a? String },
           "display_name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "display_name must match pattern ^.+$" => lambda { |v| v =~ Regexp.new("/^.+$/") },
         },
         description: ""

property :ip_access_settings_arn, String,
         callbacks: {
           "ip_access_settings_arn is not a String" => lambda { |v| v.is_a? String },
           "ip_access_settings_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "ip_access_settings_arn must match pattern ^arn:[\w+=\/,.@-]+:[a-zA-Z0-9\-]+:[a-zA-Z0-9\-]*:[a-zA-Z0-9]{1,12}:[a-zA-Z]+(\/[a-fA-F0-9\-]{36})+$" => lambda { |v| v =~ Regexp.new("/^arn:[\w+=\/,.@-]+:[a-zA-Z0-9\-]+:[a-zA-Z0-9\-]*:[a-zA-Z0-9]{1,12}:[a-zA-Z]+(\/[a-fA-F0-9\-]{36})+$/") },
         },
         description: ""

property :network_settings_arn, String,
         callbacks: {
           "network_settings_arn is not a String" => lambda { |v| v.is_a? String },
           "network_settings_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "network_settings_arn must match pattern ^arn:[\w+=\/,.@-]+:[a-zA-Z0-9\-]+:[a-zA-Z0-9\-]*:[a-zA-Z0-9]{1,12}:[a-zA-Z]+(\/[a-fA-F0-9\-]{36})+$" => lambda { |v| v =~ Regexp.new("/^arn:[\w+=\/,.@-]+:[a-zA-Z0-9\-]+:[a-zA-Z0-9\-]*:[a-zA-Z0-9]{1,12}:[a-zA-Z]+(\/[a-fA-F0-9\-]{36})+$/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :trust_store_arn, String,
         callbacks: {
           "trust_store_arn is not a String" => lambda { |v| v.is_a? String },
           "trust_store_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "trust_store_arn must match pattern ^arn:[\w+=\/,.@-]+:[a-zA-Z0-9\-]+:[a-zA-Z0-9\-]*:[a-zA-Z0-9]{1,12}:[a-zA-Z]+(\/[a-fA-F0-9\-]{36})+$" => lambda { |v| v =~ Regexp.new("/^arn:[\w+=\/,.@-]+:[a-zA-Z0-9\-]+:[a-zA-Z0-9\-]*:[a-zA-Z0-9]{1,12}:[a-zA-Z]+(\/[a-fA-F0-9\-]{36})+$/") },
         },
         description: ""

property :user_access_logging_settings_arn, String,
         callbacks: {
           "user_access_logging_settings_arn is not a String" => lambda { |v| v.is_a? String },
           "user_access_logging_settings_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "user_access_logging_settings_arn must match pattern ^arn:[\w+=\/,.@-]+:[a-zA-Z0-9\-]+:[a-zA-Z0-9\-]*:[a-zA-Z0-9]{1,12}:[a-zA-Z]+(\/[a-fA-F0-9\-]{36})+$" => lambda { |v| v =~ Regexp.new("/^arn:[\w+=\/,.@-]+:[a-zA-Z0-9\-]+:[a-zA-Z0-9\-]*:[a-zA-Z0-9]{1,12}:[a-zA-Z]+(\/[a-fA-F0-9\-]{36})+$/") },
         },
         description: ""

property :user_settings_arn, String,
         callbacks: {
           "user_settings_arn is not a String" => lambda { |v| v.is_a? String },
           "user_settings_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "user_settings_arn must match pattern ^arn:[\w+=\/,.@-]+:[a-zA-Z0-9\-]+:[a-zA-Z0-9\-]*:[a-zA-Z0-9]{1,12}:[a-zA-Z]+(\/[a-fA-F0-9\-]{36})+$" => lambda { |v| v =~ Regexp.new("/^arn:[\w+=\/,.@-]+:[a-zA-Z0-9\-]+:[a-zA-Z0-9\-]*:[a-zA-Z0-9]{1,12}:[a-zA-Z]+(\/[a-fA-F0-9\-]{36})+$/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::WorkSpacesWeb::Portal"
rest_api_document "/AWS::WorkSpacesWeb::Portal"

rest_property_map({
  additional_encryption_context:    "AdditionalEncryptionContext",
  authentication_type:              "AuthenticationType",
  browser_settings_arn:             "BrowserSettingsArn",
  customer_managed_key:             "CustomerManagedKey",
  display_name:                     "DisplayName",
  ip_access_settings_arn:           "IpAccessSettingsArn",
  network_settings_arn:             "NetworkSettingsArn",
  tags:                             "Tags",
  trust_store_arn:                  "TrustStoreArn",
  user_access_logging_settings_arn: "UserAccessLoggingSettingsArn",
  user_settings_arn:                "UserSettingsArn",
})

rest_post_only_properties %i{
  additional_encryption_context customer_managed_key
}
