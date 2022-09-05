# Import API specifics
use "awscc_base"

unified_mode true
resource_name :aws_apigateway_client_certificate
provides :aws_apigateway_client_certificate, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::ApiGateway::ClientCertificate
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :description, String,
         callbacks: {
           "description is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           A description of the client certificate.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of arbitrary tags (key-value pairs) to associate with the client certificate.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::ApiGateway::ClientCertificate"
rest_api_document "/AWS::ApiGateway::ClientCertificate"

rest_property_map({
  description: "Description",
  tags:        "Tags",
})

