
# Terraformer AWS Migration Project

## Project Purpose

This project uses **Terraformer**, a tool designed to automate the process of importing existing infrastructure resources into Terraform configuration files. It simplifies the migration of existing infrastructure to Terraform and facilitates the management of infrastructure as code. By using **Terraformer**, you can easily generate Terraform code for various AWS resources such as EC2 instances, VPCs, subnets, S3 buckets, DynamoDB tables, and more.

With **Terraformer**, you can:

- Import AWS resources into Terraform configuration files without having to manually write all the Terraform code.
- Quickly convert your existing AWS infrastructure into infrastructure as code (IaC) using Terraform.
- Make changes, version control, and manage infrastructure more effectively with Terraform’s state and configuration files.
- Save time when managing cloud resources by automating the infrastructure import process.

This project aims to automate the process of converting AWS resources into a Terraform-managed infrastructure, making it easier for developers and system administrators to manage and version control their cloud architecture.

## Installation Instructions

To get started with this project, follow the steps below to install **Terraformer**, **AWS CLI**, and **Terraform** on your Linux machine. Additionally, we'll show how to create a new IAM user for Terraform to interact with AWS.

### Prerequisites

- A Linux-based system.
- **AWS credentials** for accessing your AWS resources.
- **Terraform** installed and configured.

### Step 1: Install AWS CLI

The AWS Command Line Interface (CLI) allows you to interact with AWS services from your terminal.

1. Install the AWS CLI using the following command:

   ```bash
   sudo apt update
   sudo apt install awscli
   ```

2. Once the installation is complete, verify the AWS CLI version:

   ```bash
   aws --version
   ```

3. Configure the AWS CLI with your AWS credentials:

   ```bash
   aws configure
   ```

   You will be prompted to enter the following information:
   - **AWS Access Key ID**: (Generated from the AWS IAM user or root account)
   - **AWS Secret Access Key**: (Generated from the AWS IAM user or root account)
   - **Default region name**: For example, `us-east-1`
   - **Default output format**: For example, `json`

### Step 2: Install Terraform

**Terraform** is used to define, manage, and provision AWS resources as code.

1. Download and install Terraform:

   ```bash
   sudo apt-get update && sudo apt-get install -y wget unzip
   wget https://releases.hashicorp.com/terraform/1.6.1/terraform_1.6.1_linux_amd64.zip
   unzip terraform_1.6.1_linux_amd64.zip
   sudo mv terraform /usr/local/bin/
   ```

2. Verify the Terraform installation:

   ```bash
   terraform --version
   ```

   You should see the installed version of Terraform.

### Step 3: Add a New IAM User for Terraform

To securely interact with AWS using Terraform, it’s recommended to create a new IAM user with limited permissions.

1. Log into the AWS Management Console.

2. Navigate to **IAM** (Identity and Access Management) and click on **Users**.

3. Click **Add user**. Provide a **Username**, e.g., `terraform-user`.

4. Select **Programmatic access** as the access type.

5. Click **Next: Permissions**. Select **Attach policies directly**.

   - Choose the **AdministratorAccess** policy for full access to AWS resources. Alternatively, you can assign specific permissions based on the resources Terraform needs to manage.

6. Review the configuration and click **Create user**.

7. Once created, note the **Access key ID** and **Secret access key** for the new IAM user. You will use these credentials to configure AWS CLI.

### Step 4: Configure AWS CLI for New IAM User

1. Run the `aws configure` command again, but this time use the newly created IAM user’s access keys:

   ```bash
   aws configure
   ```

   Enter the following when prompted:
   - **AWS Access Key ID**: Enter the Access Key ID from the new IAM user.
   - **AWS Secret Access Key**: Enter the Secret Access Key from the new IAM user.
   - **Default region name**: Example: `us-east-1`
   - **Default output format**: `json`

### Step 5: Download and Install Terraformer

1. Download the latest release of `terraformer-all-linux-amd64` (410 MB) from the official GitHub repository:

   [Download Terraformer](https://github.com/GoogleCloudPlatform/terraformer/releases/download/v0.8.20/terraformer-all-linux-amd64)

   Or use `wget` to download it:

   ```bash
   wget https://github.com/GoogleCloudPlatform/terraformer/releases/download/v0.8.20/terraformer-all-linux-amd64
   ```

2. Move the file to the appropriate directory and rename it:

   ```bash
   mv terraformer-all-linux-amd64 /usr/local/bin/terraformer
   ```

3. Make the binary executable:

   ```bash
   chmod +x /usr/local/bin/terraformer
   ```

4. Verify the installation:

   ```bash
   terraformer --version
   ```

   This should display the version of Terraformer.

### Step 6: Verify the Complete Setup

To verify the complete setup and ensure everything is working correctly, follow these steps:

1. Check AWS CLI configuration:

   Run the following command to check if the AWS CLI is configured correctly:

   ```bash
   aws sts get-caller-identity
   ```

   This should return the IAM user’s identity.

2. Check Terraform installation:

   Run the following command to verify Terraform:

   ```bash
   terraform --version
   ```

   This should return the installed version of Terraform.

3. Run a Terraformer import:

   You can now use Terraformer to import AWS resources. For example, to import EC2 instances, S3 buckets, DynamoDB, VPC, and subnets, run the following command:

   ```bash
   terraformer import aws --resources=ec2,db,s3,vpc,subnet --region=us-east-1
   ```

   This will generate Terraform configuration files in the current directory.

4. Validate Terraform configuration:

   You can use the following command to validate your Terraform configuration:

   ```bash
   terraform init
   terraform plan
   ```

   This will initialize the Terraform configuration and show a plan of the infrastructure changes.

---

With these steps, your system will be ready to use **Terraform**, **AWS CLI**, and **Terraformer** to manage AWS resources as Infrastructure as Code (IaC).
