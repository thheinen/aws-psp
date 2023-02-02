# Import API specifics
use "awscc_base"

resource_name :aws_sim_space_weaver_simulation
provides :aws_sim_space_weaver_simulation, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  AWS::SimSpaceWeaver::Simulation resource creates an AWS Simulation.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :name, String,
         name_property: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
           "name must match pattern [a-zA-Z0-9_\-]{1,2048}$" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9_\-]{1,2048}$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the simulation.
         DESCRIPTION

property :role_arn, String,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Role ARN.
         DESCRIPTION

property :schema_s3_location, Hash,
         callbacks: {
           "Subproperty `BucketName` is not a String" => lambda { |v| v[:BucketName].is_a? String },
           "Subproperty `BucketName` needs to be 3..255 characters" => lambda { |v| v[:BucketName].length >= 3 && v[:BucketName].length <= 255 },
           "Subproperty `BucketName` must match pattern [a-zA-Z0-9_\-]{3,255}$" => lambda { |v| v[:BucketName] =~ Regexp.new("/[a-zA-Z0-9_\-]{3,255}$/") },
           "Subproperty `ObjectKey` is not a String" => lambda { |v| v[:ObjectKey].is_a? String },
           "Subproperty `ObjectKey` needs to be 3..255 characters" => lambda { |v| v[:ObjectKey].length >= 3 && v[:ObjectKey].length <= 255 },
           "Subproperty `ObjectKey` must match pattern ([\-a-zA-Z0-9_-]+\/)*[a-zA-Z0-9_-]+\.(json|yaml)$" => lambda { |v| v[:ObjectKey] =~ Regexp.new("/([\-a-zA-Z0-9_-]+\/)*[a-zA-Z0-9_-]+\.(json|yaml)$/") },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::SimSpaceWeaver::Simulation"
rest_api_document "/AWS::SimSpaceWeaver::Simulation"

rest_property_map({
  name:               "Name",
  role_arn:           "RoleArn",
  schema_s3_location: "SchemaS3Location",
})

rest_post_only_properties %i{
  name
}
