# Import API specifics
use "awscc_base"

resource_name :aws_shield_protection_group
provides :aws_shield_protection_group, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  A grouping of protected resources so they can be handled as a collective. This resource grouping improves the accuracy of detection and reduces false positives.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :aggregation, String,
         required: true,
         callbacks: {
           "aggregation is not a String" => lambda { |v| v.is_a? String },
           "aggregationis not one of `SUM`, `MEAN`, `MAX`" => lambda { |v| %w{SUM MEAN MAX}.include? v },
         },
         description: <<~'DESCRIPTION'
           Defines how AWS Shield combines resource data for the group in order to detect, mitigate, and report events.
      * Sum - Use the total traffic across the group. This is a good choice for most cases. Examples include Elastic IP addresses for EC2 instances that scale manually or automatically.
      * Mean - Use the average of the traffic across the group. This is a good choice for resources that share traffic uniformly. Examples include accelerators and load balancers.
      * Max - Use the highest traffic from each resource. This is useful for resources that don't share traffic and for resources that share that traffic in a non-uniform way. Examples include Amazon CloudFront and origin resources for CloudFront distributions.
         DESCRIPTION

property :members, Array,
         callbacks: {
           "members is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Names (ARNs) of the resources to include in the protection group. You must set this when you set `Pattern` to `ARBITRARY` and you must not set it for any other `Pattern` setting.
         DESCRIPTION

property :pattern, String,
         required: true,
         callbacks: {
           "pattern is not a String" => lambda { |v| v.is_a? String },
           "patternis not one of `ALL`, `ARBITRARY`, `BY_RESOURCE_TYPE`" => lambda { |v| %w{ALL ARBITRARY BY_RESOURCE_TYPE}.include? v },
         },
         description: <<~'DESCRIPTION'
           The criteria to use to choose the protected resources for inclusion in the group. You can include all resources that have protections, provide a list of resource Amazon Resource Names (ARNs), or include all resources of a specified resource type.
         DESCRIPTION

property :protection_group_id, String,
         required: true,
         callbacks: {
           "protection_group_id is not a String" => lambda { |v| v.is_a? String },
           "protection_group_id needs to be 1..36 characters" => lambda { |v| v.length >= 1 && v.length <= 36 },
           "protection_group_id must match pattern [a-zA-Z0-9\-]*" => lambda { |v| v =~ Regexp.new("/[a-zA-Z0-9\-]*/") },
         },
         description: <<~'DESCRIPTION'
           The name of the protection group. You use this to identify the protection group in lists and to manage the protection group, for example to update, delete, or describe it.
         DESCRIPTION

property :resource_type, String,
         callbacks: {
           "resource_type is not a String" => lambda { |v| v.is_a? String },
           "resource_typeis not one of `CLOUDFRONT_DISTRIBUTION`, `ROUTE_53_HOSTED_ZONE`, `ELASTIC_IP_ALLOCATION`, `CLASSIC_LOAD_BALANCER`, `APPLICATION_LOAD_BALANCER`, `GLOBAL_ACCELERATOR`" => lambda { |v| %w{CLOUDFRONT_DISTRIBUTION ROUTE_53_HOSTED_ZONE ELASTIC_IP_ALLOCATION CLASSIC_LOAD_BALANCER APPLICATION_LOAD_BALANCER GLOBAL_ACCELERATOR}.include? v },
         },
         description: <<~'DESCRIPTION'
           The resource type to include in the protection group. All protected resources of this type are included in the protection group. Newly protected resources of this type are automatically added to the group. You must set this when you set `Pattern` to `BY_RESOURCE_TYPE` and you must not set it for any other `Pattern` setting.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           One or more tag key-value pairs for the Protection object.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Shield::ProtectionGroup"
rest_api_document "/AWS::Shield::ProtectionGroup"

rest_property_map({
  aggregation:         "Aggregation",
  members:             "Members",
  pattern:             "Pattern",
  protection_group_id: "ProtectionGroupId",
  resource_type:       "ResourceType",
  tags:                "Tags",
})

rest_post_only_properties %i{
  protection_group_id
}
