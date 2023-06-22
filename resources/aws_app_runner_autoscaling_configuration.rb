# Import API specifics
use "awscc_base"

resource_name :aws_app_runner_autoscaling_configuration
provides :aws_app_runner_autoscaling_configuration, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Describes an AWS App Runner automatic configuration resource that enables automatic scaling of instances used to process web requests. You can share an auto scaling configuration across multiple services.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :autoscaling_configuration_name, String,
         callbacks: {
           "autoscaling_configuration_name is not a String" => lambda { |v| v.is_a? String },
           "autoscaling_configuration_name needs to be 4..32 characters" => lambda { |v| v.length >= 4 && v.length <= 32 },
           "autoscaling_configuration_name must match pattern [A-Za-z0-9][A-Za-z0-9\-_]{3,31}" => lambda { |v| v =~ Regexp.new("/[A-Za-z0-9][A-Za-z0-9\-_]{3,31}/") },
         },
         description: <<~'DESCRIPTION'
           The customer-provided auto scaling configuration name.  When you use it for the first time in an AWS Region, App Runner creates revision number 1 of this name. When you use the same name in subsequent calls, App Runner creates incremental revisions of the configuration. The auto scaling configuration name can be used in multiple revisions of a configuration.
         DESCRIPTION

property :max_concurrency, Integer,
         callbacks: {
           "max_concurrency is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The maximum number of concurrent requests that an instance processes. If the number of concurrent requests exceeds this limit, App Runner scales the service up to use more instances to process the requests.
         DESCRIPTION

property :max_size, Integer,
         callbacks: {
           "max_size is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The maximum number of instances that an App Runner service scales up to. At most MaxSize instances actively serve traffic for your service.
         DESCRIPTION

property :min_size, Integer,
         callbacks: {
           "min_size is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The minimum number of instances that App Runner provisions for a service. The service always has at least MinSize provisioned instances. Some of them actively serve traffic. The rest of them (provisioned and inactive instances) are a cost-effective compute capacity reserve and are ready to be quickly activated. You pay for memory usage of all the provisioned instances. You pay for CPU usage of only the active subset.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           A list of metadata items that you can associate with your auto scaling configuration resource. A tag is a key-value pair.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::AppRunner::AutoScalingConfiguration"
rest_api_document "/AWS::AppRunner::AutoScalingConfiguration"

rest_property_map({
  autoscaling_configuration_name: "AutoScalingConfigurationName",
  max_concurrency:                "MaxConcurrency",
  max_size:                       "MaxSize",
  min_size:                       "MinSize",
  tags:                           "Tags",
})

rest_post_only_properties %i{
  autoscaling_configuration_name max_concurrency max_size min_size tags
}
