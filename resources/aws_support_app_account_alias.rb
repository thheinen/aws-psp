# Import API specifics
use "awscc_base"

resource_name :aws_support_app_account_alias
provides :aws_support_app_account_alias, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  An AWS Support App resource that creates, updates, reads, and deletes a customer's account alias.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :account_alias, String,
         required: true,
         callbacks: {
           "account_alias is not a String" => lambda { |v| v.is_a? String },
           "account_alias needs to be 1..30 characters" => lambda { |v| v.length >= 1 && v.length <= 30 },
           "account_alias must match pattern ^[\w\- ]+$" => lambda { |v| v =~ Regexp.new("/^[\w\- ]+$/") },
         },
         description: <<~'DESCRIPTION'
           An account alias associated with a customer's account.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SupportApp::AccountAlias"
rest_api_document "/AWS::SupportApp::AccountAlias"

rest_property_map({
  account_alias: "AccountAlias",
})

