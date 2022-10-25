# Import API specifics
use "awscc_base"

resource_name :aws_f_sx_data_repository_association
provides :aws_f_sx_data_repository_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::FSx::DataRepositoryAssociation
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :batch_import_meta_data_on_create, [TrueClass, FalseClass],
         callbacks: {
           "batch_import_meta_data_on_create is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           A boolean flag indicating whether an import data repository task to import metadata should run after the data repository association is created. The task runs if this flag is set to true.
         DESCRIPTION

property :data_repository_path, String,
         required: true,
         callbacks: {
           "data_repository_path is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The path to the Amazon S3 data repository that will be linked to the file system. The path can be an S3 bucket or prefix in the format s3://myBucket/myPrefix/ . This path specifies where in the S3 data repository files will be imported from or exported to.
         DESCRIPTION

property :file_system_id, String,
         required: true,
         callbacks: {
           "file_system_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The globally unique ID of the file system, assigned by Amazon FSx.
         DESCRIPTION

property :file_system_path, String,
         required: true,
         callbacks: {
           "file_system_path is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           This path specifies where in your file system files will be exported from or imported to. This file system directory can be linked to only one Amazon S3 bucket, and no other S3 bucket can be linked to the directory.
         DESCRIPTION

property :imported_file_chunk_size, Integer,
         callbacks: {
           "imported_file_chunk_size is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           For files imported from a data repository, this value determines the stripe count and maximum amount of data per file (in MiB) stored on a single physical disk. The maximum number of disks that a single file can be striped across is limited by the total number of disks that make up the file system.
         DESCRIPTION

property :s3, Hash,
         description: <<~'DESCRIPTION'
           The configuration for an Amazon S3 data repository linked to an Amazon FSx Lustre file system with a data repository association. The configuration defines which file events (new, changed, or deleted files or directories) are automatically imported from the linked data repository to the file system or automatically exported from the file system to the data repository.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of Tag values, with a maximum of 50 elements.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::FSx::DataRepositoryAssociation"
rest_api_document "/AWS::FSx::DataRepositoryAssociation"

rest_property_map({
  batch_import_meta_data_on_create: "BatchImportMetaDataOnCreate",
  data_repository_path:             "DataRepositoryPath",
  file_system_id:                   "FileSystemId",
  file_system_path:                 "FileSystemPath",
  imported_file_chunk_size:         "ImportedFileChunkSize",
  s3:                               "S3",
  tags:                             "Tags",
})

rest_post_only_properties %i{
  batch_import_meta_data_on_create data_repository_path file_system_id file_system_path
}
