# Import API specifics
use "awscc_base"

resource_name :aws_detective_organization_admin
provides :aws_detective_organization_admin, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::Detective::OrganizationAdmin
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :account_id, String,
         required: true,
         callbacks: {
           "account_id is not a String" => lambda { |v| v.is_a? String },
           "account_id must match pattern [0-9]{12}" => lambda { |v| v =~ Regexp.new("/[0-9]{12}/") },
         },
         description: <<~'DESCRIPTION'
           The account ID of the account that should be registered as your Organization's delegated administrator for Detective
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Detective::OrganizationAdmin"
rest_api_document "/AWS::Detective::OrganizationAdmin"

rest_property_map({
  account_id: "AccountId",
})

rest_post_only_properties %i{
  account_id
}
