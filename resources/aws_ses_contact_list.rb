# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_ses_contact_list
provides :aws_ses_contact_list, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::SES::ContactList.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :contact_list_name, String,
         callbacks: {
           "contact_list_name is not a String" => lambda { |v| v.is_a? String },
           "contact_list_name must match pattern ^[a-zA-Z0-9_-]{1,64}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_-]{1,64}$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the contact list.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The description of the contact list.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags (keys and values) associated with the contact list.
         DESCRIPTION

property :topics, Array,
         callbacks: {
           "topics is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The topics associated with the contact list.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SES::ContactList"
rest_api_document "/AWS::SES::ContactList"

rest_property_map({
  contact_list_name: "ContactListName",
  description:       "Description",
  tags:              "Tags",
  topics:            "Topics",
})

rest_post_only_properties %i{
  contact_list_name
}
