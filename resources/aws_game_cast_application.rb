# Import API specifics
use "awscc_base"

resource_name :aws_game_cast_application
provides :aws_game_cast_application, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Definition of AWS::GameCast::Application Resource Type
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :application_source_uri, String,
         callbacks: {
           "application_source_uri is not a String" => lambda { |v| v.is_a? String },
           "application_source_uri needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
         },
         description: <<~'DESCRIPTION'
           ApplicationSourceUri points to a S3 Uri to replicate game files from customer S3 bucket into Motif internal S3 bucket.
      The uri points to a S3 prefix that could contain many objects. Motif will attempt to copy all the S3 objects under that prefix.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
           "description must match pattern ^[a-zA-Z0-9-_\s]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9-_\s]+$/") },
         },
         description: <<~'DESCRIPTION'
           Descriptive label for the resource, not a unique ID.
         DESCRIPTION

property :executable_path, String,
         callbacks: {
           "executable_path is not a String" => lambda { |v| v.is_a? String },
           "executable_path needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
         },
         description: <<~'DESCRIPTION'
           Executable path is a relative path to the game launcher executable.
         DESCRIPTION

property :log_locations, Array,
         callbacks: {
           "log_locations is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of save file, registry key or log paths that are absolute paths that store game save files when the games
      are running on a Windows environment.
         DESCRIPTION

property :runtime_environment, Hash,
         callbacks: {
           "Subproperty `Version` is not a String" => lambda { |v| v[:Version].is_a? String },
           "Subproperty `Version` needs to be 1..256 characters" => lambda { |v| v[:Version].length >= 1 && v[:Version].length <= 256 },
         },
         description: ""

property :save_configuration, Hash,
         callbacks: {
           "Subproperty `RegistryLocations` is not a Array" => lambda { |v| v[:RegistryLocations].is_a? Array },
           "Subproperty `FileLocations` is not a Array" => lambda { |v| v[:FileLocations].is_a? Array },
         },
         description: ""

property :save_key, String,
         callbacks: {
           "save_key is not a String" => lambda { |v| v.is_a? String },
           "save_key needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
         },
         description: <<~'DESCRIPTION'
           SaveKey is used as key to manage save files, meaning that different applications with the
      same SaveKey can share game save files generated by the game itself.
         DESCRIPTION

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::GameCast::Application"
rest_api_document "/AWS::GameCast::Application"

rest_property_map({
  application_source_uri: "ApplicationSourceUri",
  description:            "Description",
  executable_path:        "ExecutablePath",
  log_locations:          "LogLocations",
  runtime_environment:    "RuntimeEnvironment",
  save_configuration:     "SaveConfiguration",
  save_key:               "SaveKey",
  tags:                   "Tags",
})

rest_post_only_properties %i{
  application_source_uri runtime_environment save_key
}
