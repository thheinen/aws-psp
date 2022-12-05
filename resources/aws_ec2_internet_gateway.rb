# Import API specifics
use "awscc_base"

resource_name :aws_ec2_internet_gateway
provides :aws_ec2_internet_gateway, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::InternetGateway
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           Any tags to assign to the internet gateway.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::InternetGateway"
rest_api_document "/AWS::EC2::InternetGateway"

rest_property_map({
  tags: "Tags",
})

