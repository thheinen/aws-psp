# Import API specifics
use "awscc_base"

resource_name :aws_gamelift_game_server_group
provides :aws_gamelift_game_server_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::GameLift::GameServerGroup resource creates an Amazon GameLift (GameLift) GameServerGroup.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :autoscaling_policy, Hash,
         description: <<~'DESCRIPTION'
           Configuration settings to define a scaling policy for the Auto Scaling group that is optimized for game hosting
         DESCRIPTION

property :balancing_strategy, Hash,
         callbacks: {
           "balancing_strategy is not a String" => lambda { |v| v.is_a? String },
           "balancing_strategyis not one of `SPOT_ONLY`, `SPOT_PREFERRED`, `ON_DEMAND_ONLY`" => lambda { |v| %w{SPOT_ONLY SPOT_PREFERRED ON_DEMAND_ONLY}.include? v },
         },
         description: <<~'DESCRIPTION'
           The fallback balancing method to use for the game server group when Spot Instances in a Region become unavailable or are not viable for game hosting.
         DESCRIPTION

property :delete_option, Hash,
         callbacks: {
           "delete_option is not a String" => lambda { |v| v.is_a? String },
           "delete_optionis not one of `SAFE_DELETE`, `FORCE_DELETE`, `RETAIN`" => lambda { |v| %w{SAFE_DELETE FORCE_DELETE RETAIN}.include? v },
         },
         description: <<~'DESCRIPTION'
           The type of delete to perform.
         DESCRIPTION

property :game_server_group_name, Hash,
         required: true,
         callbacks: {
           "game_server_group_name is not a String" => lambda { |v| v.is_a? String },
           "game_server_group_name needs to be 1..128 characters" => lambda { |v| v.length >= 1 && v.length <= 128 },
           "game_server_group_name must match pattern [a-zA-Z0-9-\.]+" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9-\.]+/") },
         },
         description: <<~'DESCRIPTION'
           An identifier for the new game server group.
         DESCRIPTION

property :game_server_protection_policy, Hash,
         callbacks: {
           "game_server_protection_policy is not a String" => lambda { |v| v.is_a? String },
           "game_server_protection_policyis not one of `NO_PROTECTION`, `FULL_PROTECTION`" => lambda { |v| %w{NO_PROTECTION FULL_PROTECTION}.include? v },
         },
         description: <<~'DESCRIPTION'
           A flag that indicates whether instances in the game server group are protected from early termination.
         DESCRIPTION

property :instance_definitions, Hash,
         required: true,
         callbacks: {
           "instance_definitions is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A set of EC2 instance types to use when creating instances in the group.
         DESCRIPTION

property :launch_template, Hash,
         required: true,
         description: <<~'DESCRIPTION'
           The EC2 launch template that contains configuration settings and game server code to be deployed to all instances in the game server group.
         DESCRIPTION

property :max_size, Hash,
         callbacks: {
           "max_size is not a Number" => lambda { |v| v.is_a? Number },
         },
         description: <<~'DESCRIPTION'
           The maximum number of instances allowed in the EC2 Auto Scaling group.
         DESCRIPTION

property :min_size, Hash,
         callbacks: {
           "min_size is not a Number" => lambda { |v| v.is_a? Number },
         },
         description: <<~'DESCRIPTION'
           The minimum number of instances allowed in the EC2 Auto Scaling group.
         DESCRIPTION

property :role_arn, Hash,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
           "role_arn needs to be 1..256 characters" => lambda { |v| v.length >= 1 && v.length <= 256 },
           "role_arn must match pattern ^arn:.*:role\/[\w+=,.@-]+" => lambda { |v| v =~ Regexp.new("/^arn:.*:role\/[\w+=,.@-]+/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) for an IAM role that allows Amazon GameLift to access your EC2 Auto Scaling groups.
         DESCRIPTION

property :tags, Hash,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of labels to assign to the new game server group resource.
         DESCRIPTION

property :vpc_subnets, Hash,
         callbacks: {
           "vpc_subnets is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of virtual private cloud (VPC) subnets to use with instances in the game server group.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::GameLift::GameServerGroup"
rest_api_document "/AWS::GameLift::GameServerGroup"

rest_property_map({
  autoscaling_policy:            "AutoScalingPolicy",
  balancing_strategy:            "BalancingStrategy",
  delete_option:                 "DeleteOption",
  game_server_group_name:        "GameServerGroupName",
  game_server_protection_policy: "GameServerProtectionPolicy",
  instance_definitions:          "InstanceDefinitions",
  launch_template:               "LaunchTemplate",
  max_size:                      "MaxSize",
  min_size:                      "MinSize",
  role_arn:                      "RoleArn",
  tags:                          "Tags",
  vpc_subnets:                   "VpcSubnets",
})

