 # Elastic Stack Infrastructure - Small

 This Terraform deployment will allow you to build the infrastructure required for a small sized Elasticsearch cluster, Logstash and Kibana. The infrastructure is hosted in your own private VPC on AWS. 

 The infrastructure contains:
 * 3 x Servers across 3 availability zones - to be used for running an Elasticsearch cluster
 * 1 x Server to be used for running Kibana
 * 1 x Server to be used for running Logstash

 To begin using this Terraform deployment, clone or fork this repository. Terraform (>=0.12.0) is required to be installed and prior setup of AWS credentials (configure credentials using [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html) or follow the instructions from Hashicorp on [AWS Authentication](https://www.terraform.io/docs/providers/aws/index.html#authentication)). Direct internet access is also required for managing infrastructure on AWS.
 
 Once the repo is local, you will need to:
 1. Run `terraform init` in the root directory of the repository. This will initialise terraform and download the AWS provider module.
 2. Initialise input variables. You can do this either of two ways:
   * Specify each required variable at the command line as prompted when you run `terraform plan` or `terraform apply`.
   * Create a tfvars file following the schema provided in the example.tfvars file found in the repository. 
 3. Run `terraform apply`, check the deployment plan to ensure you have the correct setup and follow the prompt from terraform.

 That's it!!

 You now have a set of infrastructure ready to have the Elastic Stack installed.

