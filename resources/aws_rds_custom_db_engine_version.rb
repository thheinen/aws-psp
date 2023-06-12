# Import API specifics
use "awscc_base"

resource_name :aws_rds_custom_db_engine_version
provides :aws_rds_custom_db_engine_version, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::RDS::CustomDBEngineVersion resource creates an Amazon RDS custom DB engine version.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :database_installation_files_s3_bucket_name, String,
         required: true,
         callbacks: {
           "database_installation_files_s3_bucket_name is not a String" => lambda { |v| v.is_a? String },
           "database_installation_files_s3_bucket_name needs to be 3..63 characters" => lambda { |v| v.length >= 3 && v.length <= 63 },
         },
         description: <<~'DESCRIPTION'
           The name of an Amazon S3 bucket that contains database installation files for your CEV. For example, a valid bucket name is `my-custom-installation-files`.
         DESCRIPTION

property :database_installation_files_s3_prefix, String,
         callbacks: {
           "database_installation_files_s3_prefix is not a String" => lambda { |v| v.is_a? String },
           "database_installation_files_s3_prefix needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           The Amazon S3 directory that contains the database installation files for your CEV. For example, a valid bucket name is `123456789012/cev1`. If this setting isn't specified, no prefix is assumed.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..1000 characters" => lambda { |v| v.length >= 1 && v.length <= 1000 },
         },
         description: <<~'DESCRIPTION'
           An optional description of your CEV.
         DESCRIPTION

property :engine, String,
         required: true,
         callbacks: {
           "engine is not a String" => lambda { |v| v.is_a? String },
           "engine needs to be 1..35 characters" => lambda { |v| v.length >= 1 && v.length <= 35 },
         },
         description: <<~'DESCRIPTION'
           The database engine to use for your custom engine version (CEV). The only supported value is `custom-oracle-ee`.
         DESCRIPTION

property :engine_version, String,
         required: true,
         callbacks: {
           "engine_version is not a String" => lambda { |v| v.is_a? String },
           "engine_version needs to be 1..60 characters" => lambda { |v| v.length >= 1 && v.length <= 60 },
         },
         description: <<~'DESCRIPTION'
           The name of your CEV. The name format is 19.customized_string . For example, a valid name is 19.my_cev1. This setting is required for RDS Custom for Oracle, but optional for Amazon RDS. The combination of Engine and EngineVersion is unique per customer per Region.
         DESCRIPTION

property :kms_key_id, String,
         callbacks: {
           "kms_key_id is not a String" => lambda { |v| v.is_a? String },
           "kms_key_id needs to be 1..2048 characters" => lambda { |v| v.length >= 1 && v.length <= 2048 },
         },
         description: <<~'DESCRIPTION'
           The AWS KMS key identifier for an encrypted CEV. A symmetric KMS key is required for RDS Custom, but optional for Amazon RDS.
         DESCRIPTION

property :manifest, String,
         callbacks: {
           "manifest is not a String" => lambda { |v| v.is_a? String },
           "manifest needs to be 1..51000 characters" => lambda { |v| v.length >= 1 && v.length <= 51000 },
         },
         description: <<~'DESCRIPTION'
           The CEV manifest, which is a JSON document that describes the installation .zip files stored in Amazon S3. Specify the name/value pairs in a file or a quoted string. RDS Custom applies the patches in the order in which they are listed.
         DESCRIPTION

property :status, String,
         callbacks: {
           "status is not a String" => lambda { |v| v.is_a? String },
           "statusis not one of `available`, `inactive`, `inactive-except-restore`" => lambda { |v| %w{available inactive inactive-except-restore}.include? v },
         },
         description: <<~'DESCRIPTION'
           The availability status to be assigned to the CEV.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::RDS::CustomDBEngineVersion"
rest_api_document "/AWS::RDS::CustomDBEngineVersion"

rest_property_map({
  database_installation_files_s3_bucket_name: "DatabaseInstallationFilesS3BucketName",
  database_installation_files_s3_prefix:      "DatabaseInstallationFilesS3Prefix",
  description:                                "Description",
  engine:                                     "Engine",
  engine_version:                             "EngineVersion",
  kms_key_id:                                 "KMSKeyId",
  manifest:                                   "Manifest",
  status:                                     "Status",
  tags:                                       "Tags",
})

rest_post_only_properties %i{
  database_installation_files_s3_bucket_name database_installation_files_s3_prefix engine engine_version kms_key_id manifest
}
