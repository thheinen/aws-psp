# Import API specifics
use "awscc_base"

resource_name :aws_iam_service_linked_role
provides :aws_iam_service_linked_role, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::IAM::ServiceLinkedRole
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :aws_service_name, String,
         callbacks: {
           "aws_service_name is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The service principal for the AWS service to which this role is attached.
         DESCRIPTION

property :custom_suffix, String,
         callbacks: {
           "custom_suffix is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A string that you provide, which is combined with the service-provided prefix to form the complete role name.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The description of the role.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::IAM::ServiceLinkedRole"
rest_api_document "/AWS::IAM::ServiceLinkedRole"

rest_property_map({
  aws_service_name: "AWSServiceName",
  custom_suffix:    "CustomSuffix",
  description:      "Description",
})

rest_post_only_properties %i{
  aws_service_name custom_suffix
}
