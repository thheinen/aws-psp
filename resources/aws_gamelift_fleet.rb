# Import API specifics
use "awscc_base"

resource_name :aws_gamelift_fleet
provides :aws_gamelift_fleet, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::GameLift::Fleet resource creates an Amazon GameLift (GameLift) fleet to host game servers. A fleet is a set of EC2 or Anywhere instances, each of which can host multiple game sessions.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :anywhere_configuration, Hash,
         callbacks: {
           "Subproperty `Cost` is not a String" => lambda { |v| v[:Cost].is_a? String },
           "Subproperty `Cost` needs to be 1..11 characters" => lambda { |v| v[:Cost].length >= 1 && v[:Cost].length <= 11 },
           "Subproperty `Cost` must match pattern ^\d{1,5}(?:\.\d{1,5})?$" => lambda { |v| v[:Cost] =~ Regexp.new("/^\d{1,5}(?:\.\d{1,5})?$/") },
         },
         description: <<~'DESCRIPTION'
           Configuration for Anywhere fleet.
         DESCRIPTION

property :build_id, String,
         callbacks: {
           "build_id is not a String" => lambda { |v| v.is_a? String },
           "build_id must match pattern ^build-\S+|^arn:.*:build/build-\S+" => lambda { |v| v =~ Regexp.new("/^build-\S+|^arn:.*:build/build-\S+/") },
         },
         description: <<~'DESCRIPTION'
           A unique identifier for a build to be deployed on the new fleet. If you are deploying the fleet with a custom game build, you must specify this property. The build must have been successfully uploaded to Amazon GameLift and be in a READY status. This fleet setting cannot be changed once the fleet is created.
         DESCRIPTION

property :certificate_configuration, Hash,
         callbacks: {
           "Subproperty `CertificateType` is not a String" => lambda { |v| v[:CertificateType].is_a? String },
           "Subproperty `CertificateType`is not one of `DISABLED`, `GENERATED`" => lambda { |v| %w{DISABLED GENERATED}.include? v[:CertificateType] },
         },
         description: <<~'DESCRIPTION'
           Indicates whether to generate a TLS/SSL certificate for the new fleet. TLS certificates are used for encrypting traffic between game clients and game servers running on GameLift. If this parameter is not set, certificate generation is disabled. This fleet setting cannot be changed once the fleet is created.
         DESCRIPTION

property :compute_type, String,
         callbacks: {
           "compute_type is not a String" => lambda { |v| v.is_a? String },
           "compute_typeis not one of `EC2`, `ANYWHERE`" => lambda { |v| %w{EC2 ANYWHERE}.include? v },
         },
         description: <<~'DESCRIPTION'
           ComputeType to differentiate EC2 hardware managed by GameLift and Anywhere hardware managed by the customer.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
           "description needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
         },
         description: <<~'DESCRIPTION'
           A human-readable description of a fleet.
         DESCRIPTION

property :desired_ec2_instances, Integer,
         callbacks: {
           "desired_ec2_instances is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           [DEPRECATED] The number of EC2 instances that you want this fleet to host. When creating a new fleet, GameLift automatically sets this value to "1" and initiates a single instance. Once the fleet is active, update this value to trigger GameLift to add or remove instances from the fleet.
         DESCRIPTION

property :ec2_inbound_permissions, Array,
         callbacks: {
           "ec2_inbound_permissions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A range of IP addresses and port settings that allow inbound traffic to connect to server processes on an Amazon GameLift server.
         DESCRIPTION

property :ec2_instance_type, String,
         callbacks: {
           "ec2_instance_type is not a String" => lambda { |v| v.is_a? String },
           "ec2_instance_type must match pattern ^.*..*$" => lambda { |v| v =~ Regexp.new("/^.*..*$/") },
         },
         description: <<~'DESCRIPTION'
           The name of an EC2 instance type that is supported in Amazon GameLift. A fleet instance type determines the computing resources of each instance in the fleet, including CPU, memory, storage, and networking capacity. Amazon GameLift supports the following EC2 instance types. See Amazon EC2 Instance Types for detailed descriptions.
         DESCRIPTION

property :fleet_type, String,
         callbacks: {
           "fleet_type is not a String" => lambda { |v| v.is_a? String },
           "fleet_typeis not one of `ON_DEMAND`, `SPOT`" => lambda { |v| %w{ON_DEMAND SPOT}.include? v },
         },
         description: <<~'DESCRIPTION'
           Indicates whether to use On-Demand instances or Spot instances for this fleet. If empty, the default is ON_DEMAND. Both categories of instances use identical hardware and configurations based on the instance type selected for this fleet.
         DESCRIPTION

property :instance_role_arn, String,
         callbacks: {
           "instance_role_arn is not a String" => lambda { |v| v.is_a? String },
           "instance_role_arn must match pattern ^arn:aws(-.*)?:[a-z-]+:(([a-z]+-)+[0-9])?:([0-9]{12})?:[^.]+$" => lambda { |v| v =~ Regexp.new("/^arn:aws(-.*)?:[a-z-]+:(([a-z]+-)+[0-9])?:([0-9]{12})?:[^.]+$/") },
         },
         description: <<~'DESCRIPTION'
           A unique identifier for an AWS IAM role that manages access to your AWS services. With an instance role ARN set, any application that runs on an instance in this fleet can assume the role, including install scripts, server processes, and daemons (background processes). Create a role or look up a role's ARN from the IAM dashboard in the AWS Management Console.
         DESCRIPTION

property :locations, Array,
         callbacks: {
           "locations is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

property :log_paths, Array,
         callbacks: {
           "log_paths is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           This parameter is no longer used. When hosting a custom game build, specify where Amazon GameLift should store log files using the Amazon GameLift server API call ProcessReady()
         DESCRIPTION

property :max_size, Integer,
         callbacks: {
           "max_size is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           [DEPRECATED] The maximum value that is allowed for the fleet's instance count. When creating a new fleet, GameLift automatically sets this value to "1". Once the fleet is active, you can change this value.
         DESCRIPTION

property :metric_groups, Array,
         callbacks: {
           "metric_groups is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The name of an Amazon CloudWatch metric group. A metric group aggregates the metrics for all fleets in the group. Specify a string containing the metric group name. You can use an existing name or use a new name to create a new metric group. Currently, this parameter can have only one string.
         DESCRIPTION

property :min_size, Integer,
         callbacks: {
           "min_size is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           [DEPRECATED] The minimum value allowed for the fleet's instance count. When creating a new fleet, GameLift automatically sets this value to "0". After the fleet is active, you can change this value.
         DESCRIPTION

property :name, String,
         name_property: true,
         required: true,
         callbacks: {
           "name is not a String" => lambda { |v| v.is_a? String },
           "name needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
         },
         description: <<~'DESCRIPTION'
           A descriptive label that is associated with a fleet. Fleet names do not need to be unique.
         DESCRIPTION

property :new_game_session_protection_policy, String,
         callbacks: {
           "new_game_session_protection_policy is not a String" => lambda { |v| v.is_a? String },
           "new_game_session_protection_policyis not one of `FullProtection`, `NoProtection`" => lambda { |v| %w{FullProtection NoProtection}.include? v },
         },
         description: <<~'DESCRIPTION'
           A game session protection policy to apply to all game sessions hosted on instances in this fleet. When protected, active game sessions cannot be terminated during a scale-down event. If this parameter is not set, instances in this fleet default to no protection. You can change a fleet's protection policy to affect future game sessions on the fleet. You can also set protection for individual game sessions.
         DESCRIPTION

property :peer_vpc_aws_account_id, String,
         callbacks: {
           "peer_vpc_aws_account_id is not a String" => lambda { |v| v.is_a? String },
           "peer_vpc_aws_account_id needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
           "peer_vpc_aws_account_id must match pattern ^[0-9]{12}$" => lambda { |v| v =~ Regexp.new("/^[0-9]{12}$/") },
         },
         description: <<~'DESCRIPTION'
           A unique identifier for the AWS account with the VPC that you want to peer your Amazon GameLift fleet with. You can find your account ID in the AWS Management Console under account settings.
         DESCRIPTION

property :peer_vpc_id, String,
         callbacks: {
           "peer_vpc_id is not a String" => lambda { |v| v.is_a? String },
           "peer_vpc_id needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
           "peer_vpc_id must match pattern ^vpc-\S+" => lambda { |v| v =~ Regexp.new("/^vpc-\S+/") },
         },
         description: <<~'DESCRIPTION'
           A unique identifier for a VPC with resources to be accessed by your Amazon GameLift fleet. The VPC must be in the same Region as your fleet. To look up a VPC ID, use the VPC Dashboard in the AWS Management Console.
         DESCRIPTION

property :resource_creation_limit_policy, Hash,
         callbacks: {
           "Subproperty `NewGameSessionsPerCreator` is not a Integer" => lambda { |v| v[:NewGameSessionsPerCreator].is_a? Integer },
           "Subproperty `PolicyPeriodInMinutes` is not a Integer" => lambda { |v| v[:PolicyPeriodInMinutes].is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           A policy that limits the number of game sessions an individual player can create over a span of time for this fleet.
         DESCRIPTION

property :runtime_configuration, Hash,
         callbacks: {
           "Subproperty `GameSessionActivationTimeoutSeconds` is not a Integer" => lambda { |v| v[:GameSessionActivationTimeoutSeconds].is_a? Integer },
           "Subproperty `MaxConcurrentGameSessionActivations` is not a Integer" => lambda { |v| v[:MaxConcurrentGameSessionActivations].is_a? Integer },
           "Subproperty `ServerProcesses` is not a Array" => lambda { |v| v[:ServerProcesses].is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Instructions for launching server processes on each instance in the fleet. Server processes run either a custom game build executable or a Realtime script. The runtime configuration defines the server executables or launch script file, launch parameters, and the number of processes to run concurrently on each instance. When creating a fleet, the runtime configuration must have at least one server process configuration; otherwise the request fails with an invalid request exception.
            This parameter is required unless the parameters ServerLaunchPath and ServerLaunchParameters are defined. Runtime configuration has replaced these parameters, but fleets that use them will continue to work.
         DESCRIPTION

property :script_id, String,
         callbacks: {
           "script_id is not a String" => lambda { |v| v.is_a? String },
           "script_id must match pattern ^script-\S+|^arn:.*:script/script-\S+" => lambda { |v| v =~ Regexp.new("/^script-\S+|^arn:.*:script/script-\S+/") },
         },
         description: <<~'DESCRIPTION'
           A unique identifier for a Realtime script to be deployed on a new Realtime Servers fleet. The script must have been successfully uploaded to Amazon GameLift. This fleet setting cannot be changed once the fleet is created.
            Note: It is not currently possible to use the !Ref command to reference a script created with a CloudFormation template for the fleet property ScriptId. Instead, use Fn::GetAtt Script.Arn or Fn::GetAtt Script.Id to retrieve either of these properties as input for ScriptId. Alternatively, enter a ScriptId string manually.
         DESCRIPTION

property :server_launch_parameters, String,
         callbacks: {
           "server_launch_parameters is not a String" => lambda { |v| v.is_a? String },
           "server_launch_parameters needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
         },
         description: <<~'DESCRIPTION'
           This parameter is no longer used but is retained for backward compatibility. Instead, specify server launch parameters in the RuntimeConfiguration parameter. A request must specify either a runtime configuration or values for both ServerLaunchParameters and ServerLaunchPath.
         DESCRIPTION

property :server_launch_path, String,
         callbacks: {
           "server_launch_path is not a String" => lambda { |v| v.is_a? String },
           "server_launch_path needs to be 1..1024 characters" => lambda { |v| v.length >= 1 && v.length <= 1024 },
         },
         description: <<~'DESCRIPTION'
           This parameter is no longer used. Instead, specify a server launch path using the RuntimeConfiguration parameter. Requests that specify a server launch path and launch parameters instead of a runtime configuration will continue to work.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::GameLift::Fleet"
rest_api_document "/AWS::GameLift::Fleet"

rest_property_map({
  anywhere_configuration:             "AnywhereConfiguration",
  build_id:                           "BuildId",
  certificate_configuration:          "CertificateConfiguration",
  compute_type:                       "ComputeType",
  description:                        "Description",
  desired_ec2_instances:              "DesiredEC2Instances",
  ec2_inbound_permissions:            "EC2InboundPermissions",
  ec2_instance_type:                  "EC2InstanceType",
  fleet_type:                         "FleetType",
  instance_role_arn:                  "InstanceRoleARN",
  locations:                          "Locations",
  log_paths:                          "LogPaths",
  max_size:                           "MaxSize",
  metric_groups:                      "MetricGroups",
  min_size:                           "MinSize",
  name:                               "Name",
  new_game_session_protection_policy: "NewGameSessionProtectionPolicy",
  peer_vpc_aws_account_id:            "PeerVpcAwsAccountId",
  peer_vpc_id:                        "PeerVpcId",
  resource_creation_limit_policy:     "ResourceCreationLimitPolicy",
  runtime_configuration:              "RuntimeConfiguration",
  script_id:                          "ScriptId",
  server_launch_parameters:           "ServerLaunchParameters",
  server_launch_path:                 "ServerLaunchPath",
})

rest_post_only_properties %i{
  build_id certificate_configuration certificate_type compute_type ec2_instance_type fleet_type instance_role_arn log_paths peer_vpc_aws_account_id peer_vpc_id script_id server_launch_parameters server_launch_path
}
