# Import API specifics
use "awscc_base"

resource_name :aws_m2_environment
provides :aws_m2_environment, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Represents a runtime environment that can run migrated mainframe applications.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 0..500 characters" => lambda { |v| v.length >= 0 && v.length <= 500 },
         },
         description: <<~'DESCRIPTION'
           The description of the environment.
         DESCRIPTION

property :engine_type, Hash,
         required: true,
         callbacks: {
           "engine_type is not a String" => lambda { |v| v.is_a? String },
           "engine_typeis not one of `microfocus`, `bluage`" => lambda { |v| %w{microfocus bluage}.include? v },
         },
         description: ""

property :engine_version, String,
         callbacks: {
           "engine_version is not a String" => lambda { |v| v.is_a? String },
           "engine_version must match pattern ^\S{1,10}$" => lambda { |v| v =~ Regexp.new("/^\S{1,10}$/") },
         },
         description: <<~'DESCRIPTION'
           The version of the runtime engine for the environment.
         DESCRIPTION

property :high_availability_config, Hash,
         callbacks: {
           "Subproperty `DesiredCapacity` is not a Integer" => lambda { |v| v[:DesiredCapacity].is_a? Integer },
         },
         description: ""

property :instance_type, String,
         required: true,
         callbacks: {
           "instance_type is not a String" => lambda { |v| v.is_a? String },
           "instance_type must match pattern ^\S{1,20}$" => lambda { |v| v =~ Regexp.new("/^\S{1,20}$/") },
         },
         description: <<~'DESCRIPTION'
           The type of instance underlying the environment.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name must match pattern ^[A-Za-z0-9][A-Za-z0-9_\-]{1,59}$" => lambda { |v| v =~ Regexp.new("/^[A-Za-z0-9][A-Za-z0-9_\-]{1,59}$/") },
         },
         description: <<~'DESCRIPTION'
           The name of the environment.
         DESCRIPTION

property :preferred_maintenance_window, String,
         callbacks: {
           "preferred_maintenance_window is not a String" => lambda { |v| v.is_a? String },
           "preferred_maintenance_window must match pattern ^\S{1,50}$" => lambda { |v| v =~ Regexp.new("/^\S{1,50}$/") },
         },
         description: <<~'DESCRIPTION'
           Configures a desired maintenance window for the environment. If you do not provide a value, a random system-generated value will be assigned.
         DESCRIPTION

property :publicly_accessible, [TrueClass, FalseClass],
         callbacks: {
           "publicly_accessible is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Specifies whether the environment is publicly accessible.
         DESCRIPTION

property :security_group_ids, Array,
         callbacks: {
           "security_group_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The list of security groups for the VPC associated with this environment.
         DESCRIPTION

property :storage_configurations, Array,
         callbacks: {
           "storage_configurations is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The storage configurations defined for the runtime environment.
         DESCRIPTION

property :subnet_ids, Array,
         callbacks: {
           "subnet_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The unique identifiers of the subnets assigned to this runtime environment.
         DESCRIPTION

property :tags, Hash,
         callbacks: {
           "tags is not a Object" => lambda { |v| v.is_a? Object },
         },
         description: <<~'DESCRIPTION'
           Tags associated to this environment.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::M2::Environment"
rest_api_document "/AWS::M2::Environment"

rest_property_map({
  description:                  "Description",
  engine_type:                  "EngineType",
  engine_version:               "EngineVersion",
  high_availability_config:     "HighAvailabilityConfig",
  instance_type:                "InstanceType",
  name:                         "Name",
  preferred_maintenance_window: "PreferredMaintenanceWindow",
  publicly_accessible:          "PubliclyAccessible",
  security_group_ids:           "SecurityGroupIds",
  storage_configurations:       "StorageConfigurations",
  subnet_ids:                   "SubnetIds",
  tags:                         "Tags",
})

rest_post_only_properties %i{
  description engine_type name publicly_accessible security_group_ids storage_configurations subnet_ids
}
