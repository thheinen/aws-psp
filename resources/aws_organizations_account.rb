# Import API specifics
use "awscc_base"

resource_name :aws_organizations_account
provides :aws_organizations_account, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  You can use AWS::Organizations::Account to manage accounts in organization.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :account_name, String,
         required: true,
         callbacks: {
           "account_name is not a String" => lambda { |v| v.is_a? String },
           "account_name needs to be 1..50 characters" => lambda { |v| v.length >= 1 && v.length <= 50 },
           "account_name must match pattern [\u0020-\u007E]+" => lambda { |v| v =~ Regexp.new("/[\u0020-\u007E]+/") },
         },
         description: <<~'DESCRIPTION'
           The friendly name of the member account.
         DESCRIPTION

property :email, String,
         required: true,
         callbacks: {
           "email is not a String" => lambda { |v| v.is_a? String },
           "email needs to be 6..64 characters" => lambda { |v| v.length >= 6 && v.length <= 64 },
           "email must match pattern [^\s@]+@[^\s@]+\.[^\s@]+" => lambda { |v| v =~ Regexp.new("/[^\s@]+@[^\s@]+\.[^\s@]+/") },
         },
         description: <<~'DESCRIPTION'
           The email address of the owner to assign to the new member account.
         DESCRIPTION

property :parent_ids, Array,
         callbacks: {
           "parent_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           List of parent nodes for the member account. Currently only one parent at a time is supported. Default is root.
         DESCRIPTION

property :role_name, String,
         callbacks: {
           "role_name is not a String" => lambda { |v| v.is_a? String },
           "role_name needs to be 1..64 characters" => lambda { |v| v.length >= 1 && v.length <= 64 },
           "role_name must match pattern [\w+=,.@-]{1,64}" => lambda { |v| v =~ Regexp.new("/[\w+=,.@-]{1,64}/") },
         },
         description: <<~'DESCRIPTION'
           The name of an IAM role that AWS Organizations automatically preconfigures in the new member account. Default name is OrganizationAccountAccessRole if not specified.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of tags that you want to attach to the newly created account. For each tag in the list, you must specify both a tag key and a value.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Organizations::Account"
rest_api_document "/AWS::Organizations::Account"

rest_property_map({
  account_name: "AccountName",
  email:        "Email",
  parent_ids:   "ParentIds",
  role_name:    "RoleName",
  tags:         "Tags",
})

