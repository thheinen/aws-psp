# Import API specifics
use "awscc_base"

resource_name :aws_transfer_profile
provides :aws_transfer_profile, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Transfer::Profile
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :as2_id, String,
         required: true,
         callbacks: {
           "as2_id is not a String" => lambda { |v| v.is_a? String },
           "as2_id needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
         },
         description: <<~'DESCRIPTION'
           AS2 identifier agreed with a trading partner.
         DESCRIPTION

property :certificate_ids, Array,
         callbacks: {
           "certificate_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           List of the certificate IDs associated with this profile to be used for encryption and signing of AS2 messages.
         DESCRIPTION

property :profile_type, String,
         required: true,
         callbacks: {
           "profile_type is not a String" => lambda { |v| v.is_a? String },
           "profile_typeis not one of `LOCAL`, `PARTNER`" => lambda { |v| %w{LOCAL PARTNER}.include? v },
         },
         description: <<~'DESCRIPTION'
           Enum specifying whether the profile is local or associated with a trading partner.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Transfer::Profile"
rest_api_document "/AWS::Transfer::Profile"

rest_property_map({
  as2_id:          "As2Id",
  certificate_ids: "CertificateIds",
  profile_type:    "ProfileType",
  tags:            "Tags",
})

rest_post_only_properties %i{
  profile_type
}
