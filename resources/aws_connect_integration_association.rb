# Import API specifics
use "awscc_base"

resource_name :aws_connect_integration_association
provides :aws_connect_integration_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Connect::IntegrationAssociation
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :instance_id, Hash,
         required: true,
         callbacks: {
           "instance_id is not a String" => lambda { |v| v.is_a? String },
           "instance_id needs to be 1..100 characters" => lambda { |v| v.length >= 1 && v.length <= 100 },
           "instance_id must match pattern ^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$" => lambda { |v| v =~ Regexp.new("/^arn:aws[-a-z0-9]*:connect:[-a-z0-9]*:[0-9]{12}:instance/[-a-zA-Z0-9]*$/") },
         },
         description: ""

property :integration_arn, Hash,
         required: true,
         callbacks: {
           "integration_arn is not a String" => lambda { |v| v.is_a? String },
           "integration_arn needs to be 1..140 characters" => lambda { |v| v.length >= 1 && v.length <= 140 },
         },
         description: ""

property :integration_type, Hash,
         required: true,
         callbacks: {
           "integration_type is not a String" => lambda { |v| v.is_a? String },
           "integration_typeis not one of `LEX_BOT`, `LAMBDA_FUNCTION`" => lambda { |v| %w{LEX_BOT LAMBDA_FUNCTION}.include? v },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::Connect::IntegrationAssociation"
rest_api_document "/AWS::Connect::IntegrationAssociation"

rest_property_map({
  instance_id:      "InstanceId",
  integration_arn:  "IntegrationArn",
  integration_type: "IntegrationType",
})

rest_post_only_properties %i{
  instance_id integration_arn integration_type
}
