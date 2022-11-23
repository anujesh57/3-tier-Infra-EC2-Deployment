resource "aws_internet_gateway" "ingw" {
  vpc_id = var.vpc
}