# Import API specifics
use "awscc_base"

resource_name :aws_sagemaker_project
provides :aws_sagemaker_project, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::SageMaker::Project
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :project_description, Hash,
         callbacks: {
           "project_description is not a String" => lambda { |v| v.is_a? String },
           "project_description must match pattern .*" => lambda { |v| v =~ Regexp.new("/.*/") },
         },
         description: ""

property :project_name, Hash,
         required: true,
         callbacks: {
           "project_name is not a String" => lambda { |v| v.is_a? String },
           "project_name needs to be 1..32 characters" => lambda { |v| v.length >= 1 && v.length <= 32 },
           "project_name must match pattern ^[a-zA-Z0-9](-*[a-zA-Z0-9])*$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9](-*[a-zA-Z0-9])*$/") },
         },
         description: ""

property :servicecatalog_provisioning_details, Hash,
         required: true,
         callbacks: {
           "Subproperty `ProvisioningParameters` is not a Array" => lambda { |v| v[:ProvisioningParameters].is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Input ServiceCatalog Provisioning Details
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::SageMaker::Project"
rest_api_document "/AWS::SageMaker::Project"

rest_property_map({
  project_description:                 "ProjectDescription",
  project_name:                        "ProjectName",
  servicecatalog_provisioning_details: "ServiceCatalogProvisioningDetails",
  tags:                                "Tags",
})

rest_post_only_properties %i{
  project_description project_name servicecatalog_provisioning_details tags
}
