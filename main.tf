provider "aws" {
  region                  = "${var.region}"
  shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
  profile                 = "${var.profile}"
}

terraform {
  backend "s3" {}
}

module "metabase_label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=master"
  namespace  = "eg"
  stage      = "prod"
  name       = "bastion"
  attributes = ["public"]
  delimiter  = "-"
  tags       = "${map("BusinessUnit", "XYZ", "Snapshot", "true")}"
}

variable "max_availability_zones" {
  default = "3"
}

data "aws_availability_zones" "available" {}

module "elastic_beanstalk_application" {
  source      = "git::https://github.com/cloudposse/terraform-aws-elastic-beanstalk-application.git?ref=tags/0.1.4"
  namespace   = "${var.namespace}"
  name        = "${var.name}"
  stage       = "${var.stage}"
  description = "${var.description}"
  attributes  = "${var.attributes}"
  tags        = "${var.tags}"
}

module "elastic_beanstalk_environment" {
  source        = "git::https://github.com/cloudposse/terraform-aws-elastic-beanstalk-environment.git?ref=tags/0.3.4"
  namespace     = "${var.namespace}"
  name          = "${var.name}"
  stage         = "${var.stage}"
  zone_id       = "${var.zone_id}"
  app           = "${module.elastic_beanstalk_application.app_name}"
  instance_type = "${var.instance_type}"
  # Set `min` and `max` number of running EC2 instances to `1` since we want only one Jenkins master running at any time
  autoscale_min = 1
  autoscale_max = 1
  # Since we set `autoscale_min = autoscale_max`, we need to set `updating_min_in_service` to 0 for the AutoScaling Group to work.
  # Elastic Beanstalk will terminate the master instance and replace it with a new one in case of any issues with it.
  updating_min_in_service = 0
  updating_max_batch = 1
  healthcheck_url              = "${var.healthcheck_url}"
  loadbalancer_type            = "${var.loadbalancer_type}"
  loadbalancer_certificate_arn = "${var.loadbalancer_certificate_arn}"
  vpc_id                       = "${module.vpc.vpc_id}"
  public_subnets               = "${module.subnets.public_subnet_ids}"
  private_subnets              = "${module.subnets.private_subnet_ids}"
  security_groups              = "${var.security_groups}"
  keypair                      = "${var.ssh_key_pair}"
  solution_stack_name          = "${var.solution_stack_name}"
  delimiter  = "${var.delimiter}"
  attributes = ["${compact(concat(var.attributes, list("eb-env")))}"]
  tags       = "${var.tags}"
  env_vars   = {
    "MB_DB_TYPE" = "postgres"
    "MB_DB_CONNECTION_URI" = "postgres://${var.name}:${var.rds_password}@${module.rds_instance.instance_endpoint}/${var.name}"
  }
}

module "vpc" {
  source     = "git::https://github.com/cloudposse/terraform-aws-vpc.git?ref=master"
  namespace  = "${var.namespace}"
  name       = "${var.name}"
  stage      = "${var.stage}"
  cidr_block = "10.0.0.0/16"
}

module "subnets" {
  source              = "git::https://github.com/cloudposse/terraform-aws-dynamic-subnets.git?ref=master"
  availability_zones  = ["${slice(data.aws_availability_zones.available.names, 0, var.max_availability_zones)}"]
  namespace           = "${var.namespace}"
  name                = "${var.name}"
  stage               = "${var.stage}"
  region              = "${var.region}"
  vpc_id              = "${module.vpc.vpc_id}"
  igw_id              = "${module.vpc.igw_id}"
  cidr_block          = "${module.vpc.vpc_cidr_block}"
  nat_gateway_enabled = "true"
}

module "rds_instance" {
  source                      = "git::https://github.com/cloudposse/terraform-aws-rds.git?ref=master"
  namespace                   = "${var.namespace}"
  stage                       = "${var.stage}"
  name                        = "${var.name}"
  dns_zone_id                 = "${var.zone_id}"
  host_name                   = "${var.name}-db"
  security_group_ids          = "${list(module.elastic_beanstalk_environment.security_group_id)}"
  database_name               = "${var.name}"
  database_user               = "${var.name}"
  database_password           = "${var.rds_password}"
  database_port               = "${var.rds_port}" # 5432
  multi_az                    = "${var.rds_multi_az}" # true
  storage_type                = "${var.rds_storage_type}" # gp2
  allocated_storage           = "${var.rds_allocated_storage}" # 100
  storage_encrypted           = "${var.rds_storage_encrypted}" # true
  engine                      = "${var.rds_engine}"
  engine_version              = "${var.rds_version}"
  instance_class              = "${var.rds_instance_class}" # db.t2.medium
  db_parameter_group          = "${var.rds_parameter_group}"
  parameter_group_name        = "${var.rds_parameter_group_name}"
  publicly_accessible         = "false"
  subnet_ids                  = "${module.subnets.private_subnet_ids}"
  vpc_id                      = "${module.vpc.vpc_id}"
  snapshot_identifier         = "${var.rds_snapshot_identifier}"
  auto_minor_version_upgrade  = "true"
  allow_major_version_upgrade = "false"
  apply_immediately           = "false"
  maintenance_window          = "Mon:03:00-Mon:04:00"
  skip_final_snapshot         = "false"
  copy_tags_to_snapshot       = "true"
  backup_retention_period     = 7
  backup_window               = "22:00-03:00"
}
