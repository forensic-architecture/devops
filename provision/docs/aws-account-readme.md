# Amazon Web Services (AWS) 

[Amazon Web Services](https://aws.amazon.com/) provide a range of services including infrastructure. With the Terraform scripts included here you can automatically create:

* EC2 instance to run Time Map and Datasheet server on
* S3 Bucket for images and other resources

## Signup for an AWS cloud account

To use AWS infrastructure you need an AWS account. The AWS free tier that will be adequate for most needs but they still need credit card details to sign up. Full instructions here: [Create and Activate an AWS Account](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/)

### Generate an AWS Keypair

For Terraform to provision the AWS infrastructure it needs to be able to talk to the EC2 instance you create. To do that it needs a security key pair. For instructions see here: [Amazon EC2 key pairs and Linux instances - Amazon Elastic Compute Cloud](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#having-ec2-create-your-key-pair)

Be careful to secure the key you download with:

```
chmod 600 ./your-key-location/forensic-architecture-admin.pem
```

## Dependency - AWS CLI

For Terraform to run you also need to install the AWS CLI following the instructions here: [Installing the AWS CLI version 2 - AWS Command Line Interface](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

## Configure the CLI

The AWS CLI needs to be configured with security credentials so it can connect to your AWS account.

Follow the instructions here: [Configuring the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html) and for the AWS Credentials pay special attention to the section 'To create access keys for an IAM user'.

You should now be able to follow the instructions in [terraform_readme.md](terraform_readme.md) to provision your infrastructure. 

## Storage Buckets - Syncing Content 

With the aws CLI installed you can upload and sync files directly from your file system.

### Upload

To upload everything in the current directory run the following command: 

```
aws s3 cp your-directory-name s3://forensic-architecture-bucket --recursive
```

### Sync

To synchronise everything in the current directory (upload and download anything already there) run the following command:

```
aws s3 sync . s3://forensic-architecture-bucket
```

For more information see: [https://docs.aws.amazon.com/cli/latest/reference/s3/sync.html](https://docs.aws.amazon.com/cli/latest/reference/s3/sync.html)
