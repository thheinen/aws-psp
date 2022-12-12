# Import API specifics
use "awscc_base"

resource_name :aws_timestream_database
provides :aws_timestream_database, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::Timestream::Database resource creates a Timestream database.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :database_name, String,
         callbacks: {
           "database_name is not a String" => lambda { |v| v.is_a? String },
           "database_name must match pattern ^[a-zA-Z0-9_.-]{3,256}$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_.-]{3,256}$/") },
         },
         description: <<~'DESCRIPTION'
           The name for the database. If you don't specify a name, AWS CloudFormation generates a unique physical ID and uses that ID for the database name.
         DESCRIPTION

property :kms_key_id, String,
         callbacks: {
           "kms_key_id is not a String" => lambda { |v| v.is_a? String },
           "kms_key_id needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
         },
         description: <<~'DESCRIPTION'
           The KMS key for the database. If the KMS key is not specified, the database will be encrypted with a Timestream managed KMS key located in your account.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Timestream::Database"
rest_api_document "/AWS::Timestream::Database"

rest_property_map({
  database_name: "DatabaseName",
  kms_key_id:    "KmsKeyId",
  tags:          "Tags",
})

rest_post_only_properties %i{
  database_name
}
