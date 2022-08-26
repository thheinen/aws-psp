# Import API specifics
use "awscc_base"

resource_name :aws_lakeformation_tag_association
provides :aws_lakeformation_tag_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  A resource schema representing a Lake Formation Tag Association. While tag associations are not explicit Lake Formation resources, this CloudFormation resource can be used to associate tags with Lake Formation entities.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :lf_tags, Hash,
         required: true,
         callbacks: {
           "lf_tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: "List of Lake Formation Tags to associate with the Lake Formation Resource"

property :resource, Hash,
         required: true,
         description: "Resource to tag with the Lake Formation Tags"

# API URLs and mappings
rest_api_collection "/AWS::LakeFormation::TagAssociation"
rest_api_document "/AWS::LakeFormation::TagAssociation"

rest_property_map({
  lf_tags:  "LFTags",
  resource: "Resource",
})

rest_post_only_properties %i{
  lf_tags resource
}
