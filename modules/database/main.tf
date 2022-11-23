resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = var.datasubnetids

  tags = {
    Name = "Database subnet group"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage      = 10
  db_subnet_group_name   = aws_db_subnet_group.default.id
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  multi_az               = false
  name                   = "rdsdb"
  username               = "rdsuser"
  password               = "TTN12345678"
  skip_final_snapshot    = true
  vpc_security_group_ids = var.sgid
}