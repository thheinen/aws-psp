# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_signer_profile_permission
provides :aws_signer_profile_permission, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  An example resource schema demonstrating some basic constructs and validation rules.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :action, String,
         required: true,
         callbacks: {
           "action is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :principal, String,
         required: true,
         callbacks: {
           "principal is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :profile_name, String,
         required: true,
         callbacks: {
           "profile_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

property :profile_version, String,
         callbacks: {
           "profile_version is not a String" => lambda { |v| v.is_a? String },
           "profile_version must match pattern ^[0-9a-zA-Z]{10}$" => lambda { |v| v =~ Regexp.new("/^[0-9a-zA-Z]{10}$/") },
         },
         description: ""

property :statement_id, String,
         required: true,
         callbacks: {
           "statement_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Signer::ProfilePermission"
rest_api_document "/AWS::Signer::ProfilePermission"

rest_property_map({
  action:          "Action",
  principal:       "Principal",
  profile_name:    "ProfileName",
  profile_version: "ProfileVersion",
  statement_id:    "StatementId",
})

rest_post_only_properties %i{
  action principal profile_name profile_version statement_id
}
