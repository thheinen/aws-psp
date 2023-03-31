# Import API specifics
use "awscc_base"

resource_name :aws_app_runner_service
provides :aws_app_runner_service, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::AppRunner::Service resource specifies an AppRunner Service.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :autoscaling_configuration_arn, String,
         callbacks: {
           "autoscaling_configuration_arn is not a String" => lambda { |v| v.is_a? String },
           "autoscaling_configuration_arn needs to be 1..1011 characters" => lambda { |v| v.length >= 1 && v.length <= 1011 },
           "autoscaling_configuration_arn must match pattern arn:aws(-[\w]+)*:[a-z0-9-\\.]{0,63}:[a-z0-9-\\.]{0,63}:[0-9]{12}:(\w|\/|-){1,1011}" => lambda { |v| v =~ Regexp.new("/arn:aws(-[\w]+)*:[a-z0-9-\\.]{0,63}:[a-z0-9-\\.]{0,63}:[0-9]{12}:(\w|\/|-){1,1011}/") },
         },
         description: <<~'DESCRIPTION'
           Autoscaling configuration ARN
         DESCRIPTION

property :encryption_configuration, Hash,
         callbacks: {
           "Subproperty `KmsKey` is not a String" => lambda { |v| v[:KmsKey].is_a? String },
           "Subproperty `KmsKey` needs to be 0..256 characters" => lambda { |v| v[:KmsKey].length >= 0 && v[:KmsKey].length <= 256 },
           "Subproperty `KmsKey` must match pattern arn:aws(-[\w]+)*:kms:[a-z\-]+-[0-9]{1}:[0-9]{12}:key\/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}" => lambda { |v| v[:KmsKey] =~ Regexp.new("/arn:aws(-[\w]+)*:kms:[a-z\-]+-[0-9]{1}:[0-9]{12}:key\/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/") },
         },
         description: ""

property :health_check_configuration, Hash,
         callbacks: {
           "Subproperty `Protocol` is not a String" => lambda { |v| v[:Protocol].is_a? String },
           "Subproperty `Protocol`is not one of `TCP`, `HTTP`" => lambda { |v| %w{TCP HTTP}.include? v[:Protocol] },
           "Subproperty `Path` is not a String" => lambda { |v| v[:Path].is_a? String },
           "Subproperty `Interval` is not a Integer" => lambda { |v| v[:Interval].is_a? Integer },
           "Subproperty `Timeout` is not a Integer" => lambda { |v| v[:Timeout].is_a? Integer },
           "Subproperty `HealthyThreshold` is not a Integer" => lambda { |v| v[:HealthyThreshold].is_a? Integer },
           "Subproperty `UnhealthyThreshold` is not a Integer" => lambda { |v| v[:UnhealthyThreshold].is_a? Integer },
         },
         description: ""

property :instance_configuration, Hash,
         callbacks: {
           "Subproperty `Cpu` is not a String" => lambda { |v| v[:Cpu].is_a? String },
           "Subproperty `Cpu` needs to be 3..9 characters" => lambda { |v| v[:Cpu].length >= 3 && v[:Cpu].length <= 9 },
           "Subproperty `Cpu` must match pattern 256|512|1024|2048|4096|(0.25|0.5|1|2|4) vCPU" => lambda { |v| v[:Cpu] =~ Regexp.new("/256|512|1024|2048|4096|(0.25|0.5|1|2|4) vCPU/") },
           "Subproperty `Memory` is not a String" => lambda { |v| v[:Memory].is_a? String },
           "Subproperty `Memory` needs to be 3..6 characters" => lambda { |v| v[:Memory].length >= 3 && v[:Memory].length <= 6 },
           "Subproperty `Memory` must match pattern 512|1024|2048|3072|4096|6144|8192|10240|12288|(0.5|1|2|3|4|6|8|10|12) GB" => lambda { |v| v[:Memory] =~ Regexp.new("/512|1024|2048|3072|4096|6144|8192|10240|12288|(0.5|1|2|3|4|6|8|10|12) GB/") },
         },
         description: ""

property :network_configuration, Hash,
         description: ""

property :observability_configuration, Hash,
         callbacks: {
           "Subproperty `ObservabilityEnabled` is not a Boolean" => lambda { |v| v[:ObservabilityEnabled].is_a? Boolean },
           "Subproperty `ObservabilityConfigurationArn` is not a String" => lambda { |v| v[:ObservabilityConfigurationArn].is_a? String },
           "Subproperty `ObservabilityConfigurationArn` needs to be 1..1011 characters" => lambda { |v| v[:ObservabilityConfigurationArn].length >= 1 && v[:ObservabilityConfigurationArn].length <= 1011 },
           "Subproperty `ObservabilityConfigurationArn` must match pattern arn:aws(-[\w]+)*:[a-z0-9-\.]{0,63}:[a-z0-9-\.]{0,63}:[0-9]{12}:(\w|/|-){1,1011}" => lambda { |v| v[:ObservabilityConfigurationArn] =~ Regexp.new("/arn:aws(-[\w]+)*:[a-z0-9-\.]{0,63}:[a-z0-9-\.]{0,63}:[0-9]{12}:(\w|/|-){1,1011}/") },
           "Subproperty `ObservabilityConfigurationArn`is not a valid ARN" => lambda { |v| v[:ObservabilityConfigurationArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
         },
         description: ""

property :service_name, String,
         callbacks: {
           "service_name is not a String" => lambda { |v| v.is_a? String },
           "service_name needs to be 4..40 characters" => lambda { |v| v.length >= 4 && v.length <= 40 },
           "service_name must match pattern [A-Za-z0-9][A-Za-z0-9-_]{3,39}" => lambda { |v| v =~ Regexp.new("/[A-Za-z0-9][A-Za-z0-9-_]{3,39}/") },
         },
         description: <<~'DESCRIPTION'
           The AppRunner Service Name.
         DESCRIPTION

property :source_configuration, Hash,
         required: true,
         callbacks: {
           "Subproperty `AutoDeploymentsEnabled` is not a Boolean" => lambda { |v| v[:AutoDeploymentsEnabled].is_a? Boolean },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::AppRunner::Service"
rest_api_document "/AWS::AppRunner::Service"

rest_property_map({
  autoscaling_configuration_arn: "AutoScalingConfigurationArn",
  encryption_configuration:      "EncryptionConfiguration",
  health_check_configuration:    "HealthCheckConfiguration",
  instance_configuration:        "InstanceConfiguration",
  network_configuration:         "NetworkConfiguration",
  observability_configuration:   "ObservabilityConfiguration",
  service_name:                  "ServiceName",
  source_configuration:          "SourceConfiguration",
  tags:                          "Tags",
})

rest_post_only_properties %i{
  encryption_configuration service_name tags
}
