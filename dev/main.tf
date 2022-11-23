terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  profile = "practice"
  region  = "ap-south-1"
}



module "my_vpc" {
  source         = "../modules/vpc"
  vpc_cidr       = "192.168.0.0/16"
  tenancy        = "default"
  vpc_id         = "${module.my_vpc.vpc_id}"
  subnet_cidr1   = "192.168.1.0/24"
  subnet_cidr2   = "192.168.2.0/24"
  database1_cidr = "192.168.3.0/24"
  database2_cidr = "192.168.4.0/24"
  gatewayid      = module.ingw.gateid
}

module "database" {
  source        = "../modules/database"
  subnet_id     = module.my_vpc.subnetid
  datasubnetids = [module.my_vpc.datasubnet1, module.my_vpc.datasubnet2]
  sgid          = [module.db-sg.dbsgid]


}
module "db-sg" {
  source = "../modules/db-sg"
  webid  = [module.my_vpc.sgid]
  Vpcid  = module.my_vpc.vpcid
}
module "ingw" {
  source = "../modules/ingw"
  vpc    = module.my_vpc.vpcid
}
module "alb" {
  source = "../modules/alb"
  websgid = [module.my_vpc.sgid]
  websubnet = [module.my_vpc.websubnet1, module.my_vpc.websubnet2]
  vpcid = module.my_vpc.vpcid
}
