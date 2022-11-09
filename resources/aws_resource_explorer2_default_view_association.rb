# Import API specifics
use "awscc_base"

resource_name :aws_resource_explorer2_default_view_association
provides :aws_resource_explorer2_default_view_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::ResourceExplorer2::DefaultViewAssociation Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :view_arn, String,
         required: true,
         callbacks: {
           "view_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::ResourceExplorer2::DefaultViewAssociation"
rest_api_document "/AWS::ResourceExplorer2::DefaultViewAssociation"

rest_property_map({
  view_arn: "ViewArn",
})

