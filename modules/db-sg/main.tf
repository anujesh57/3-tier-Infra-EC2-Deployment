resource "aws_security_group" "db-sg" {
  name        = "Database SG"
  description = "Allow inbound traffic from application layer"
  vpc_id      = var.Vpcid

  ingress {
    description     = "Allow traffic from application layer"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = var.webid
  }

  egress {
    from_port   = 32768
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Database SG"
  }
}