#===================== Naming conventions =====================#
# We follow the cloudposse naming conventions plugin:
# See https://github.com/cloudposse/terraform-null-label

variable "namespace" {
  type        = "string"
  description = "Namespace, which could be your organization name, e.g. 'zen' or 'zencargo'"
  default     = "zen"
}

variable "stage" {
  type        = "string"
  description = "Stage, e.g. 'prod', 'staging', 'dev', or 'test'"
  default     = "stage"
}

variable "name" {
  description = "A unique name for this solution."
}

variable "attributes" {
  type        = "list"
  default     = ["bi"]
  description = "Additional attributes (e.g. `policy` or `role`)"
}

variable "delimiter" {
  type        = "string"
  default     = "-"
  description = "Delimiter to be used between `name`, `namespace`, `stage`, etc."
}

variable "tags" {
  type        = "map"
  default     = {
    "Unit"       = "reporting"
    "Department" = "business intelligence"
  }
  description = "Additional tags (e.g. `map('Key1','Value1')`)"
}

#===================== Provider defaults =====================#
variable "region" {
  type        = "string"
  default     = "eu-west-1"
  description = "The geographical region in AWS"
}

variable "profile" {
  type = "string"
  description = "The AWS credentials profile to use"
}

variable "cidr_block" {
  default     = "10.0.0.0/16"
  description = "CIDR block configuration"
}
#===================== Domain Setup =====================#
variable "zone_id" {
  description = "Route53 zone ID. For more info see https://docs.aws.amazon.com/general/latest/gr/rande.html."
  type = "string"
}

#============ Elastic Beanstalk environment ============#
variable "description" {
  type        = "string"
  default     = "Docker container running on Elastic Benastalk"
  description = "Will be used as Elastic Beanstalk application description"
}

variable "ssh_key_pair" {
  type        = "string"
  default     = ""
  description = "Name of SSH key that will be deployed on Elastic Beanstalk and DataPipeline instance. The key should be present in AWS"
}

variable "solution_stack_name" {
  description = "Elastic Beanstalk stack, e.g. Docker, Go, Node, Java, IIS. For more info: http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/concepts.platforms.html"
  default     = "64bit Amazon Linux 2018.03 v2.11.0 running Docker 18.03.1-ce"
}

variable "loadbalancer_type" {
  default     = "classic"
  description = "Load Balancer type, e.g. 'application' or 'classic'"
}

variable "loadbalancer_certificate_arn" {
  default     = ""
  type        = "string"
  description = "Load Balancer SSL certificate ARN. The certificate must be present in AWS Certificate Manager"
}

variable "instance_type" {
  description = "The instance type used to run your application in an Elastic Beanstalk environment."
  default     = "t2.small"
}

variable "security_groups" {
  type        = "list"
  default     = []
  description = "List of security groups to be allowed to connect to the EC2 instances"
}

variable "healthcheck_url" {
  description = "The path to which to send health check requests."
  default     = "/"
}

#===================== RDS setup =====================#
variable "rds_allocated_storage" {
  description = "rds_allocated_storage"
  default     = "100"
}

variable "rds_engine" {
  description = "rds_engine"
  default     = "postgres"
}

variable "rds_instance_class" {
  description = "rds_instance_class"
  default     = "db.m4.large"
}

variable "rds_multi_az" {
  description = "rds_multi_az"
  default     = true
}

variable "rds_parameter_group" {
  description = "rds_parameter_group"
  default     = "postgres9.6"
}

variable "rds_parameter_group_name" {
  description = "rds_parameter_group_name"
  default     = "default.postgres9.6"
}

variable "rds_password" {
  description = "rds_password"
}

variable "rds_port" {
  description = "rds_port"
  default     = "5432"
}

variable "rds_snapshot_name" {
  description = "rds_snapshot_name"
  default     = "2018-08-03"
}

variable "rds_storage_encrypted" {
  description = "rds_storage_encrypted"
  default     = true
}

variable "rds_storage_type" {
  description = "rds_storage_type"
  default     = "gp2"
}

variable "rds_version" {
  description = "rds_version"
  default     = "9.6.6"
}

variable "rds_snapshot_identifier" {
  default     = ""
  description = "When provided, that snapshot will be restored."
}

# VPC peering setup
variable "acceptor_vpc_id" {
  type        = "string"
  description = "ID of the VPC to accept from: vpc-e2872285"
}
