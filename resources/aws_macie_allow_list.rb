# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_macie_allow_list
provides :aws_macie_allow_list, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Macie AllowList resource schema
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :criteria, Hash,
         required: true,
         description: <<~'DESCRIPTION'
           AllowList criteria.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Description of AllowList.
         DESCRIPTION

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Name of AllowList.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A collection of tags associated with a resource
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Macie::AllowList"
rest_api_document "/AWS::Macie::AllowList"

rest_property_map({
  criteria:    "Criteria",
  description: "Description",
  name:        "Name",
  tags:        "Tags",
})

