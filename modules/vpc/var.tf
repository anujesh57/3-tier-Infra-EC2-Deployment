variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "tenancy" {
  default = "dedicated"
}

variable "vpc_id" {}

variable "subnet_cidr1" {
  default = "10.0.1.0/24"
}


variable "subnet_cidr2" {
  default = "10.0.2.0/24"
}

variable "database1_cidr" {
  default = "10.0.3.0/24"
}

variable "database2_cidr" {
  default = "10.0.4.0/24"
}
variable "gatewayid" {
  
}