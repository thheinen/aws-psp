# Import API specifics
use "awscc_base"

resource_name :aws_work_spaces_web_trust_store
provides :aws_work_spaces_web_trust_store, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::WorkSpacesWeb::TrustStore Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :certificate_list, Array,
         required: true,
         callbacks: {
           "certificate_list is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::WorkSpacesWeb::TrustStore"
rest_api_document "/AWS::WorkSpacesWeb::TrustStore"

rest_property_map({
  certificate_list: "CertificateList",
  tags:             "Tags",
})

