# Import API specifics
use "awscc_base"

resource_name :aws_vpc_lattice_access_log_subscription
provides :aws_vpc_lattice_access_log_subscription, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Enables access logs to be sent to Amazon CloudWatch, Amazon S3, and Amazon Kinesis Data Firehose. The service network owner can use the access logs to audit the services in the network. The service network owner will only see access logs from clients and services that are associated with their service network. Access log entries represent traffic originated from VPCs associated with that network.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :destination_arn, String,
         required: true,
         callbacks: {
           "destination_arn is not a String" => lambda { |v| v.is_a? String },
           "destination_arn needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "destination_arn must match pattern ^arn(:[a-z0-9]+([.-][a-z0-9]+)*){2}(:([a-z0-9]+([.-][a-z0-9]+)*)?){2}:([^/].*)?$" => lambda { |v| v =~ Regexp.new("/^arn(:[a-z0-9]+([.-][a-z0-9]+)*){2}(:([a-z0-9]+([.-][a-z0-9]+)*)?){2}:([^/].*)?$/") },
         },
         description: ""

property :resource_identifier, String,
         callbacks: {
           "resource_identifier is not a String" => lambda { |v| v.is_a? String },
           "resource_identifier needs to be 20..2048 characters" => lambda { |v| v.length >= 20 && v.length <= 2048 },
           "resource_identifier must match pattern ^((((sn)|(svc))-[0-9a-z]{17})|(arn(:[a-z0-9]+([.-][a-z0-9]+)*){2}(:([a-z0-9]+([.-][a-z0-9]+)*)?){2}:((servicenetwork/sn)|(service/svc))-[0-9a-z]{17}))$" => lambda { |v| v =~ Regexp.new("/^((((sn)|(svc))-[0-9a-z]{17})|(arn(:[a-z0-9]+([.-][a-z0-9]+)*){2}(:([a-z0-9]+([.-][a-z0-9]+)*)?){2}:((servicenetwork/sn)|(service/svc))-[0-9a-z]{17}))$/") },
         },
         description: ""

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: ""

# API URLs and mappings
rest_api_collection "/AWS::VpcLattice::AccessLogSubscription"
rest_api_document "/AWS::VpcLattice::AccessLogSubscription"

rest_property_map({
  destination_arn:     "DestinationArn",
  resource_identifier: "ResourceIdentifier",
  tags:                "Tags",
})

rest_post_only_properties %i{
  resource_identifier
}
