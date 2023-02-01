# Import API specifics
use "awscc_base"

resource_name :aws_ssm_contacts_contact
provides :aws_ssm_contacts_contact, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SSMContacts::Contact
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :alias, String,
         required: true,
         callbacks: {
           "alias is not a String" => lambda { |v| v.is_a? String },
           "alias needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "alias must match pattern ^[a-z0-9_\-\.]*$" => lambda { |v| v =~ Regexp.new("/^[a-z0-9_\-\.]*$/") },
         },
         description: <<~'DESCRIPTION'
           Alias of the contact. String value with 20 to 256 characters. Only alphabetical, numeric characters, dash, or underscore allowed.
         DESCRIPTION

property :display_name, String,
         required: true,
         callbacks: {
           "display_name is not a String" => lambda { |v| v.is_a? String },
           "display_name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
           "display_name must match pattern ^[a-zA-Z0-9_\-\s]*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_\-\s]*$/") },
         },
         description: <<~'DESCRIPTION'
           Name of the contact. String value with 3 to 256 characters. Only alphabetical, space, numeric characters, dash, or underscore allowed.
         DESCRIPTION

property :plan, Array,
         required: true,
         callbacks: {
           "plan is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The stages that an escalation plan or engagement plan engages contacts and contact methods in.
         DESCRIPTION

property :type, String,
         required: true,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
           "typeis not one of `PERSONAL`, `CUSTOM`, `SERVICE`, `ESCALATION`" => lambda { |v| %w{PERSONAL CUSTOM SERVICE ESCALATION}.include? v },
         },
         description: <<~'DESCRIPTION'
           Contact type, which specify type of contact. Currently supported values: ?PERSONAL?, ?SHARED?, ?OTHER?.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SSMContacts::Contact"
rest_api_document "/AWS::SSMContacts::Contact"

rest_property_map({
  alias:        "Alias",
  display_name: "DisplayName",
  plan:         "Plan",
  type:         "Type",
})

rest_post_only_properties %i{
  alias type
}
