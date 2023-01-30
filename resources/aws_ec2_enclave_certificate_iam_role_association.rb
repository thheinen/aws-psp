# Import API specifics
use "awscc_base"

resource_name :aws_ec2_enclave_certificate_iam_role_association
provides :aws_ec2_enclave_certificate_iam_role_association, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Associates an AWS Identity and Access Management (IAM) role with an AWS Certificate Manager (ACM) certificate. This association is based on Amazon Resource Names and it enables the certificate to be used by the ACM for Nitro Enclaves application inside an enclave.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :certificate_arn, String,
         required: true,
         callbacks: {
           "certificate_arn is not a String" => lambda { |v| v.is_a? String },
           "certificate_arn needs to be 1..1283 characters" => lambda { |v| v.length >= 1 && v.length <= 1283 },
           "certificate_arn must match pattern ^arn:aws[A-Za-z0-9-]{0,64}:acm:[A-Za-z0-9-]{1,64}:([0-9]{12})?:certificate/.+$" => lambda { |v| v =~ Regexp.new("/^arn:aws[A-Za-z0-9-]{0,64}:acm:[A-Za-z0-9-]{1,64}:([0-9]{12})?:certificate/.+$/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the ACM certificate with which to associate the IAM role.
         DESCRIPTION

property :role_arn, String,
         required: true,
         callbacks: {
           "role_arn is not a String" => lambda { |v| v.is_a? String },
           "role_arn needs to be 1..1283 characters" => lambda { |v| v.length >= 1 && v.length <= 1283 },
           "role_arn must match pattern ^arn:aws[A-Za-z0-9-]{0,64}:iam:.*:([0-9]{12})?:role/.+$" => lambda { |v| v =~ Regexp.new("/^arn:aws[A-Za-z0-9-]{0,64}:iam:.*:([0-9]{12})?:role/.+$/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the IAM role to associate with the ACM certificate. You can associate up to 16 IAM roles with an ACM certificate.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::EnclaveCertificateIamRoleAssociation"
rest_api_document "/AWS::EC2::EnclaveCertificateIamRoleAssociation"

rest_property_map({
  certificate_arn: "CertificateArn",
  role_arn:        "RoleArn",
})

rest_post_only_properties %i{
  certificate_arn role_arn
}
