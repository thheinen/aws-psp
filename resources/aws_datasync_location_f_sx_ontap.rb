# Import API specifics
use "awscc_base"

resource_name :aws_datasync_location_f_sx_ontap
provides :aws_datasync_location_f_sx_ontap, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource schema for AWS::DataSync::LocationFSxONTAP.
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :protocol, Hash,
         description: ""

property :security_group_arns, Array,
         required: true,
         callbacks: {
           "security_group_arns is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The ARNs of the security groups that are to use to configure the FSx ONTAP file system.
         DESCRIPTION

property :storage_virtual_machine_arn, String,
         required: true,
         callbacks: {
           "storage_virtual_machine_arn is not a String" => lambda { |v| v.is_a? String },
           "storage_virtual_machine_arn must match pattern ^arn:(aws|aws-cn|aws-us-gov|aws-iso|aws-iso-b):fsx:[a-z\-0-9]+:[0-9]{12}:storage-virtual-machine/fs-[0-9a-f]+/svm-[0-9a-f]{17,}$" => lambda { |v| v =~ Regexp.new("/^arn:(aws|aws-cn|aws-us-gov|aws-iso|aws-iso-b):fsx:[a-z\-0-9]+:[0-9]{12}:storage-virtual-machine/fs-[0-9a-f]+/svm-[0-9a-f]{17,}$/") },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) for the FSx ONTAP SVM.
         DESCRIPTION

property :subdirectory, String,
         callbacks: {
           "subdirectory is not a String" => lambda { |v| v.is_a? String },
           "subdirectory must match pattern ^[a-zA-Z0-9_\-\+\./\(\)\$\p{Zs}]+$" => lambda { |v| v =~ Regexp.new("/^[a-zA-Z0-9_\-\+\./\(\)\$\p{Zs}]+$/") },
         },
         description: <<~'DESCRIPTION'
           A subdirectory in the location's path.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           An array of key-value pairs to apply to this resource.
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::DataSync::LocationFSxONTAP"
rest_api_document "/AWS::DataSync::LocationFSxONTAP"

rest_property_map({
  protocol:                    "Protocol",
  security_group_arns:         "SecurityGroupArns",
  storage_virtual_machine_arn: "StorageVirtualMachineArn",
  subdirectory:                "Subdirectory",
  tags:                        "Tags",
})

rest_post_only_properties %i{
  protocol security_group_arns storage_virtual_machine_arn subdirectory
}
