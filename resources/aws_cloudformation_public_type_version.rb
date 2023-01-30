# Import API specifics
use "awscc_base"

resource_name :aws_cloudformation_public_type_version
provides :aws_cloudformation_public_type_version, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Test and Publish a resource that has been registered in the CloudFormation Registry.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :arn, String,
         callbacks: {
           "arn is not a String" => lambda { |v| v.is_a? String },
           "arn must match pattern arn:aws[A-Za-z0-9-]{0,64}:cloudformation:[A-Za-z0-9-]{1,64}:[0-9]{12}:type/.+" => lambda { |v| v =~ Regexp.new("/arn:aws[A-Za-z0-9-]{0,64}:cloudformation:[A-Za-z0-9-]{1,64}:[0-9]{12}:type/.+/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Number (ARN) of the extension.
         DESCRIPTION

property :log_delivery_bucket, String,
         callbacks: {
           "log_delivery_bucket is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A url to the S3 bucket where logs for the testType run will be available
         DESCRIPTION

property :public_version_number, String,
         callbacks: {
           "public_version_number is not a String" => lambda { |v| v.is_a? String },
           "public_version_number needs to be 5..64 characters" => lambda { |v| v.length >= 5 && v.length <= 64 },
         },
         description: <<~'DESCRIPTION'
           The version number of a public third-party extension
         DESCRIPTION

property :type, String,
         callbacks: {
           "type is not a String" => lambda { |v| v.is_a? String },
           "typeis not one of `RESOURCE`, `MODULE`, `HOOK`" => lambda { |v| %w{RESOURCE MODULE HOOK}.include? v },
         },
         description: <<~'DESCRIPTION'
           The kind of extension
         DESCRIPTION

property :type_name, String,
         callbacks: {
           "type_name is not a String" => lambda { |v| v.is_a? String },
           "type_name must match pattern [A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}(::MODULE){0,1}" => lambda { |v| v =~ Regexp.new("/[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}::[A-Za-z0-9]{2,64}(::MODULE){0,1}/") },
         },
         description: <<~'DESCRIPTION'
           The name of the type being registered.
            We recommend that type names adhere to the following pattern: company_or_organization::service::type.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::CloudFormation::PublicTypeVersion"
rest_api_document "/AWS::CloudFormation::PublicTypeVersion"

rest_property_map({
  arn:                   "Arn",
  log_delivery_bucket:   "LogDeliveryBucket",
  public_version_number: "PublicVersionNumber",
  type:                  "Type",
  type_name:             "TypeName",
})

rest_post_only_properties %i{
  arn log_delivery_bucket public_version_number type type_name
}
