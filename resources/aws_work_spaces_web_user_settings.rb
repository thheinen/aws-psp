# Import API specifics
use "awscc_base"

resource_name :aws_work_spaces_web_user_settings
provides :aws_work_spaces_web_user_settings, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::WorkSpacesWeb::UserSettings Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :copy_allowed, Hash,
         required: true,
         callbacks: {
           "copy_allowed is not a String" => lambda { |v| v.is_a? String },
           "copy_allowedis not one of `Disabled`, `Enabled`" => lambda { |v| %w{Disabled Enabled}.include? v },
         },
         description: ""

property :disconnect_timeout_in_minutes, Number,
         callbacks: {
           "disconnect_timeout_in_minutes is not a Number" => lambda { |v| v.is_a? Number },
         },
         description: ""

property :download_allowed, Hash,
         required: true,
         callbacks: {
           "download_allowed is not a String" => lambda { |v| v.is_a? String },
           "download_allowedis not one of `Disabled`, `Enabled`" => lambda { |v| %w{Disabled Enabled}.include? v },
         },
         description: ""

property :idle_disconnect_timeout_in_minutes, Number,
         callbacks: {
           "idle_disconnect_timeout_in_minutes is not a Number" => lambda { |v| v.is_a? Number },
         },
         description: ""

property :paste_allowed, Hash,
         required: true,
         callbacks: {
           "paste_allowed is not a String" => lambda { |v| v.is_a? String },
           "paste_allowedis not one of `Disabled`, `Enabled`" => lambda { |v| %w{Disabled Enabled}.include? v },
         },
         description: ""

property :print_allowed, Hash,
         required: true,
         callbacks: {
           "print_allowed is not a String" => lambda { |v| v.is_a? String },
           "print_allowedis not one of `Disabled`, `Enabled`" => lambda { |v| %w{Disabled Enabled}.include? v },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :upload_allowed, Hash,
         required: true,
         callbacks: {
           "upload_allowed is not a String" => lambda { |v| v.is_a? String },
           "upload_allowedis not one of `Disabled`, `Enabled`" => lambda { |v| %w{Disabled Enabled}.include? v },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::WorkSpacesWeb::UserSettings"
rest_api_document "/AWS::WorkSpacesWeb::UserSettings"

rest_property_map({
  copy_allowed:                       "CopyAllowed",
  disconnect_timeout_in_minutes:      "DisconnectTimeoutInMinutes",
  download_allowed:                   "DownloadAllowed",
  idle_disconnect_timeout_in_minutes: "IdleDisconnectTimeoutInMinutes",
  paste_allowed:                      "PasteAllowed",
  print_allowed:                      "PrintAllowed",
  tags:                               "Tags",
  upload_allowed:                     "UploadAllowed",
})

