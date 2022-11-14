# Import API specifics
use "awscc_base"

resource_name :aws_lightsail_database
provides :aws_lightsail_database, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::Lightsail::Database
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :availability_zone, String,
         callbacks: {
           "availability_zone is not a String" => lambda { |v| v.is_a? String },
           "availability_zone needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           The Availability Zone in which to create your new database. Use the us-east-2a case-sensitive format.
         DESCRIPTION

property :backup_retention, [TrueClass, FalseClass],
         callbacks: {
           "backup_retention is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           When true, enables automated backup retention for your database. Updates are applied during the next maintenance window because this can result in an outage.
         DESCRIPTION

property :ca_certificate_identifier, String,
         callbacks: {
           "ca_certificate_identifier is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           Indicates the certificate that needs to be associated with the database.
         DESCRIPTION

property :master_database_name, String,
         required: true,
         callbacks: {
           "master_database_name is not a String" => lambda { |v| v.is_a? String },
           "master_database_name needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           The name of the database to create when the Lightsail database resource is created. For MySQL, if this parameter isn't specified, no database is created in the database resource. For PostgreSQL, if this parameter isn't specified, a database named postgres is created in the database resource.
         DESCRIPTION

property :master_user_password, String,
         callbacks: {
           "master_user_password is not a String" => lambda { |v| v.is_a? String },
           "master_user_password needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
         },
         description: <<~'DESCRIPTION'
           The password for the master user. The password can include any printable ASCII character except "/", """, or "@". It cannot contain spaces.
         DESCRIPTION

property :master_username, String,
         required: true,
         callbacks: {
           "master_username is not a String" => lambda { |v| v.is_a? String },
           "master_username needs to be 1..63 characters" => lambda { |v| v.length >= 1 && v.length <= 63 },
         },
         description: <<~'DESCRIPTION'
           The name for the master user.
         DESCRIPTION

property :preferred_backup_window, String,
         callbacks: {
           "preferred_backup_window is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The daily time range during which automated backups are created for your new database if automated backups are enabled.
         DESCRIPTION

property :preferred_maintenance_window, String,
         callbacks: {
           "preferred_maintenance_window is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The weekly time range during which system maintenance can occur on your new database.
         DESCRIPTION

property :publicly_accessible, [TrueClass, FalseClass],
         callbacks: {
           "publicly_accessible is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Specifies the accessibility options for your new database. A value of true specifies a database that is available to resources outside of your Lightsail account. A value of false specifies a database that is available only to your Lightsail resources in the same region as your database.
         DESCRIPTION

property :relational_database_blueprint_id, String,
         required: true,
         callbacks: {
           "relational_database_blueprint_id is not a String" => lambda { |v| v.is_a? String },
           "relational_database_blueprint_id needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           The blueprint ID for your new database. A blueprint describes the major engine version of a database.
         DESCRIPTION

property :relational_database_bundle_id, String,
         required: true,
         callbacks: {
           "relational_database_bundle_id is not a String" => lambda { |v| v.is_a? String },
           "relational_database_bundle_id needs to be 1..255 characters" => lambda { |v| v.length >= 1 && v.length <= 255 },
         },
         description: <<~'DESCRIPTION'
           The bundle ID for your new database. A bundle describes the performance specifications for your database.
         DESCRIPTION

property :relational_database_name, String,
         required: true,
         callbacks: {
           "relational_database_name is not a String" => lambda { |v| v.is_a? String },
           "relational_database_name needs to be 2..255 characters" => lambda { |v| v.length >= 2 && v.length <= 255 },
           "relational_database_name must match pattern \w[\w\-]*\w" => lambda { |v| v =~ Regexp.new("/\w[\w\-]*\w/") },
         },
         description: <<~'DESCRIPTION'
           The name to use for your new Lightsail database resource.
         DESCRIPTION

property :relational_database_parameters, Array,
         callbacks: {
           "relational_database_parameters is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Update one or more parameters of the relational database.
         DESCRIPTION

property :rotate_master_user_password, [TrueClass, FalseClass],
         callbacks: {
           "rotate_master_user_password is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           When true, the master user password is changed to a new strong password generated by Lightsail. Use the get relational database master user password operation to get the new password.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Lightsail::Database"
rest_api_document "/AWS::Lightsail::Database"

rest_property_map({
  availability_zone:                "AvailabilityZone",
  backup_retention:                 "BackupRetention",
  ca_certificate_identifier:        "CaCertificateIdentifier",
  master_database_name:             "MasterDatabaseName",
  master_user_password:             "MasterUserPassword",
  master_username:                  "MasterUsername",
  preferred_backup_window:          "PreferredBackupWindow",
  preferred_maintenance_window:     "PreferredMaintenanceWindow",
  publicly_accessible:              "PubliclyAccessible",
  relational_database_blueprint_id: "RelationalDatabaseBlueprintId",
  relational_database_bundle_id:    "RelationalDatabaseBundleId",
  relational_database_name:         "RelationalDatabaseName",
  relational_database_parameters:   "RelationalDatabaseParameters",
  rotate_master_user_password:      "RotateMasterUserPassword",
  tags:                             "Tags",
})

rest_post_only_properties %i{
  availability_zone master_database_name master_username relational_database_blueprint_id relational_database_bundle_id relational_database_name
}
