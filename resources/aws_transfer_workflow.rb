# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_transfer_workflow
provides :aws_transfer_workflow, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Transfer::Workflow
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..256 characters" => lambda { |v| v.length >= 0 && v.length <= 256 },
           "description must match pattern ^[\w\- ]*$" => lambda { |v| v =~ Regexp.new("/^[\w\- ]*$/") },
         },
         description: <<~'DESCRIPTION'
           A textual description for the workflow.
         DESCRIPTION

property :on_exception_steps, Array,
         callbacks: {
           "on_exception_steps is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Specifies the steps (actions) to take if any errors are encountered during execution of the workflow.
         DESCRIPTION

property :steps, Array,
         required: true,
         callbacks: {
           "steps is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Specifies the details for the steps that are in the specified workflow.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Key-value pairs that can be used to group and search for workflows. Tags are metadata attached to workflows for any purpose.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Transfer::Workflow"
rest_api_document "/AWS::Transfer::Workflow"

rest_property_map({
  description:        "Description",
  on_exception_steps: "OnExceptionSteps",
  steps:              "Steps",
  tags:               "Tags",
})

rest_post_only_properties %i{
  description on_exception_steps steps
}
