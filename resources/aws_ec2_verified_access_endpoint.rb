# Import API specifics
use "awscc_base"

resource_name :aws_ec2_verified_access_endpoint
provides :aws_ec2_verified_access_endpoint, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  The AWS::EC2::VerifiedAccessEndpoint resource creates an AWS EC2 Verified Access Endpoint.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :application_domain, String,
         required: true,
         callbacks: {
           "application_domain is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The DNS name for users to reach your application.
         DESCRIPTION

property :attachment_type, String,
         required: true,
         callbacks: {
           "attachment_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The type of attachment used to provide connectivity between the AWS Verified Access endpoint and the application.
         DESCRIPTION

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A description for the AWS Verified Access endpoint.
         DESCRIPTION

property :domain_certificate_arn, String,
         required: true,
         callbacks: {
           "domain_certificate_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ARN of a public TLS/SSL certificate imported into or created with ACM.
         DESCRIPTION

property :endpoint_domain_prefix, String,
         required: true,
         callbacks: {
           "endpoint_domain_prefix is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A custom identifier that gets prepended to a DNS name that is generated for the endpoint.
         DESCRIPTION

property :endpoint_type, String,
         required: true,
         callbacks: {
           "endpoint_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The type of AWS Verified Access endpoint. Incoming application requests will be sent to an IP address, load balancer or a network interface depending on the endpoint type specified.The type of AWS Verified Access endpoint. Incoming application requests will be sent to an IP address, load balancer or a network interface depending on the endpoint type specified.
         DESCRIPTION

property :load_balancer_options, Hash,
         callbacks: {
           "Subproperty `LoadBalancerArn` is not a String" => lambda { |v| v[:LoadBalancerArn].is_a? String },
           "Subproperty `LoadBalancerArn`is not a valid ARN" => lambda { |v| v[:LoadBalancerArn] =~ Regexp.new("^arn:aws(?:-cn|-us-gov)?:([^:]*:){3,}") },
           "Subproperty `Port` is not a Integer" => lambda { |v| v[:Port].is_a? Integer },
           "Subproperty `Protocol` is not a String" => lambda { |v| v[:Protocol].is_a? String },
           "Subproperty `SubnetIds` is not a Array" => lambda { |v| v[:SubnetIds].is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The load balancer details if creating the AWS Verified Access endpoint as load-balancer type.
         DESCRIPTION

property :network_interface_options, Hash,
         callbacks: {
           "Subproperty `NetworkInterfaceId` is not a String" => lambda { |v| v[:NetworkInterfaceId].is_a? String },
           "Subproperty `Port` is not a Integer" => lambda { |v| v[:Port].is_a? Integer },
           "Subproperty `Protocol` is not a String" => lambda { |v| v[:Protocol].is_a? String },
         },
         description: <<~'DESCRIPTION'
           The options for network-interface type endpoint.
         DESCRIPTION

property :policy_document, String,
         callbacks: {
           "policy_document is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The AWS Verified Access policy document.
         DESCRIPTION

property :policy_enabled, [TrueClass, FalseClass],
         callbacks: {
           "policy_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           The status of the Verified Access policy.
         DESCRIPTION

property :security_group_ids, Array,
         callbacks: {
           "security_group_ids is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The IDs of the security groups for the endpoint.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

property :verified_access_group_id, String,
         required: true,
         callbacks: {
           "verified_access_group_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The ID of the AWS Verified Access group.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::VerifiedAccessEndpoint"
rest_api_document "/AWS::EC2::VerifiedAccessEndpoint"

rest_property_map({
  application_domain:        "ApplicationDomain",
  attachment_type:           "AttachmentType",
  description:               "Description",
  domain_certificate_arn:    "DomainCertificateArn",
  endpoint_domain_prefix:    "EndpointDomainPrefix",
  endpoint_type:             "EndpointType",
  load_balancer_options:     "LoadBalancerOptions",
  network_interface_options: "NetworkInterfaceOptions",
  policy_document:           "PolicyDocument",
  policy_enabled:            "PolicyEnabled",
  security_group_ids:        "SecurityGroupIds",
  tags:                      "Tags",
  verified_access_group_id:  "VerifiedAccessGroupId",
})

rest_post_only_properties %i{
  application_domain attachment_type domain_certificate_arn endpoint_domain_prefix endpoint_type load_balancer_options/load_balancer_arn network_interface_options/network_interface_id security_group_ids
}
