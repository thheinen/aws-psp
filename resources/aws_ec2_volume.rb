# Import API specifics
use "awscc_base"

resource_name :aws_ec2_volume
provides :aws_ec2_volume, target_mode: true, platform: "aws"

description <<~DESCRIPTION
  Resource Type definition for AWS::EC2::Volume
DESCRIPTION

property :name, String,
         name_property: true,
         description: "Name of the resource, not desired state"

property :auto_enable_io, [TrueClass, FalseClass],
         callbacks: {
           "auto_enable_io is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           The Availability Zone in which to create the volume.
         DESCRIPTION

property :availability_zone, String,
         required: true,
         callbacks: {
           "availability_zone is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Availability Zone in which to create the volume.
         DESCRIPTION

property :encrypted, [TrueClass, FalseClass],
         callbacks: {
           "encrypted is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Specifies whether the volume should be encrypted. The effect of setting the encryption state to true depends on the volume origin (new or from a snapshot), starting encryption state, ownership, and whether encryption by default is enabled. For more information, see Encryption by default in the Amazon Elastic Compute Cloud User Guide. Encrypted Amazon EBS volumes must be attached to instances that support Amazon EBS encryption. For more information, see Supported instance types.
         DESCRIPTION

property :iops, Integer,
         callbacks: {
           "iops is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The number of I/O operations per second (IOPS) to provision for an io1 or io2 volume, with a maximum ratio of 50 IOPS/GiB for io1, and 500 IOPS/GiB for io2. Range is 100 to 64,000 IOPS for volumes in most Regions. Maximum IOPS of 64,000 is guaranteed only on Nitro-based instances. Other instance families guarantee performance up to 32,000 IOPS. For more information, see Amazon EBS volume types in the Amazon Elastic Compute Cloud User Guide. This parameter is valid only for Provisioned IOPS SSD (io1 and io2) volumes.
         DESCRIPTION

property :kms_key_id, String,
         callbacks: {
           "kms_key_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The identifier of the AWS Key Management Service (AWS KMS) customer master key (CMK) to use for Amazon EBS encryption. If KmsKeyId is specified, the encrypted state must be true. If you omit this property and your account is enabled for encryption by default, or Encrypted is set to true, then the volume is encrypted using the default CMK specified for your account. If your account does not have a default CMK, then the volume is encrypted using the AWS managed CMK.  Alternatively, if you want to specify a different CMK, you can specify one of the following:  Key ID. For example, 1234abcd-12ab-34cd-56ef-1234567890ab. Key alias. Specify the alias for the CMK, prefixed with alias/. For example, for a CMK with the alias my_cmk, use alias/my_cmk. Or to specify the AWS managed CMK, use alias/aws/ebs. Key ARN. For example, arn:aws:kms:us-east-1:012345678910:key/1234abcd-12ab-34cd-56ef-1234567890ab. Alias ARN. For example, arn:aws:kms:us-east-1:012345678910:alias/ExampleAlias.
         DESCRIPTION

property :multi_attach_enabled, [TrueClass, FalseClass],
         callbacks: {
           "multi_attach_enabled is not a Boolean" => lambda { |v| v.is_a? Boolean },
         },
         description: <<~'DESCRIPTION'
           Indicates whether Amazon EBS Multi-Attach is enabled.
         DESCRIPTION

property :outpost_arn, String,
         callbacks: {
           "outpost_arn is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The Amazon Resource Name (ARN) of the Outpost.
         DESCRIPTION

property :size, Integer,
         callbacks: {
           "size is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The size of the volume, in GiBs. You must specify either a snapshot ID or a volume size.  Constraints: 1-16,384 for gp2, 4-16,384 for io1 and io2, 500-16,384 for st1, 500-16,384 for sc1, and 1-1,024 for standard. If you specify a snapshot, the volume size must be equal to or larger than the snapshot size. Default: If you're creating the volume from a snapshot and don't specify a volume size, the default is the snapshot size.
         DESCRIPTION

property :snapshot_id, String,
         callbacks: {
           "snapshot_id is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The snapshot from which to create the volume. You must specify either a snapshot ID or a volume size.
         DESCRIPTION

property :tags, Array,
         callbacks: {
           "tags is not a Array" => lambda { |v| v.is_a? Array },
         },
         description: <<~'DESCRIPTION'
           The tags to apply to the volume during creation.
         DESCRIPTION

property :throughput, Integer,
         callbacks: {
           "throughput is not a Integer" => lambda { |v| v.is_a? Integer },
         },
         description: <<~'DESCRIPTION'
           The throughput that the volume supports, in MiB/s.
         DESCRIPTION

property :volume_type, String,
         callbacks: {
           "volume_type is not a String" => lambda { |v| v.is_a? String },
         },
         description: <<~'DESCRIPTION'
           The volume type. This parameter can be one of the following values: General Purpose SSD: gp2 | gp3, Provisioned IOPS SSD: io1 | io2, Throughput Optimized HDD: st1, Cold HDD: sc1, Magnetic: standard
         DESCRIPTION

# API URLs and mappings
rest_api_collection "/AWS::EC2::Volume"
rest_api_document "/AWS::EC2::Volume"

rest_property_map({
  auto_enable_io:       "AutoEnableIO",
  availability_zone:    "AvailabilityZone",
  encrypted:            "Encrypted",
  iops:                 "Iops",
  kms_key_id:           "KmsKeyId",
  multi_attach_enabled: "MultiAttachEnabled",
  outpost_arn:          "OutpostArn",
  size:                 "Size",
  snapshot_id:          "SnapshotId",
  tags:                 "Tags",
  throughput:           "Throughput",
  volume_type:          "VolumeType",
})

