# Import API specifics
use "awscc_base"

resource_name :aws_redshift_endpoint_authorization
provides :aws_redshift_endpoint_authorization, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Describes an endpoint authorization for authorizing Redshift-managed VPC endpoint access to a cluster across AWS accounts.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :account, Hash,
         required: true,
         callbacks: {
           "account is not a String" => lambda { |v| v.is_a? String },
           "account must match pattern ^\d{12}$" => lambda { |v| v =~ Regexp.new("/^\d{12}$/") },
         },
         description: <<~'DESCRIPTION'
           The target AWS account ID to grant or revoke access for.
         DESCRIPTION

property :cluster_identifier, String,
         required: true,
         callbacks: {
           "cluster_identifier is not a String" => lambda { |v| v.is_a? String },
           "cluster_identifier must match pattern ^(?=^[a-z][a-z0-9]*(-[a-z0-9]+)*$).{1,63}$" => lambda { |v| v =~ Regexp.new("/^(?=^[a-z][a-z0-9]*(-[a-z0-9]+)*$).{1,63}$/") },
         },
         description: <<~'DESCRIPTION'
           The cluster identifier.
         DESCRIPTION

property :force, [TrueClass, FalseClass],
         callbacks: {
           "force is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Indicates whether to force the revoke action. If true, the Redshift-managed VPC endpoints associated with the endpoint authorization are also deleted.
         DESCRIPTION

property :vpc_ids, Array,
         callbacks: {
           "vpc_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The virtual private cloud (VPC) identifiers to grant or revoke access to.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::Redshift::EndpointAuthorization"
rest_api_document "/AWS::Redshift::EndpointAuthorization"

rest_property_map({
  account:            "Account",
  cluster_identifier: "ClusterIdentifier",
  force:              "Force",
  vpc_ids:            "VpcIds",
})

rest_post_only_properties %i{
  account cluster_identifier
}
